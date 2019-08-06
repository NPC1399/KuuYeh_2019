*************************************************************************************

DashBoard Software

Demo SW for Slik, Moonlight and other Scotty Boards

*************************************************************************************

Tools: Tcl/Tk Version 8.6

*************************************************************************************

Version:    4.2.0
Date:       25.05.2018
Tag:        DashBoard_20180525_4_2_0

- Release version
- spezielle Version f�r FW Update integriert (5.1.0)

*************************************************************************************

Version:    4.1.0.5
Date:       24.05.2018
Tag:        

- Testversion
- f�r HW Model 65 (Moonlight)
    - Calibrierte Daten in die Daten Log Datei integriert
    - Unterst�tzung von Version 1.0.2

*************************************************************************************

Version:    4.1.0.4
Date:       22.05.2018
Tag:        

- Testversion
- spezielle Version f�r FW Update integriert (5.0.0.2)

*************************************************************************************

Version:    4.1.0.3
Date:       18.05.2018
Tag:        

- Testversion
- spezielle Version f�r FW Update integriert (5.0.0.1)

*************************************************************************************

Version:    4.1.0.2
Date:       17.05.2018
Tag:        

- Testversion
- spezielle Version f�r FW Update integriert (5.0.0.0)

*************************************************************************************

Version:    4.1.0.1
Date:       17.05.2018
Tag:        

- Testversion
- FW Update Fehlermeldungen qualifiziert
- f�r HW Model 61, 62, 63
    - FW Update

*************************************************************************************

Version:    4.1.0
Date:       04.05.2018
Tag:        DashBoard_20180504_4_1_0

- f�r HW Model 65 (Moonlight)
    - Anzeige von Rohdaten und kalibrierte Daten nach Kanal oder nach Wellenl�nge
      sortiert oder als Spektrum

*************************************************************************************

Version:    4.0.0.1
Date:       20.04.2018
Tag:        DashBoard_20180420_4_0_0_1

- Testversion
- Integration der Firmware V 11 f�r HW Model 65 (Moonlight)
- Integration der Firmware V 11 f�r HW Model 21 (SLIK)
- Tabulator Logging & Control
    - Reset auf Auslieferungszustand
- f�r HW Model 21 (SLIK)
    - Tabulator Logging & Control
        - Aktivierung des persistenten Speichers
    - Tabulator Color Tuning
        - Reset des PWM Override

*************************************************************************************

Version:    4.0.0
Date:       26.03.2018
Tag:        DashBoard_20180326_4_0_0

- Integration der neuen Firmware f�r HW Model 65 (Moonlight)
- Synchronisation der Eingaben, wenn der Continous Modus aktiv ist
- Tabulator Logging & Control
    - Eingabe der Integrationszeit als Zahl m�glich
- Bug fix im FW Update
- f�r HW Model 65 (Moonlight)
    - die Rohdaten k�nnen nach Kanal oder nach Wellenl�nge sortiert werden
    - grafische Anzeige des Spektrums f�r Rohdaten und kalibrierte Daten

*************************************************************************************

Version:    3.0.7.5
Date:       18.12.2017
Tag:        DashBoard_20171218_3_0_7_5

- Integration der neuen Firmware f�r HW Model 21 (SLIK)

*************************************************************************************

Version:    3.0.7.4
Date:       15.12.2017
Tag:        DashBoard_20171215_3_0_7_4

- Portauswahlfenster
    - Doppelklick auf Portnummer �ffnet das entsprechende Hauptfenster
    - Anzeige der Verbindungsversuche
    - Reduzierung der Zeit f�r Verbindungsversuche von 90s auf 20s
- Tabulator Konsole
    - Umsetzung der Standard-Editierfunktionalit�t f�r das Kommandofenster und das Protokollfenster
    - Ctrl-c / Ctrl v vom Protokollfenster in das Kommandofenster
    - History f�r das Kommandofenster
    - Protokolldatei zum Mitschreiben aller Ausschriften im Protokollfenster
    - Abspielen einer Kommandodatei mit
    - AT-Kommandos und TCL-Sequenzen (*.cmd)
      (innerhalb einer TCL-Sequenz darf kein AT-Kommando stehen)
    - einem TCL-Skript (*.tcl)
    - Definition einer Funktion f�r AT-Kommandos, die f�r den Parameter eine Schleife abarbeitet
      doATcommandLoop cmd start end step = 1 test = false
      doATcommandLoopTest cmd start end step = 1
- Andere Tabulatoren
    - Update der Parameter nach �nderungen �ber AT-Kommandos f�r
    - HW Modell 21 (SLIK)
    - HW Modell 65 (Moonlight)
    - HW Modell 65 (Moonlight), Tabulator 18 Channel Sensor:
      die Rohdaten k�nnen nach Kanal oder nach Wellenl�nge sortiert werden
    - Korrekte Anzeige der Light ID (Ber�cksichtigung von Low- und High-Teil)
- Bug fix in der GUI und im Daten Log File
  f�r HW Modell 65 (Moonlight), Version 1.2.8
    - Tabulator 18 Channel Sensor:
      Kanalanzeige getauscht:
      Bug   R   S   T   U   V   W
      ok    U   T   R   S   V   W
- Bug fix f�r AT-Kommando
  f�r HW Modell 65 (Moonlight), Version 1.2.8
    - ATDATA bei ATTSSMD: = 0:
      T = 0, V = 0
    - ATDATA unmittelbar nach ATTCSMD
      500 ms warten
    - LED0:
      Ausblenden der ERROR Antwort
- Verschiedene Bug fixe in der gesamten Software

*************************************************************************************
