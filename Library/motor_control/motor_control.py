# Motor Controlling
# Last Modify : 12/08/2019
# Last Edit by : Yoolaibeef K.
# Note : -
# Status : -

import pyb
from pyb import Pin, Timer
from pyb import Pin, ExtInt
from pyb import Pin

class MOBILE:

	def __init__(self):

		self.target = 0
		self.const_val = ((3.14*4.5)*7)*7
		self.cirucmference = (3.14*4.5)
		self.robot_cirucmference = (3.14*12.3)

		self.pos_r = 0
		self.pos_l = 0

		self.countR_C1 = 0
		self.countL_C1 = 0

		#Pin settings
		#-----------------------------------------------
		#|AIn1|AIn2|BIn1|BIn2|STB|TIM|PWMA|PWMB|CHA|CHB|
		#|H6  |I8  |C2  |C3  |C1 | 5 |H11 |H12 | 2 | 3 |
		#-----------------------------------------------

		#Mortor STBY
		self.Mortor_STBY = Pin('C1', Pin.OUT_PP)
		self.Mortor_STBY.low()

		#MortorA (Left)
		self.pwmA = Pin('H11') #PWM_A
		self.MortorA_IN1 = Pin('H6', Pin.OUT_PP)
		self.MortorA_IN2 = Pin('I8', Pin.OUT_PP)
		self.MortorA_C1 = Pin('B5')
		self.MortorA_C2 = Pin('B13')

		#MortorB (Right)
		self.pwmB = Pin('H12') #PWM_B
		self.MortorB_IN1 = Pin('C2', Pin.OUT_PP)
		self.MortorB_IN2 = Pin('C3', Pin.OUT_PP)
		self.MortorB_C1 = Pin('A3')
		self.MortorB_C2 = Pin('A2')

		self.tim5 = Timer(5, freq=1000)
		self.tim5_ch2 = self.tim5.channel(2, Timer.PWM, pin=self.pwmA)
		self.tim5_ch3 = self.tim5.channel(3, Timer.PWM, pin=self.pwmB)

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
				self.pos_r += 1 
			else:
				self.pos_r -= 1
		else:
			if (self.MortorB_C2.value()):
				self.pos_r += 1 
			else:
				self.pos_r -= 1

	def mrc2_in_callback(self,line): #Motor R C2
		if self.MortorB_C2.value():
			if (self.MortorB_C1.value()):
				self.pos_r += 1
			else:
				self.pos_r -= 1
		else:
			if self.MortorB_C1.value() == 0:
				self.pos_r += 1 
			else:
				self.pos_r -= 1

	def mlc1_in_callback(self,line): #Motor L C1
		if self.MortorA_C1.value():
			if self.MortorA_C2.value() == 0:
				self.pos_l += 1 
			else:
				self.pos_l -= 1
		else:
			if (self.MortorA_C2.value()):
				self.pos_l += 1 
			else:
				self.pos_l -= 1

	def mlc2_in_callback(self,line): #Motor L C2
		if self.MortorA_C2.value():
			if (self.MortorA_C1.value()):
				self.pos_l += 1
			else:
				self.pos_l -= 1
		else:
			if self.MortorA_C1.value() == 0:
				self.pos_l += 1 
			else:
				self.pos_l -= 1

	def raw_forward(self,motor,pwm):
		if motor == 1:
			self.Mortor_STBY.high()
			self.MortorA_IN1.high()
			self.MortorA_IN2.low()
			self.tim5_ch2.pulse_width_percent(pwm)
		elif motor == 2:
			self.Mortor_STBY.high()
			self.MortorB_IN1.low()
			self.MortorB_IN2.high()
			self.tim5_ch3.pulse_width_percent(pwm)

	def raw_backward(self,motor,pwm):
		if motor == 1:
			self.Mortor_STBY.high()
			self.MortorA_IN1.low()
			self.MortorA_IN2.high()
			self.tim5_ch2.pulse_width_percent(pwm)
		elif motor == 2:
			self.Mortor_STBY.high()
			self.MortorB_IN1.high()
			self.MortorB_IN2.low()
			self.tim5_ch3.pulse_width_percent(pwm)

	def mforward(self,value):
		condition = True
		Lock_R = False
		Lock_L = False
		max_err = 1
		min_err = -1
		self.pos_r = 0
		self.pos_l = 0
		self.target = ((value*self.const_val)/self.cirucmference)
		self.forward_control(60,60)
		
		while (condition):

			R_roll = self.pos_r
			L_roll = self.pos_l	

			error_R = self.target - R_roll
			error_L = self.target - L_roll

			if (error_R > max_err):
				if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
					self.raw_forward(2,70)	#R
				elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
					self.raw_forward(2,80)	#R
				elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
					self.raw_forward(2,80)	#R
				elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
					self.raw_forward(2,60)	#R
				elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
					self.raw_forward(2,50)	#R
				elif (error_R < (self.target*10)/100 and error_R > (self.target*5)/100):
					self.raw_forward(2,40)	#R
				elif (error_R < (self.target*5)/100):
					self.raw_forward(2,30)	#R

			elif (error_R < min_err):
				if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
					self.raw_backward(2,70)	#R
				elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
					self.raw_backward(2,80)	#R
				elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
					self.raw_backward(2,80)	#R
				elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
					self.raw_backward(2,60)	#R
				elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
					self.raw_backward(2,50)	#R
				elif (error_R < (self.target*10)/100 and error_R > (self.target*5)/100):
					self.raw_backward(2,40)	#R
				elif (error_R < (self.target*5)/100):
					self.raw_backward(2,30)	#R
			elif (error_R >= min_err and error_R <= max_err):
				Lock_R = True
				self.raw_backward(2,0)	#R

			if (error_L > max_err):
				if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
					self.raw_forward(1,70)	#L
				elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
					self.raw_forward(1,80)	#L
				elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
					self.raw_forward(1,80)	#L
				elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
					self.raw_forward(1,60)	#L
				elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
					self.raw_forward(1,50)	#L
				elif (error_L < (self.target*10)/100 and error_L > (self.target*5)/100):
					self.raw_forward(1,40)	#L
				elif (error_L < (self.target*5)/100):
					self.raw_forward(1,30)	#L

			elif (error_L < min_err):
				if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
					self.raw_backward(1,70)	#L
				elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
					self.raw_backward(1,80)	#L
				elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
					self.raw_backward(1,80)	#L
				elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
					self.raw_backward(1,60)	#L
				elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
					self.raw_backward(1,50)	#L
				elif (error_L < (self.target*10)/100 and error_L > (self.target*5)/100):
					self.raw_backward(1,40)	#L
				elif (error_L < (self.target*5)/100):
					self.raw_backward(1,30)	#L
					
			elif (error_L >= min_err and error_L <= max_err):
				Lock_L = True
				self.raw_backward(1,0)	#L

			print("error_R = "+str(error_R) + "    error_L = "+str(error_L))

			if (Lock_L == True and Lock_R == True):
				condition = False
				print("error_R = "+str(error_R) + "    error_L = "+str(error_L))
				self.stop()

	def forward(self,value):
		condition = True
		Lock_R = False
		Lock_L = False
		self.countR_C1 = 0
		self.countL_C1 = 0
		max_err = 1
		min_err = -1
		self.target = ((value*self.const_val)/self.cirucmference)
		self.forward_control(60,60)
		
		while (condition):

			R_roll = self.countR_C1
			L_roll = self.countL_C1	

			error_R = self.target - R_roll
			error_L = self.target - L_roll		

			if (error_R > max_err):
				if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
					self.raw_forward(2,70)	#R
				elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
					self.raw_forward(2,80)	#R
				elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
					self.raw_forward(2,80)	#R
				elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
					self.raw_forward(2,60)	#R
				elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
					self.raw_forward(2,50)	#R
				elif (error_R < (self.target*10)/100 and error_R > (self.target*5)/100):
					self.raw_forward(2,40)	#R
				elif (error_R < (self.target*5)/100):
					self.raw_forward(2,30)	#R
			elif (error_R <= max_err):
				Lock_R = True
				self.raw_forward(2,30)	#R

			if (error_L > max_err):
				if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
					self.raw_forward(1,70)	#L
				elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
					self.raw_forward(1,80)	#L
				elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
					self.raw_forward(1,80)	#L
				elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
					self.raw_forward(1,60)	#L
				elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
					self.raw_forward(1,50)	#L
				elif (error_L < (self.target*10)/100 and error_L > (self.target*5)/100):
					self.raw_forward(1,40)	#L
				elif (error_L < (self.target*5)/100):
					self.raw_forward(1,30)	#L
			elif (error_L <= max_err):
				Lock_L = True
				self.raw_forward(1,30)	#L

			if (Lock_L == True and Lock_R == True):
				condition = False
				print("error_R = "+str(error_R) + "    error_L = "+str(error_L))
				self.stop()

	def backward(self,value):
		condition = True
		Lock_R = False
		Lock_L = False
		self.countR_C1 = 0
		self.countL_C1 = 0
		max_err = 1
		min_err = -1
		self.target = ((value*self.const_val)/self.cirucmference)
		self.backward_control(60,60)
		
		while (condition):

			R_roll = self.countR_C1
			L_roll = self.countL_C1	

			error_R = self.target - R_roll
			error_L = self.target - L_roll		

			if (error_R > max_err):
				if (error_R < (self.target*90)/100 and error_R > (self.target*80)/100):
					self.raw_backward(2,70)	#R
				elif (error_R < (self.target*80)/100 and error_R > (self.target*60)/100):
					self.raw_backward(2,80)	#R
				elif (error_R < (self.target*60)/100 and error_R > (self.target*40)/100):
					self.raw_backward(2,80)	#R
				elif (error_R < (self.target*40)/100 and error_R > (self.target*20)/100):
					self.raw_backward(2,60)	#R
				elif (error_R < (self.target*20)/100 and error_R > (self.target*10)/100):
					self.raw_backward(2,50)	#R
				elif (error_R < (self.target*10)/100 and error_R > (self.target*5)/100):
					self.raw_backward(2,40)	#R
				elif (error_R < (self.target*5)/100):
					self.raw_backward(2,30)	#R
			elif (error_R <= max_err):
				Lock_R = True
				self.raw_backward(2,30)	#R

			if (error_L > max_err):
				if (error_L < (self.target*90)/100 and error_L > (self.target*80)/100):
					self.raw_backward(1,70)	#L
				elif (error_L < (self.target*80)/100 and error_L > (self.target*60)/100):
					self.raw_backward(1,80)	#L
				elif (error_L < (self.target*60)/100 and error_L > (self.target*40)/100):
					self.raw_backward(1,80)	#L
				elif (error_L < (self.target*40)/100 and error_L > (self.target*20)/100):
					self.raw_backward(1,60)	#L
				elif (error_L < (self.target*20)/100 and error_L > (self.target*10)/100):
					self.raw_backward(1,50)	#L
				elif (error_L < (self.target*10)/100 and error_L > (self.target*5)/100):
					self.raw_backward(1,40)	#L
				elif (error_L < (self.target*5)/100):
					self.raw_backward(1,30)	#L
			elif (error_L <= max_err):
				Lock_L = True
				self.raw_backward(1,30)	#L

			if (Lock_L == True and Lock_R == True):
				condition = False
				print("error_R = "+str(error_R) + "    error_L = "+str(error_L))
				self.stop()

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
		self.MortorA_IN1.high()
		self.MortorA_IN2.high()
		self.tim8_ch1.pulse_width_percent(0)
		self.MortorB_IN1.high()
		self.MortorB_IN2.high()
		self.tim8_ch4.pulse_width_percent(0)

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
