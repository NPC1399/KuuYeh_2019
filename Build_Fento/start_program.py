import pyb
import time
import machine
from pyb import SPI
from pyb import Pin

import sign
import motor # Motor
import is31fl3731 # Matrix LED
import S1V30120 # Text To Speech
import openmv_reading # OpenMV



class STRAT_PROGRAM:

    def __init__(self):

        # Setup Text To Speech : Can't Use
        self.SPI_2 = SPI(2, SPI.MASTER, baudrate=750000, polarity=1, phase=1, bits=8, firstbit=SPI.MSB)
        self.TTS = S1V30120.S1V30120(self.SPI_2)
        self.TTS.enableS1V()

        # Setup Matrix LED
        self.I2C_2 = machine.I2C(2)
        self.matrix = is31fl3731.Matrix(self.I2C_2)

        # Setup OpenMV
        self.opmv = openmv_reading.FATAG()

        # Speak
        self.TTS.S1V30120_speech("Let's Choose __Mode",0)

        # Setup Choose Mode
        self.whileMode = True
        self.modeChoose()



    def modeChoose(self):

        change_mode = False
        str_mode = 1
        self.s=sign.Signs()

        while (self.whileMode == True):

            # Read OpenMV
            self.data_raw = self.opmv.ATAG()
            self.matrix.print_num(str_mode,10)
            print(str_mode)
            print(self.data_raw)


            # Mode Observe
            if (self.data_raw == 49):
                str_mode = 1
                change_mode = True
            elif (self.data_raw == 50):
                str_mode = 2
                change_mode = True
            elif (self.data_raw == 51):
                str_mode = 3
                change_mode = True
            elif (self.data_raw == 61):
                if (str_mode == 1):
                    #self.matrix.print_text("OpenMV Mode",10,20)
                    self.whileMode = False
                    self.s.camsign()
                    pyb.delay(1000)
                    import openmv_action
                    opmv_action = openmv_action.OPEN_MV()


                elif (str_mode == 2):
                    self.matrix.print_text("Alexa Mode",10,20)
                    self.whileMode = False


                elif (str_mode == 3):
                    self.matrix.print_text("Blockly Mode",10,20)
                    self.whileMode = False














