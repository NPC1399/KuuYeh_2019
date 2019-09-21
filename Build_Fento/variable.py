import pyb
from pyb import Switch
from pyb import Pin, ExtInt

class VALIABLE:

	sw_int = True

	def __init__(self):

		self.Con_Read = True
		self.sw = pyb.Switch()
	
	def int_sw(self):
		self.sw.callback(self.f)

	def dis_sw(self):
		self.sw.callback(None)

	def f(self):
		self.Con_Read = False
	