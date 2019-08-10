Note, the following comments for the Update 12V0.0 Spectral sensing AS726x firmware and software.

1. Actually are the version for AS72xxx testkits in the web shop:

	- Firmware OLD are 
     	AS726x 2V0.x,


	- Software OLD are 
	iSPI 2Vx

	Here named generally "AS726x generation 1"

2. Please, use the new files in "update 12V0.0" as following
  

	- AS726x update  - includes the AS726x firmware update 12V0.0 AND the new iSPI test software 3V3.0 inclusive all new documents

	
	Here named generally "AS726x generation 2"
	

>>>>>>> Note, the compatibility Firmware & Software is given only for "generation 1 & generation 1" and/or "generation 2 & generation 2".


3. The Firmware (generally for the AS765x sensors) and Software (for ams test kits) directories include the technical data's for update, the manuals and other documents.

4. For first firmware programming use a programmer tool or service. For a firmware update you can use a special firmware update GUI or the upgrade function in the test software. For more details please see the application note "\app_notes for firmware upgrade\AS72xx External Flash program and update_v1-08.pdf.
   Note, the upgrade methode is depend onn the actual firmware version on chip, the communication mode UART/I²C and other conditions. More detauils are give in the application note(s) or manuals.

5. Don't forget to switch/reswitch the communication mode I2C to UART and back in case of using the GUI for firmware update in combination with an ams iSPI test module iSPI AS726x. The mode switching is described in the manual for the test kit.

For any other questions please see the readme file in the subdirectorie or ask the support frank.krumbein@ams.com.
