version : 2.0
Last Edit : Matenut
Note : ตอนนี้พี่นัททำการแก้ไขเรียบร้อยแล้ว แต่ยังต้องการบางฟังก์ชัน เช่น print_text แบบไม่เลื่อน
Status : DONE
===================
SIMPLE CODE
--------------
import machine
import is31fl3731

I2C_2 = machine.I2C(2)	
matrix = is31fl3731.Matrix(I2C_2)

# TEST FUNCTION HERE!
matrix.print_text("Fento!",15,10)
--------------
