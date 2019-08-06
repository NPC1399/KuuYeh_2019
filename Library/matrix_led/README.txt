version : 1.0
Last Edit : Yoolaibeef
Note : ตอนนี้ print_text ติดปัญหาที่มันปริ้นท์ออกมาผิดทาง
คือจากที่มันควรปริ้นท์แนวนอน มันดันปริ้นท์แนวตั้ง (ยังแก้ไม่ได้)
Status : NOT DONE
===================
SIMPLE CODE
--------------
import machine
import is31fl3731

# NEW BOARD USE I2C(2)
I2C_1 = machine.I2C(1)	
matrix = is31fl3731.Matrix(I2C_1)

# TEST FUNCTION HERE!
matrix.print_text("Fento!",15,10)
--------------
