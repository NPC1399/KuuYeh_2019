import pyb
import time
import machine
from pyb import SPI
from pyb import Pin

import variable # Store Variable
import sign # Sign for Matrix LED
import motor # Motor
import is31fl3731 # Matrix LED
import S1V30120 # Text To Speech
import openmv_reading # OpenMV

class OPEN_MV():

    def __init__(self):



        # Setup Matrix LED
        self.I2C_2 = machine.I2C(2)
        self.matrix = is31fl3731.Matrix(self.I2C_2)

        # Setup sign
        self.s=sign.Signs()
        self.s.eyenormal()

        # Setup OpenMV
        self.opmv = openmv_reading.FATAG()



        # Setup Motor
        self.m = motor.MOTOR()

        # Setup Text To Speech
        self.SPI_2 = SPI(2, SPI.MASTER, baudrate=750000, polarity=1, phase=1, bits=8, firstbit=SPI.MSB)
        self.TTS = S1V30120.S1V30120(self.SPI_2)
        self.TTS.enableS1V()



        # Setup Variable
        self.value = 0
        self.tag_change = True
        self.val = variable.VALIABLE()
        self.val.int_sw()
        self.val.tag_data = 0
        self.val.read_disable = False
        self.val.tag_status = False
        self.val.lock_status = False
        self.val.count_status = 0

        # Running OpenMV Mode
        self.s.eyenormal()
        self.read_openMV()



    def read_openMV(self):
        NM = 0
        Plus = 0
        Minus = 0
        Solution = 0
        WM = 0
        self.s.eyenormal()
        while 1:
            self.s.eyenormal()
            #print("begin")
            data_raw = self.opmv.ATAG()
            #print(data_raw)

#---------------------------------
            # magic mode
            if (data_raw== 24) :
                pass
                self.TTS.S1V30120_speech("magic mode",0)

# ---------------------------------
            # movement mode
            elif (data_raw== 07) :
                self.s.forwardsign()
                self.TTS.S1V30120_speech("Forward",0)
                self.m.backward(4)
                self.s.eyenormal()

            elif (data_raw== 08) :
                #print("back")
                self.s.backwardsign()
                #.TTS.S1V30120_speech("Backward",0)
                self.m.forward(4)
                self.s.eyenormal()

            elif (data_raw== 10) :
                #print("right")
                self.s.leftsign()
                self.TTS.S1V30120_speech("Right",0)
                self.m.rotateright(4)
                self.s.eyenormal()

            elif (data_raw== 09) :
                #print("left")
                self.s.rightsign()
                self.TTS.S1V30120_speech("Left",0)
                self.m.rotateleft(4)
                self.s.eyenormal()

