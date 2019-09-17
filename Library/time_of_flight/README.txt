version : 1.0
Last Edit : Matenut
Note : ทำงานได้แล้ว 
Status : DONE
===============
SIMPLE CODE
--------------
import pyb, time
import machine
import vl6180

I2C_4 = machine.I2C(4)

tof = vl6180.VL6180(I2C_4)

usb = pyb.USB_VCP()
while (usb.isconnected() == False):
	tof_value = tof.read_range()
	value_map = translate(tof_value, 0, 255, 0, 99)

def translate(value, leftMin, leftMax, rightMin, rightMax):
	leftSpan = leftMax - leftMin
	rightSpan = rightMax - rightMin
	valueScaled = float(value - leftMin) / float(leftSpan))
	return rightMin + (valueScaled * rightSpan)
--------------



