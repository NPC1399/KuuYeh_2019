# Motor Controlling
# Last Modify : 06/09/2019
# Last Edit by : film_monkey
# Note : -
# Status : -

import pyb
from pyb import Pin, Timer
from pyb import Pin, ExtInt
from pyb import Pin
from pyb import UART

class MOTOR:

	def __init__(self):

		#Wheel Setting
		self.target = 0
		self.const_val = ((3.14*4.5)*7)*7
		self.const_valA = 2085
		self.const_valB = 2085
		self.const_rotate = 27.3/360 
		self.cirucmference = 13.5#3.14*2*4.35#(3.14*4.5)
		self.robot_cirucmference = (3.14*12.3)

		self.pos_b = 0
		self.pos_a = 0

		self.countR_C1 = 0
		self.countL_C1 = 0

		#PID_ALL Setting
		self.lastTime = 0
		self.kp = 10
		self.ki = 0
		self.kd = 0

		#PID_B Setting
		self.FeedbackB = 0
		self.OutputB = 0
		self.SetpointB = 0
		self.errSumB = 0
		self.lastErrB = 0
		self.ITermB = 0
		self.lastinputB = 0
		self.count_timeB = 0
		self.acceptedErrorB = 5

		#PID Setting
		self.FeedbackA = 0
		self.OutputA = 0
		self.SetpointA = 0
		self.errSumA = 0
		self.lastErrA = 0
		self.ITermA = 0
		self.lastinputA = 0
		self.count_timeA = 0
		self.acceptedErrorA = 5

				#Pin settings
		#---------------------------------------------------
		#|AIn1|AIn2| BIn1 | BIn2 |STB|TIM|PWMA|PWMB|CHA|CHB|
		#| H6 | I8 |C2->C3|C3->C2|C1 | 5 |H11 |H12 | 2 | 3 |
		#---------------------------------------------------

		#Mortor STBY
		self.Mortor_STBY = Pin('C1', Pin.OUT_PP)
		self.Mortor_STBY.low()

		#MortorA
		self.PWMA_PIN = Pin('H11') #PWM_A
		self.MortorA_IN1 = Pin('H6', Pin.OUT_PP)
		self.MortorA_IN2 = Pin('I8', Pin.OUT_PP)
		self.MortorA_C1 = Pin('B5')
		self.MortorA_C2 = Pin('B13')

		#MortorB
		self.PWMB_PIN = Pin('H12') #PWM_B
		self.MortorB_IN1 = Pin('C3', Pin.OUT_PP)
		self.MortorB_IN2 = Pin('C2', Pin.OUT_PP)
		self.MortorB_C2 = Pin('A3')
		self.MortorB_C1 = Pin('A2')#swich A3<->A2

		self.tim5 = Timer(5, freq=1000)
		self.PWMA = self.tim5.channel(2, Timer.PWM, pin=self.PWMA_PIN)
		self.PWMB = self.tim5.channel(3, Timer.PWM, pin=self.PWMB_PIN)

		#Initialize
		#Open interrupt both of motor A and B including phase A and B
		self.interrupt_setAB()
		#Setup PID value
		#kp = 5, ki = 0.001, kd = 100
		self.SetTunings(5.0,0.005,500,5)

		#self.uart = UART(2, 115200)

	def interrupt_setAB(self):
		self.interrupt_disable()
		self.ml1_interrupt = pyb.ExtInt(self.MortorA_C1, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, self.mlc1_in_callback)
		self.ml2_interrupt = pyb.ExtInt(self.MortorA_C2, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, self.mlc2_in_callback)

		self.mr1_interrupt = pyb.ExtInt(self.MortorB_C1, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, self.mrc1_in_callback)
		self.mr2_interrupt = pyb.ExtInt(self.MortorB_C2, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, self.mrc2_in_callback)
	
	def interrupt_setA(self):
		self.interrupt_disable()
		self.ml1_interrupt = pyb.ExtInt(self.MortorA_C1, pyb.ExtInt.IRQ_RISING, pyb.Pin.PULL_NONE, self.mlc1_inA_callback)
		self.mr1_interrupt = pyb.ExtInt(self.MortorB_C1, pyb.ExtInt.IRQ_RISING, pyb.Pin.PULL_NONE, self.mrc1_inA_callback)

	def interrupt_disable(self):
		self.ml1_interrupt = pyb.ExtInt(self.MortorA_C1, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, None)
		self.ml2_interrupt = pyb.ExtInt(self.MortorA_C2, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, None)

		self.mr1_interrupt = pyb.ExtInt(self.MortorB_C1, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, None)
		self.mr2_interrupt = pyb.ExtInt(self.MortorB_C2, pyb.ExtInt.IRQ_RISING_FALLING, pyb.Pin.PULL_NONE, None)

	def mrc1_inA_callback(self,line): #Motor R C1
		self.countR_C1 = self.countR_C1+1

	def mlc1_inA_callback(self,line): #Motor L C1
		self.countL_C1 = self.countL_C1+1
		
		
	def mrc1_in_callback(self,line): #Motor R C1
		if self.MortorB_C1.value():
			if self.MortorB_C2.value() == 0:
				self.pos_b += 1 
			else:
				self.pos_b -= 1
		else:
			if (self.MortorB_C2.value()):
				self.pos_b += 1 
			else:
				self.pos_b -= 1

	def mrc2_in_callback(self,line): #Motor R C2
		if self.MortorB_C2.value():
			if (self.MortorB_C1.value()):
				self.pos_b += 1
			else:
				self.pos_b -= 1
		else:
			if self.MortorB_C1.value() == 0:
				self.pos_b += 1 
			else:
				self.pos_b -= 1

	def mlc1_in_callback(self,line): #Motor L C1
		if self.MortorA_C1.value():
			if self.MortorA_C2.value() == 0:
				self.pos_a += 1 
			else:
				self.pos_a -= 1
		else:
			if (self.MortorA_C2.value()):
				self.pos_a += 1 
			else:
				self.pos_a -= 1

	def mlc2_in_callback(self,line): #Motor L C2
		if self.MortorA_C2.value():
			if (self.MortorA_C1.value()):
				self.pos_a += 1
			else:
				self.pos_a -= 1
		else:
			if self.MortorA_C1.value() == 0:
				self.pos_a += 1 
			else:
				self.pos_a -= 1

	def raw_forward(self,motor,pwm):
		if motor == 1:
			self.Mortor_STBY.high()
			self.MortorA_IN1.high()
			self.MortorA_IN2.low()
			self.PWMA.pulse_width_percent(pwm)
		elif motor == 2:
			self.Mortor_STBY.high()
			self.MortorB_IN1.low()
			self.MortorB_IN2.high()
			self.PWMB.pulse_width_percent(pwm)

	def raw_backward(self,motor,pwm):
		if motor == 1:
			self.Mortor_STBY.high()
			self.MortorA_IN1.low()
			self.MortorA_IN2.high()
			self.PWMA.pulse_width_percent(pwm)
		elif motor == 2:
			self.Mortor_STBY.high()
			self.MortorB_IN1.high()
			self.MortorB_IN2.low()
			self.PWMB.pulse_width_percent(pwm)


	def forward(self,value):
		condition = True
		errortimeChangeA = 0
		errortimeChangeB = 0

		self.targetB = ((value*self.const_valB)/self.cirucmference)
		self.SetpointB = self.targetB * 4
		self.targetA = ((value*self.const_valA)/self.cirucmference)
		self.SetpointA = self.targetA * 4
		self.pos_b = 0
		self.pos_a = 0

		while (condition):
			now = pyb.millis()
			timeChange = now - self.lastTime
			self.FeedbackB = self.pos_b
			self.FeedbackA = self.pos_a

			#Compute all working error variables
			errorB = self.SetpointB - self.FeedbackB
			errorA = self.SetpointA - self.FeedbackA

			#PID_B
			if (errorB >= 0 and errortimeChangeB < 10):
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB
				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)
				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB
				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100
				self.raw_forward(2,self.OutputB)
			elif (errorB < 0 and errortimeChangeB < 10):
				errorB = errorB * (-1)
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB

				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)

				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB

				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100

				self.raw_backward(2,self.OutputB)

			#PID_A
			if (errorA >= 0 and errortimeChangeA < 10):
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_forward(1,self.OutputA)
			elif (errorA < 0 and errortimeChangeA < 10):
				errorA = errorA * (-1)
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_backward(1,self.OutputA)

			#finite B
			if (errorB >= -self.acceptedErrorB and errorB <= self.acceptedErrorB):
				errortimeChangeB += 1
			else:
				errortimeChangeB = 0
			if (errortimeChangeB >= 10):
					self.PWMB.pulse_width_percent(0)

			#finite A
			if (errorA >= -self.acceptedErrorA and errorA <= self.acceptedErrorA):
				errortimeChangeA += 1
			else:
				errortimeChangeA = 0

			if (errortimeChangeA >= 10):
					self.PWMA.pulse_width_percent(0)
					
			if (errortimeChangeB >= 10 and errortimeChangeA>= 10):
				condition = False
			#Remember some variables for next time
			self.lastErrB = errorB
			self.lastErrA = errorA
			self.lastTime = now
			#self.uart.write(str(self.FeedbackB)+','+str(self.Setpoint)+','+str(self.Output)+'\r\n')


	def backward(self,value):
		condition = True
		errortimeChangeA = 0
		errortimeChangeB = 0

		self.targetB = ((value*self.const_valB)/self.cirucmference)
		self.SetpointB = self.targetB * 4
		self.targetA = ((value*self.const_valA)/self.cirucmference)
		self.SetpointA = self.targetA * 4
		self.pos_b = 0
		self.pos_a = 0

		while (condition):
			now = pyb.millis()
			timeChange = now - self.lastTime
			self.FeedbackB = self.pos_b*(-1)
			self.FeedbackA = self.pos_a*(-1)

			#Compute all working error variables
			errorB = self.SetpointB - self.FeedbackB
			errorA = self.SetpointA - self.FeedbackA

			#PID_B
			if (errorB >= 0 and errortimeChangeB < 10):
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB
				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)
				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB
				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100
				self.raw_backward(2,self.OutputB)
			elif (errorB < 0 and errortimeChangeB < 10):
				errorB = errorB * (-1)
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB

				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)

				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB

				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100

				self.raw_forward(2,self.OutputB)

			#PID_A
			if (errorA >= 0 and errortimeChangeA < 10):
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_backward(1,self.OutputA)
			elif (errorA < 0 and errortimeChangeA < 10):
				errorA = errorA * (-1)
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_forward(1,self.OutputA)

			#finite B
			if (errorB >= -self.acceptedErrorB and errorB <= self.acceptedErrorB):
				errortimeChangeB += 1
			else:
				errortimeChangeB = 0
			if (errortimeChangeB >= 10):
					self.PWMB.pulse_width_percent(0)

			#finite A
			if (errorA >= -self.acceptedErrorA and errorA <= self.acceptedErrorA):
				errortimeChangeA += 1
			else:
				errortimeChangeA = 0

			if (errortimeChangeA >= 10):
					self.PWMA.pulse_width_percent(0)
					
			if (errortimeChangeB >= 10 and errortimeChangeA>= 10):
				condition = False
			#Remember some variables for next time
			self.lastErrB = errorB
			self.lastErrA = errorA
			self.lastTime = now
			#self.uart.write(str(self.FeedbackB)+','+str(self.Setpoint)+','+str(self.Output)+'\r\n')

	def rotateleft(self,value):
		condition = True
		errortimeChangeA = 0
		errortimeChangeB = 0

		self.targetB = ((value*self.const_valB)/self.cirucmference)*self.const_rotate
		self.SetpointB = self.targetB * 4
		self.targetA = ((value*self.const_valA)/self.cirucmference)*self.const_rotate
		self.pos_b = 0
		self.pos_a = 0

		while (condition):
			now = pyb.millis()
			timeChange = now - self.lastTime
			self.FeedbackB = self.pos_b
			self.FeedbackA = self.pos_a * (-1)

			#Compute all working error variables
			errorB = self.SetpointB - self.FeedbackB
			errorA = self.SetpointA - self.FeedbackA

			#PID_B
			if (errorB >= 0 and errortimeChangeB < 10):
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB
				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)
				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB
				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100
				self.raw_forward(2,self.OutputB)
			elif (errorB < 0 and errortimeChangeB < 10):
				errorB = errorB * (-1)
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB

				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)

				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB

				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100

				self.raw_backward(2,self.OutputB)

			#PID_A
			if (errorA >= 0 and errortimeChangeA < 10):
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_backward(1,self.OutputA)
			elif (errorA < 0 and errortimeChangeA < 10):
				errorA = errorA * (-1)
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_forward(1,self.OutputA)


			#finite B
			if (errorB >= -self.acceptedErrorB and errorB <= self.acceptedErrorB):
				errortimeChangeB += 1
			else:
				errortimeChangeB = 0
			if (errortimeChangeB >= 10):
					self.PWMB.pulse_width_percent(0)

			#finite A
			if (errorA >= -self.acceptedErrorA and errorA <= self.acceptedErrorA):
				errortimeChangeA += 1
			else:
				errortimeChangeA = 0

			if (errortimeChangeA >= 10):
					self.PWMA.pulse_width_percent(0)
					
			if (errortimeChangeB >= 10 and errortimeChangeA>= 10):
				condition = False
			#Remember some variables for next time
			self.lastErrB = errorB
			self.lastErrA = errorA
			self.lastTime = now
			#self.uart.write(str(self.FeedbackB)+','+str(self.Setpoint)+','+str(self.Output)+'\r\n')

	def rotateright(self,value):
		condition = True
		errortimeChangeA = 0
		errortimeChangeB = 0

		self.targetB = ((value*self.const_valB)/self.cirucmference)*self.const_rotate
		self.SetpointB = self.targetB * 4
		self.targetA = ((value*self.const_valA)/self.cirucmference)*self.const_rotate
		self.SetpointA = self.targetA * 4
		self.pos_b = 0
		self.pos_a = 0

		while (condition):
			now = pyb.millis()
			timeChange = now - self.lastTime
			self.FeedbackB = self.pos_b * (-1)
			self.FeedbackA = self.pos_a

			#Compute all working error variables
			errorB = self.SetpointB - self.FeedbackB
			errorA = self.SetpointA - self.FeedbackA

			#PID_B
			if (errorB >= 0 and errortimeChangeB < 10):
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB
				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)
				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB
				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100
				self.raw_backward(2,self.OutputB)
			elif (errorB < 0 and errortimeChangeB < 10):
				errorB = errorB * (-1)
				self.errSumB = self.errSumB + (errorB * timeChange)
				self.ITermB = self.ki * self.errSumB

				if (self.ITermB < -100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				if (self.ITermB > 100):
					self.errSumB = (self.ITermB/self.ki) - (errorB * timeChange)
				dInputB = (errorB - self.lastErrB)

				#Compute PI Output
				self.OutputB = self.kp * errorB + self.ITermB + self.kd * dInputB

				if (self.OutputB < 0):
					self.OutputB = 0
				elif (self.OutputB > 100):
					self.OutputB = 100

				self.raw_forward(2,self.OutputB)

			#PID_A
			if (errorA >= 0 and errortimeChangeA < 10):
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_forward(1,self.OutputA)
			elif (errorA < 0 and errortimeChangeA < 10):
				errorA = errorA * (-1)
				self.errSumA = self.errSumA + (errorA * timeChange)
				self.ITermA = self.ki * self.errSumA

				if (self.ITermA < -100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				if (self.ITermA > 100):
					self.errSumA = (self.ITermA/self.ki) - (errorA * timeChange)
				dInputA = (errorA - self.lastErrA)

				#Compute PI Output
				self.OutputA = self.kp * errorA + self.ITermA + self.kd * dInputA

				if (self.OutputA < 0):
					self.OutputA = 0
				elif (self.OutputA > 100):
					self.OutputA = 100

				self.raw_backward(1,self.OutputA)

			#finite B
			if (errorB >= -self.acceptedErrorB and errorB <= self.acceptedErrorB):
				errortimeChangeB += 1
			else:
				errortimeChangeB = 0
			if (errortimeChangeB >= 10):
					self.PWMB.pulse_width_percent(0)

			#finite A
			if (errorA >= -self.acceptedErrorA and errorA <= self.acceptedErrorA):
				errortimeChangeA += 1
			else:
				errortimeChangeA = 0

			if (errortimeChangeA >= 10):
					self.PWMA.pulse_width_percent(0)
					
			if (errortimeChangeB >= 10 and errortimeChangeA>= 10):
				condition = False
			#Remember some variables for next time
			self.lastErrB = errorB
			self.lastErrA = errorA
			self.lastTime = now
			#self.uart.write(str(self.FeedbackB)+','+str(self.Setpoint)+','+str(self.Output)+'\r\n')


	def turnright(self,value):

		if (value <= 360 and value >= 0):
			condition = True
			Lock_R = False
			Lock_L = False
			self.countR_C1 = 0
			self.countL_C1 = 0
			max_err = 1
			min_err = -1	
			x = (self.robot_cirucmference*self.const_val)/self.cirucmference
			self.target = ((value*x)/360)

			self.right_control(60,60)

			while (condition):

				R_roll = self.countR_C1
				L_roll = self.countL_C1

				error_R = self.target - R_roll
				error_L = self.target - L_roll

				if (error_R > max_err):
					if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
						self.raw_backward(2,70)	#R
					elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
						self.raw_backward(2,60)	#R
					elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
						self.raw_backward(2,50)	#R
					elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
						self.raw_backward(2,40)	#R
					elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
						self.raw_backward(2,30)	#R
				elif (error_R <= max_err):
					Lock_R = True
					self.raw_backward(2,30)	#R

				if (error_L > max_err):
					if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
						self.raw_forward(1,70)	#L
					elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
						self.raw_forward(1,60)	#L
					elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
						self.raw_forward(1,50)	#L
					elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
						self.raw_forward(1,40)	#L
					elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
						self.raw_forward(1,30)	#L
				elif (error_L <= max_err):
					Lock_L = True
					self.raw_forward(1,30)	#L

				if (Lock_L == True and Lock_R == True):
					condition = False
					print("error_R = "+str(error_R) + "    error_L = "+str(error_L))
					self.stop()

		else:
			print("1-360 only")

	def turnleft(self,value):

		if (value <= 360 and value >= 0):
			condition = True
			Lock_R = False
			Lock_L = False
			self.countR_C1 = 0
			self.countL_C1 = 0
			max_err = 1
			min_err = -1
			x = (self.robot_cirucmference*self.const_val)/self.cirucmference
			self.target = ((value*x)/360)

			self.left_control(60,60)

			while (condition):

				R_roll = self.countR_C1
				L_roll = self.countL_C1

				error_R = self.target - R_roll
				error_L = self.target - L_roll

				if (error_R > max_err):
					if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
						self.raw_forward(2,70)	#R
					elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
						self.raw_forward(2,60)	#R
					elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
						self.raw_forward(2,50)	#R
					elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
						self.raw_forward(2,40)	#R
					elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
						self.raw_forward(2,30)	#R
				elif (error_R <= max_err):
					Lock_R = True
					self.raw_forward(2,30)	#R

				if (error_L > max_err):
					if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
						self.raw_backward(1,70)	#L
					elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
						self.raw_backward(1,60)	#L
					elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
						self.raw_backward(1,50)	#L
					elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
						self.raw_backward(1,40)	#L
					elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
						self.raw_backward(1,30)	#L
				elif (error_L <= max_err):
					Lock_L = True
					self.raw_backward(1,30)	#L

				if (Lock_L == True and Lock_R == True):
					condition = False
					print("error_R = "+str(error_R) + "    error_L = "+str(error_L))
					self.stop()
		else:
			print("1-360 only")

	def forward_always(self):
		self.raw_forward(1,100)
		self.raw_forward(2,100)

	def backward_always(self):
		self.raw_backward(1,100)
		self.raw_backward(2,100)

	def right_always(self):
		self.raw_forward(1,100)
		self.raw_backward(2,100)

	def left_always(self):
		self.raw_backward(1,100)
		self.raw_forward(2,100)

	def stop(self):
		self.Mortor_STBY.high()
		self.MortorA_IN1.low()
		self.MortorA_IN2.low()
		self.PWMA.pulse_width_percent(0)
		self.MortorB_IN1.low()
		self.MortorB_IN2.low()
		self.PWMB.pulse_width_percent(0)

	def forward_control(self,value_L,value_R):
		self.raw_forward(1,value_L)
		self.raw_forward(2,value_R)

	def backward_control(self,value_L,value_R):
		self.raw_backward(1,value_L)
		self.raw_backward(2,value_R)

	def right_control(self,value_L,value_R):
		self.raw_forward(1,value_L)
		self.raw_backward(2,value_R)

	def left_control(self,value_L,value_R):
		self.raw_backward(1,value_L)
		self.raw_forward(2,value_R)

	def SetTunings(self, kp, ki, kd, acceptedError):
		self.kp = kp
		self.ki = ki
		self.kd= kd
		self.acceptedError = acceptedError

	def pos(self):
		return [self.pos_b,self.pos_a]