#----------------------------------
            # Numbers
            elif (data_raw== 48) :
                self.matrix.print_text("0",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("0",0)
                if NM ==0 :
                    Solution = 0
                elif Plus ==1 :
                    Solution = Solution + 0
                elif Minus == 1:
                    Solution = Solution - 0
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 49) :
                self.matrix.print_text("1",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("1",0)
                if NM ==0 :
                    Solution = 1
                elif Plus ==1 :
                    Solution = Solution + 1
                elif Minus == 1:
                    Solution = Solution - 1
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 50) :
                self.matrix.print_text("2",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("2",0)
                if NM ==0 :
                    Solution = 2
                elif Plus ==1 :
                    Solution = Solution + 2
                elif Minus == 1:
                    Solution = Solution - 2
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 51) :
                self.matrix.print_text("3",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("3",0)
                if NM ==0 :
                    Solution = 3
                elif Plus ==1 :
                    Solution = Solution + 3
                elif Minus == 1:
                    Solution = Solution - 3
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 52) :
                self.matrix.print_text("4",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("4",0)
                if NM ==0 :
                    Solution = 4
                elif Plus ==1 :
                    Solution = Solution + 4
                elif Minus == 1:
                    Solution = Solution - 4
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 53) :
                self.matrix.print_text("5",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("5",0)
                if NM ==0 :
                    Solution = 5
                elif Plus ==1 :
                    Solution = Solution + 5
                elif Minus == 1:
                    Solution = Solution - 5
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 54) :
                self.matrix.print_text("6",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("6",0)
                if NM ==0 :
                    Solution = 6
                elif Plus ==1 :
                    Solution = Solution + 6
                elif Minus == 1:
                    Solution = Solution - 6
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 55) :
                self.matrix.print_text("7",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("7",0)
                if NM ==0 :
                    Solution = 7
                elif Plus ==1 :
                    Solution = Solution + 7
                elif Minus == 1:
                    Solution = Solution - 7
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 56) :
                self.matrix.print_text("8",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("8",0)
                if NM ==0 :
                    Solution = 8
                elif Plus ==1 :
                    Solution = Solution + 8
                elif Minus == 1:
                    Solution = Solution - 8
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 57) :
                self.matrix.print_text("9",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("9",0)
                if NM ==0 :
                    Solution = 9
                elif Plus ==1 :
                    Solution = Solution + 9
                elif Minus == 1:
                    Solution = Solution - 9
                    WM = 0
                self.s.eyenormal()
                NM = 1
                Plus = 0
                Minus = 0
            elif (data_raw== 43) :
                self.matrix.print_text("+",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("Plus",0)
                self.s.eyenormal()
                if NM ==1 :
                    Plus = 1
                    Minus = 0
            elif (data_raw== 45) :
                self.matrix.print_text("-",15,35)
                self.matrix.print_text(" ",15,35)
                self.TTS.S1V30120_speech("Minus",0)
                self.s.eyenormal()
                if NM == 1:
                    Minus = 1
                    Plus = 0
            elif (data_raw==61) :
                self.matrix.print_text("=",15,35)
                self.TTS.S1V30120_speech("Equal",0)

                if NM ==1 :
                    self.matrix.print_text((str)(Solution),15,35)
                    self.matrix.print_text(" ",15,35)
                    self.TTS.S1V30120_speech((str)(Solution),0)

                NM = 0
                Plus = 0
                Minus = 0
                Solution = 0

#---------------------------------
            # Characters

            elif (data_raw== 65) :
                self.TTS.S1V30120_speech("A",0)
                self.matrix.print_text("A",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 66) :
                self.TTS.S1V30120_speech("B",0)
                self.matrix.print_text("B",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 67) :
                self.TTS.S1V30120_speech("C",0)
                self.matrix.print_text("C",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 68) :
                self.TTS.S1V30120_speech("D",0)
                self.matrix.print_text("D",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 69) :
                self.TTS.S1V30120_speech("E",0)
                self.matrix.print_text("E",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 70) :
                self.TTS.S1V30120_speech("F",0)
                self.matrix.print_text("F",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 71) :
                self.TTS.S1V30120_speech("G",0)
                self.matrix.print_text("G",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 72) :
                self.TTS.S1V30120_speech("H",0)
                self.matrix.print_text("H",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 73) :
                self.TTS.S1V30120_speech("I",0)
                self.matrix.print_text("I",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 74) :
                self.TTS.S1V30120_speech("J",0)
                self.matrix.print_text("J",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 75) :
                self.TTS.S1V30120_speech("K",0)
                self.matrix.print_text("K",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 76) :
                self.TTS.S1V30120_speech("L",0)
                self.matrix.print_text("L",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 77) :
                self.TTS.S1V30120_speech("M",0)
                self.matrix.print_text("M",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 78) :
                self.TTS.S1V30120_speech("N",0)
                self.matrix.print_text("N",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 79) :
                self.TTS.S1V30120_speech("O",0)
                self.matrix.print_text("O",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 80) :
                self.TTS.S1V30120_speech("P",0)
                self.matrix.print_text("P",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 81) :
                self.TTS.S1V30120_speech("Q",0)
                self.matrix.print_text("Q",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 82) :
                self.TTS.S1V30120_speech("R",0)
                self.matrix.print_text("R",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 83) :
                self.TTS.S1V30120_speech("S",0)
                self.matrix.print_text("S",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 84) :
                self.TTS.S1V30120_speech("T",0)
                self.matrix.print_text("T",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 85) :
                self.TTS.S1V30120_speech("U",0)
                self.matrix.print_text("U",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 86) :
                self.TTS.S1V30120_speech("V",0)
                self.matrix.print_text("V",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 87) :
                self.TTS.S1V30120_speech("W",0)
                self.matrix.print_text("W",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 88) :
                self.TTS.S1V30120_speech("X",0)
                self.matrix.print_text("X",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 89) :
                self.TTS.S1V30120_speech("Y",0)
                self.matrix.print_text("Y",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 90) :
                self.TTS.S1V30120_speech("Z",0)
                self.matrix.print_text("Z",15,35)
                self.matrix.print_text(" ",15,35)

            elif (data_raw== 91) :
                pass
                self.TTS.S1V30120_speech("space",0)
                self.matrix.print_text(" ",15,35)

#----------------------------------
           # record Characters mode
            elif (data_raw== 02) :
                #print("start movement")
                self.TTS.S1V30120_speech("record",0)
                y=""
                #i=0
                self.matrix.print_text("RECORD",15,35)
                while 1:


                    data_raw = self.opmv.ATAG()
                    self.s.recordsign()
                    #print(i)

                    if (data_raw== -1) :
                        self.s.recordsign()
                        y=y
                    elif (data_raw== 65) :

                        self.TTS.S1V30120_speech("A",0)
                        self.matrix.print_text("A",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'A'
                    elif (data_raw== 66) :
                        self.TTS.S1V30120_speech("B",0)
                        self.matrix.print_text("B",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'B'
                    elif (data_raw== 67) :
                        self.TTS.S1V30120_speech("C",0)
                        self.matrix.print_text("C",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'C'
                    elif (data_raw== 68) :
                        self.TTS.S1V30120_speech("D",0)
                        self.matrix.print_text("D",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'D'
                    elif (data_raw== 69) :
                        self.TTS.S1V30120_speech("E",0)
                        self.matrix.print_text("E",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'E'
                    elif (data_raw== 70) :
                        self.TTS.S1V30120_speech("F",0)
                        self.matrix.print_text("F",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'F'
                    elif (data_raw== 71) :
                        self.TTS.S1V30120_speech("G",0)
                        self.matrix.print_text("G",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'G'
                    elif (data_raw== 72) :
                        self.TTS.S1V30120_speech("H",0)
                        self.matrix.print_text("H",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'H'
                    elif (data_raw== 73) :
                        self.TTS.S1V30120_speech("I",0)
                        self.matrix.print_text("I",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'I'
                    elif (data_raw== 74) :
                        self.TTS.S1V30120_speech("J",0)
                        self.matrix.print_text("J",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'J'
                    elif (data_raw== 75) :
                        self.TTS.S1V30120_speech("K",0)
                        self.matrix.print_text("K",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'K'
                    elif (data_raw== 76) :
                        self.TTS.S1V30120_speech("L",0)
                        self.matrix.print_text("L",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'L'
                    elif (data_raw== 77) :
                        self.TTS.S1V30120_speech("M",0)
                        self.matrix.print_text("M",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'M'
                    elif (data_raw== 78) :
                        self.TTS.S1V30120_speech("N",0)
                        self.matrix.print_text("N",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'N'
                    elif (data_raw== 79) :
                        self.TTS.S1V30120_speech("O",0)
                        self.matrix.print_text("O",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'O'
                    elif (data_raw== 80) :
                        self.TTS.S1V30120_speech("P",0)
                        self.matrix.print_text("P",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'P'
                    elif (data_raw== 81) :
                        self.TTS.S1V30120_speech("Q",0)
                        self.matrix.print_text("Q",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'Q'
                    elif (data_raw== 82) :
                        self.TTS.S1V30120_speech("R",0)
                        self.matrix.print_text("R",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'R'
                    elif (data_raw== 83) :
                        self.TTS.S1V30120_speech("S",0)
                        self.matrix.print_text("S",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'S'
                    elif (data_raw== 84) :
                        self.TTS.S1V30120_speech("T",0)
                        self.matrix.print_text("T",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'T'
                    elif (data_raw== 85) :
                        self.TTS.S1V30120_speech("U",0)
                        self.matrix.print_text("U",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'U'
                    elif (data_raw== 86) :
                        self.TTS.S1V30120_speech("V",0)
                        self.matrix.print_text("V",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'V'
                    elif (data_raw== 87) :
                        self.TTS.S1V30120_speech("W",0)
                        self.matrix.print_text("W",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'W'
                    elif (data_raw== 88) :
                        self.TTS.S1V30120_speech("X",0)
                        self.matrix.print_text("X",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'X'
                    elif (data_raw== 89) :
                        self.TTS.S1V30120_speech("Y",0)
                        self.matrix.print_text("Y",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'Y'
                    elif (data_raw== 90) :
                        self.TTS.S1V30120_speech("Z",0)
                        self.matrix.print_text("Z",15,35)
                        self.matrix.print_text(" ",15,35)
                        y=y+'Z'
                    elif (data_raw== 91) :
                        self.TTS.S1V30120_speech("space",0)
                        y=y+' '
                    # i=i+1
                    elif (data_raw== 02) :
                        self.matrix.print_text(y,15,30)
                        self.TTS.S1V30120_speech(y,0)
                        break
                    else:
                        self.matrix.print_text("Noooo",15,30)
                        self.TTS.S1V30120_speech("Not  Char rac ters",0)
                        break

#---------------------------------
            # led mode
            elif (data_raw== 12) :
                print("on")
                self.TTS.S1V30120_speech("turn on light,  on!",0)
                self.matrix.fill(10)
                pyb.delay(1000)
                self.s.eyenormal()

            elif (data_raw== 13) :
                print("off")
                self.TTS.S1V30120_speech("turn off light,  off!",0)
                self.matrix.fill(0)
                pyb.delay(1000)
                self.s.eyenormal()

            elif (data_raw== 11) :
                pass
                self.TTS.S1V30120_speech("toggle",0)
            elif (data_raw== 05) :
                self.TTS.S1V30120_speech("welcome!   I'm fento!   and I love you.",0)
                print("ping ping")
                self.s.eyeblink_fast(2)
                self.s.eyenormal()
#----------------------------------
           # record movement mode
            elif (data_raw== 01) :
                print("start movement")
                self.TTS.S1V30120_speech("start",0)
                y=[0]*100
                i=0
                while 1:
                    data_raw = self.opmv.ATAG()
                    print(i)
                    if data_raw==None :
                        y[i]=0
                        print(y[i])
                    else:
                        y[i]=data_raw
                        print(y[i])
                        i=i+1
                        if (data_raw== 07) :
                            self.TTS.S1V30120_speech("Forward",0)
                            self.s.forwardsign()
                            pyb.delay(200)
                        elif (data_raw== 08) :
                            #print("back")
                            self.s.backwardsign()
                            self.TTS.S1V30120_speech("Backward",0)
                            pyb.delay(200)
                        elif (data_raw== 09) :
                            #print("left")
                            self.s.leftsign()
                            self.TTS.S1V30120_speech("Left",0)
                            pyb.delay(200)
                        elif (data_raw== 10) :
                            #print("right")
                            self.s.rightsign()
                            self.TTS.S1V30120_speech("right",0)
                            pyb.delay(200)

                        elif (data_raw== 01) :
                            self.TTS.S1V30120_speech("stop",0)
                            #print("ok")
                            self.s.eyeblink_fast(2)
                            j=0
                            while j<=i:
                                print(y[j])
                                if (y[j]== 07) :
                                    #print("go")
                                    self.s.forwardsign()
                                    self.m.forward(8)
                                elif (y[j]== 08) :
                                    #print("back")
                                    self.s.backwardsign()
                                    self.m.backward(8)
                                elif (y[j]== 09) :
                                    #print("left")
                                    self.s.leftsign()
                                    self.m.rotateright(10)
                                elif (y[j]== 10) :
                                    #print("right")
                                    self.s.rightsign()
                                    self.m.rotateleft(10)
                                j=j+1

                            break
                        else:
                            self.matrix.print_text("Noooo",15,30)
                            self.TTS.S1V30120_speech("Not   movement",0)
                            break
                    #print(data_raw)



#----------------------------------
           # sentence
            elif (data_raw== 03) :
                pass
                self.TTS.S1V30120_speech("hello!   I'm Fento.",0)
            elif (data_raw== 04) :
                pass
                self.TTS.S1V30120_speech("my name is fento.",0)
            # elif (data_raw== 05) :
            #     self.TTS.S1V30120_speech("welcome ,I'm fento and I love you.",0)
            elif (data_raw== 06) :
                pass
                self.TTS.S1V30120_speech("Goodbye!  see you again.",0)

#----------------------------------
           # feel
            #elif (data_raw== 29) :
                ##self.s.feelhappy()
                ##self.TTS.S1V30120_speech("happy",0)
                #pyb.delay(500)
                #self.matrix.fill(0)
            #elif (data_raw== 30) :
                ##self.s.feelshock()
                ##self.TTS.S1V30120_speech("oops!",0)
                #pyb.delay(500)
                #self.matrix.fill(0)
            #elif (data_raw== 31) :
                ##self.s.feelangry()
                ##self.TTS.S1V30120_speech("angry",0)
                #pyb.delay(500)
                #self.matrix.fill(0)
            #elif (data_raw== 32) :
                ##self.s.feellove()
                ##self.TTS.S1V30120_speech("I love you",0)
                #pyb.delay(500)
                #self.matrix.fill(0)
            #elif (data_raw== 33) :
                ##self.s.feelbore()
                ##self.TTS.S1V30120_speech("bore",0)
                #pyb.delay(500)
                #self.matrix.fill(0)

            self.s.eyeclose()
            self.s.eyenormal()
            print("end")




