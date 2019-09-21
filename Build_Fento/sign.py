import pyb
import is31fl3731

class Signs:
	I2C_1 = None
	display = None
	i=0
	j=0
	def __init__(self,I2C):
		self.I2C_1 = I2C
		self.display = is31fl3731.Matrix(self.I2C_1)

	def tableledon(self,a,x,b,y):
		self.i=0
		self.j=0
		self.i=a
		while self.i<=x: #x
			self.j=b
			while self.j<=y: #y
				self.display.pixel(self.i,self.j,18)
				self.j=self.j+1
			self.i=self.i+1
	
	def tableledoff(self,a,x,b,y):
		self.i=0
		self.j=0
		self.i=a
		while self.i<=x: #x
			self.j=b
			while self.j<=y: #y
				self.display.pixel(self.i,self.j,0)
				self.j=self.j+1
			self.i=self.i+1

	def camsign(self):
		self.display.fill(0)
		self.tableledon(6,9,0,8)
		self.tableledon(1,14,1,8)
		self.tableledon(1,14,2,7)
		self.tableledoff(6,9,3,7)
		self.tableledoff(5,10,4,6)
		self.tableledoff(13,13,2,3)
		self.tableledon(7,8,5,5)

	def remotesign(self):
		self.display.fill(0)
		self.tableledon(0,15,0,8)
		self.tableledoff(11,12,1,6)
		self.tableledoff(9,14,3,4)
		self.tableledon(11,12,3,4)
		self.tableledoff(2,5,1,7)
		self.tableledoff(1,6,2,6)
		self.display.pixel(2,3,18)
		self.display.pixel(5,3,18)
		self.display.pixel(2,5,18)
		self.display.pixel(5,5,18)

	def forwardsign(self):
		self.display.fill(0)
		self.tableledon(7,9,1,8)
		self.tableledon(5,11,3,4)
		self.tableledon(6,10,2,4)
		self.tableledon(4,12,4,4)
		self.tableledon(8,8,0,8)

	def rightsign(self):
		self.display.fill(0)
		self.tableledon(4,11,3,5)
		self.tableledon(8,10,2,6)
		self.tableledon(8,9,1,7)
		self.tableledon(4,12,4,4)
		self.tableledon(8,8,0,8)

	def leftsign(self):
		self.display.fill(0)
		self.tableledon(4,11,3,5)
		self.tableledon(5,7,2,6)
		self.tableledon(6,7,1,7)
		self.tableledon(7,7,0,8)
		self.tableledon(3,11,4,4)

	def backwardsign(self):
		self.display.fill(0)
		self.tableledon(7,9,0,7)
		self.tableledon(5,11,4,5)
		self.tableledon(6,10,4,6)
		self.tableledon(4,12,4,4)
		self.tableledon(8,8,0,8)

	def farsign(self):
		self.display.fill(0)
		self.tableledon(0,3,0,1)
		self.tableledon(0,3,7,8)
		self.tableledon(0,1,0,8)
		self.tableledon(12,15,0,1)
		self.tableledon(12,15,7,8)
		self.tableledon(14,15,0,8)
	
	def closesign(self):
		self.display.fill(0)
		self.tableledon(3,6,0,1)
		self.tableledon(3,6,7,8)
		self.tableledon(3,4,0,8)
		self.tableledon(9,12,0,1)
		self.tableledon(9,12,7,8)
		self.tableledon(11,12,0,8)

	def eyecircle(self):
		self.display.fill(0)
		self.tableledon(4,5,1,4)
		self.tableledon(3,6,2,3)
		self.tableledon(10,11,1,4)
		self.tableledon(9,12,2,3)
	
	def mouthsmile(self):
		self.display.fill(0)
		self.tableledon(5,6,6,7)
		self.tableledon(10,11,6,7)
		self.tableledon(6,10,7,8)
		
	def eye(self):
		self.tableledon(2,6,2,6)
		self.tableledon(3,5,1,7)
		self.tableledon(9,13,2,6)
		self.tableledon(10,12,1,7)

	def eyenormal(self):
		self.display.fill(0)
		self.tableledon(2,6,2,6)
		self.tableledon(3,5,1,7)
		self.tableledon(9,13,2,6)
		self.tableledon(10,12,1,7)

	def closeled(self):
		self.display.fill(0)

	def blink(self):
		t=0
		for t in range(0, 3):
			self.display.fill(0)
			self.tableledon(3,5,6,6)
			self.tableledon(10,12,6,6)
			self.tableledon(2,2,7,7)
			self.tableledon(6,6,7,7)
			self.tableledon(9,9,7,7)
			self.tableledon(13,13,7,7)		 
			pyb.delay(300)
			self.display.fill(0)
			self.tableledon(2,6,2,6)
			self.tableledon(3,5,1,7)
			self.tableledon(9,13,2,6)
			self.tableledon(10,12,1,7)
			pyb.delay(300)
			self.display.fill(0)
	
	def feelshock(self):
		self.display.fill(0)
		self.tableledon(2,4,1,7)
		self.tableledon(0,6,3,5)
		self.tableledon(1,5,2,6)
		self.tableledoff(2,4,3,5)
		self.tableledon(11,13,1,7)
		self.tableledon(9,15,3,5)
		self.tableledon(10,14,2,6)
		self.tableledoff(11,13,3,5)

	def feellove(self):
		self.display.fill(0)
		self.tableledon(0,2,2,4)
		self.tableledon(4,6,2,4)
		self.tableledon(1,1,1,5)
		self.tableledon(5,5,1,5)
		self.tableledon(2,4,3,6)
		self.tableledon(3,3,3,7)
		
		self.tableledon(9,11,2,4)
		self.tableledon(13,15,2,4)
		self.tableledon(10,10,1,5)
		self.tableledon(14,14,1,5)
		self.tableledon(10,13,3,6)
		self.tableledon(12,12,3,7)
	
	def feelbore(self):
		self.display.fill(0)
		self.tableledon(1,6,3,4)
		self.tableledon(9,14,3,4)

	def feelangry(self):
		self.display.fill(0)
		self.tableledon(2,13,1,6)
		self.tableledon(3,5,7,7)
		self.tableledon(10,12,7,7)
		self.tableledoff(3,12,1,1)
		self.tableledoff(4,11,2,2)
		self.tableledoff(5,10,3,3)
		self.tableledoff(6,9,4,4)
		self.tableledoff(7,8,5,6)

	def feelhappy(self):
		self.display.fill(0)
		self.tableledon(3,5,3,3)
		self.tableledon(2,2,4,4)
		self.tableledon(6,6,4,4)
		self.tableledon(10,12,3,3)
		self.tableledon(9,9,4,4)
		self.tableledon(13,13,4,4)
