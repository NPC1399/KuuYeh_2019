import pyb
import is31fl3731
import machine

class Signs:
    I2C = None
    display = None
    i=0
    j=0
    def __init__(self):
        self.I2C = machine.I2C(2)
        self.display = is31fl3731.Matrix(self.I2C)
        self.led_fill_flag = 0

    def table_led_on(self,a,x,b,y):
        self.i=a
        while self.i<=x: #x
            self.j=b
            while self.j<=y: #y
                self.display.pixel(self.i,self.j,10)
                self.j=self.j+1
            self.i=self.i+1

    def led_off():
        self.display.fill(0)

    def table_led_off(self,a,x,b,y):
        self.i=a
        while self.i<=x: #x
            self.j=b
            while self.j<=y: #y
                self.display.pixel(self.i,self.j,0)
                self.j=self.j+1
            self.i=self.i+1

    def camsign(self):
        self.display.fill(0)
        self.table_led_on(3,13,1,6)
        self.table_led_on(7,9,0,1)
        self.table_led_off(7,9,3,5)
        self.table_led_off(4,5,2,2)
        self.table_led_on(8,8,4,4)
    def recordsign(self):
        self.display.fill(0)
        self.table_led_on(5,11,0,6)
        self.table_led_on(4,12,1,5)
        self.table_led_off(6,10,1,5)
        self.table_led_on(7,9,2,4)
        self.table_led_off(8,8,3,3)
    # def remotesign(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(0,15,0,8)
    # 	self.table_led_off(11,12,1,6)
    # 	self.table_led_off(9,14,3,4)
    # 	self.table_led_on(11,12,3,4)
    # 	self.table_led_off(2,5,1,7)
    # 	self.table_led_off(1,6,2,6)
    # 	self.display.pixel(2,3,18)
    # 	self.display.pixel(5,3,18)
    # 	self.display.pixel(2,5,18)
    # 	self.display.pixel(5,5,18)

    def forwardsign(self):
        self.display.fill(0)
        self.table_led_on(7,9,1,6)
        self.table_led_on(5,11,3,3)
        self.table_led_on(6,10,2,3)
        self.table_led_on(8,8,0,0)

    def leftsign(self):
        self.display.fill(0)
        self.table_led_on(5,10,2,4)
        self.table_led_on(8,9,1,5)
        self.table_led_on(11,11,3,3)
        self.table_led_on(8,8,0,6)

    def rightsign(self):
        self.display.fill(0)
        self.table_led_on(6,11,2,4)
        self.table_led_on(7,8,1,5)
        self.table_led_on(5,11,3,3)
        self.table_led_on(8,8,0,6)

    def backwardsign(self):
        self.display.fill(0)
        self.table_led_on(7,9,0,5)
        self.table_led_on(6,10,3,4)
        self.table_led_on(5,11,3,3)
        self.table_led_on(8,8,0,6)

    # def farsign(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(0,3,0,1)
    # 	self.table_led_on(0,3,7,8)
    # 	self.table_led_on(0,1,0,8)
    # 	self.table_led_on(12,15,0,1)
    # 	self.table_led_on(12,15,7,8)
    # 	self.table_led_on(14,15,0,8)

    # def closesign(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(3,6,0,1)
    # 	self.table_led_on(3,6,7,8)
    # 	self.table_led_on(3,4,0,8)
    # 	self.table_led_on(9,12,0,1)
    # 	self.table_led_on(9,12,7,8)
    # 	self.table_led_on(11,12,0,8)

    def eyenormal(self,):
        #print("eyenormal")
        if self.led_fill_flag == 0:
            self.display.fill(0)
        self.table_led_on(4,5,1,5)
        self.table_led_on(11,12,1,5)
        self.table_led_on(3,6,2,4)
        self.table_led_on(10,13,2,4)



    def eyeclose(self):
        self.display.fill(0)
        self.table_led_on(4,5,3,3)
        self.table_led_on(11,12,3,3)
        self.table_led_on(3,3,4,4)
        self.table_led_on(10,10,4,4)
        self.table_led_on(6,6,4,4)
        self.table_led_on(13,13,4,4)

    def eyeblink_fast(self,num):
        self.i=0
        for self.i in range(num):
            self.eyeclose()
            pyb.delay(300)
            self.eyenormal()
            pyb.delay(300)

    def eyeblink_slow(self,num):
        self.i=0
        for self.i in range(num):
            self.eyenormal()
            pyb.delay(2000)
            self.eyeblink_fast(2)




    # def feelshock(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(2,4,1,7)
    # 	self.table_led_on(0,6,3,5)
    # 	self.table_led_on(1,5,2,6)
    # 	self.table_led_off(2,4,3,5)
    # 	self.table_led_on(11,13,1,7)
    # 	self.table_led_on(9,15,3,5)
    # 	self.table_led_on(10,14,2,6)
    # 	self.table_led_off(11,13,3,5)

    # def feellove(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(0,2,2,4)
    # 	self.table_led_on(4,6,2,4)
    # 	self.table_led_on(1,1,1,5)
    # 	self.table_led_on(5,5,1,5)
    # 	self.table_led_on(2,4,3,6)
    # 	self.table_led_on(3,3,3,7)

    # 	self.table_led_on(9,11,2,4)
    # 	self.table_led_on(13,15,2,4)
    # 	self.table_led_on(10,10,1,5)
    # 	self.table_led_on(14,14,1,5)
    # 	self.table_led_on(10,13,3,6)
    # 	self.table_led_on(12,12,3,7)

    # def feelbore(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(1,6,3,4)
    # 	self.table_led_on(9,14,3,4)

    # def feelangry(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(2,13,1,6)
    # 	self.table_led_on(3,5,7,7)
    # 	self.table_led_on(10,12,7,7)
    # 	self.table_led_off(3,12,1,1)
    # 	self.table_led_off(4,11,2,2)
    # 	self.table_led_off(5,10,3,3)
    # 	self.table_led_off(6,9,4,4)
    # 	self.table_led_off(7,8,5,6)

    # def feelhappy(self):
    # 	self.display.fill(0)
    # 	self.table_led_on(3,5,3,3)
    # 	self.table_led_on(2,2,4,4)
    # 	self.table_led_on(6,6,4,4)
    # 	self.table_led_on(10,12,3,3)
    # 	self.table_led_on(9,9,4,4)
    # 	self.table_led_on(13,13,4,4)


