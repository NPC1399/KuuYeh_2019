* When the firmware in moonlight is 1.0.x or lesser, the Firmware Update with GUI won't work.

*If the firmware in device is version between 1.2.8 to  Version v10.xx GUI Supports Update between these version without issues. 
Whereas from version 11.x.x there is a change in pinning, so it is not recommended to update with GUI to 11.x.x or higher.

*If need to use firmware version 11.x.x or higher, first flash the coressponding "xxx_complete.bin" to devices using the flashCat
(AS7265_Complete_moonlight.bin if it is Generation 1 devices and AS7265_Complete.bin if it is Generation 2 devices) 

 Note:  1. Hardware generation 1 devices are the existing Moonlight hardware between version 1V1 and 3V0 (or older) which don't consider the new pinning. Therefore a special firmare exists for this existing Moonlight hardware. 
	This special firmwware is in this folder under the name "AS7265_complete_moonlight.bin". Please note, use this firmware only in combination with the old Moonlight hardware generation 1 (1Vx-3Vx).
	
	2. In AS7265x Hardware Generation 2 devices version 4Vx or higher, new pinning is made, the INT and SLV_RST1 pin are swapped on default. For these boards use the "AS7265_Complete.bin"

*If the device has firmware 11.x.x(complete_bin) or higher, user can update the firmware to higher version using firmware update GUI or Sensor GUI.  