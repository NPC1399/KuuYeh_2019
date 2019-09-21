import is31fl3731
import machine
i2c_1 = machine.I2C(1)
class Display:
	def __init__(self):
		self.display = is31fl3731.Matrix(i2c_1)

	def DisplayC(self,A=[]):
		self.display.fill(0)
		for x in range(len(A)) :
			self.display.pixel(A[x][0],A[x][1],255)
	def close(self):
		self.display.fill(0)

	def open(self):
		self.display.fill(100)
