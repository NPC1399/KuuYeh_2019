version : 1.0
Last Edit : Yoolaibeef
Note : เพิ่ม Readme เข้ามา เพื่อให้สามารถหาไฟล์ที่ต้องการใช้งานได้เร็วขึ้น
===================
@Datasheets_stm32f767ii.pdf
-datasheet ของบอร์ด เอาไว้ดูได้ว่าแต่ละ pin ใช้ทำอะไรได้บ้าง (หน้า 65, 88)

@FENTO-DRIVER-BOARD-PCB.pdf
-Schematic ของบอร์ดบน ไว้ดูว่า pinไหนอยู่ตรงไหน

@FONTAE-MCU.pdf
-Schematic ของบอร์ดหลัก ไว้ดูว่า pinไหนอยู่ตรงไหน

@mpconfigboard.h 
-code c ที่เอาไว้กำหนดขา pin ต่างๆ ว่าให้เป็น uart,i2c,spi อะไรแบบนี้

@mpconfigboard.mk
-ไฟล์ที่เอาไว้ใช้ build board

@pins.csv
-ไฟล์ที่เอาไว้ใช้กำหนด pin ตอน build board

@stm32f7xx_hal_conf.h
-ไฟล์ที่เอาไว้ใช้ build board
===================