Note, the following comments are for the Update 12V0.0 Spectral sensing AS726(x)x and refers firmware and software.

1. Actually are the version for AS72xxx testkits in the web shop:

	- Firmware OLD are 
	AS7221 4V0.6
     	AS7225 0V5.9 
     	AS726x 2V0.x,
    	AS7265x 1V2.7

	- Software OLD are 
	Dashboard SLIK 3V0.2
	LightDirector 0V6.1
	iSPI 2Vx
	Moonlight 3V0.5

	Here named generally "AS72xxx generation 1"

2. Please, use the new files in "update 12V0.0" as following
  

	AS7265x update - includes the AS7265x firmware update 12V0.0 AND the new GUI Dashboard software 4V2.0 inclusive all new documents. The firmware update for AS7265x includes a new sensor pinning. For more details see the readme~.txt in the firmware directory (~update 12V0.0 only spectral\AS7265x update\FW AS7265x 12V0.0)\Readme AS7265x firmware.txt).
	AS726x update  - includes the AS726x firmware update 12V0.0 AND the new iSPI test software 3V3.0 inclusive all new documents

	
	Here named generally "AS72xxx generation 2"
	

>>>>>>> Note, the compatibility Firmware & Software is given only for "generation 1 & generation 1" and/or "generation 2 & generation 2" (Exclude Dashboard software 4V2.9).


3. The Update for lighting AS72xxx is not included here and will comes separately as "xxx update lighting".

4. See the files for the singles updates in the directory "AS726x update" for AS7261/62/63 firmware, software and documents and/or in "AS7265x update".

5. MMore technical details to upgrade firmware are given in the directory "app_notes*”

   New: There is special GUI for AS726(x)x firmware updates via UART. Please find this GUI as executable file and its documentation in the directory "SW_AS726x firmware update GUI UART".

6. The firmware and software update consider 
	* bug corrections - I²C and AT commands 
	* new functions in software - graphical outputs in test software
	* new functions in firmware - new I²C or AT commands 
	* products changings - pin changing AS7265x (INT and SLV_RST1) 
	* optimizations - faster I²C communications

For any other questions please see the readme* file in the subdirectories or ask support frank.krumbein@ams.com.
