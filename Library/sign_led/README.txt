version : 1.0
Last Edit : Araya
Note : ทำงานได้เรียบร้อยแล้ว
Status : DONE
===================
SIMPLE CODE
--------------
import machine
import S1V30120
from pyb import SPI

SPI_2 = SPI(2, SPI.MASTER,\ baudrate=750000, polarity=1, phase=1,\ bits=8, firstbit=SPI.MSB)
TTS = S1V30120.S1V30120(SPI_2)
TTS.enableS1V()

# TEST FUNCTION HERE!
TTS.S1V30120_speech("Welcome to Fento!",0)
--------------
