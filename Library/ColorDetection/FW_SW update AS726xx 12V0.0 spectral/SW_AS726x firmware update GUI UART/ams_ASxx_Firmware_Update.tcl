#!/usr/bin/wish
# ##############################################################################
#
# File: ams_Spectral_Sensor_Dashboard_x.y.z.tcl
#
# Author: Steven P. Smith
# Author: Thomas Rohn
#
# Date:  August, 2014
# Date:  May,    2018
#
# Description:  GUI for ams spectral sensor test and characterization.
#
# Please do not change this source code
#
# ##############################################################################

package require Tk
package require platform

set isFwDownloadTool 1

if { $isFwDownloadTool == 0 } {
    set guiTitle "ams Spectral Sensor Dashboard"
    set guiVersion "4.2.0"
} else {
    set guiTitle "ams Spectral Sensor Firmware Update"
    set guiVersion "5.1.0"
}

set newFwVersion21 { 7.1.0 }
set newFwVersion61 { 9.1.0 }
set newFwVersion62 { 9.1.0 }
set newFwVersion63 { 9.1.0 }
set newFwVersion65 { 9.1.0 1.2.0 }

set showElapsedTimes false
set monitorSliders false

set showFilterTab false
set showPulseRateTab false
set showSKtab false
set enableBurstMode false

set numPortOpenRetries 3
set portRetryHoldOffMs 250
set use7200view true
set use6sensorview false
set S1label "Xr "
set S2label "Yr "
set S3label "Zr "
set S4label "Dk "
set S5label "nIR"
set S6label "Cl "
set CS1label "Xc "
set CS2label "Yc "
set CS3label "Zc "
set lWidgets ""
set lWidgetHighIndex 0
set curWidgetNum 0
set curSubsampleNum 0
set gettingSample false
set sampleSet {}
append newlineChar \n
append tabchar \t
append crChar \r
append backspaceChar \b
set updateButtonState 0
set curmode Manual
#set inttime 400.4
#set inttimeindex 142
set inttime 165.2
set inttimeindex 59
# default gain setting (not display value)
set again  0
#set againstring "1x"
set againstring "3.7x"
set sampleInterval 400.4
set sampleIntervalIndex 142
set sampleFreq [expr 1000.0 / $sampleInterval]
set minSI 0
set badSampleCount 0
set vDetails false
set swVersion 0
set hwVersion 0
set lightAddress 0
set quietMode 1
set responseIsError 0
set ignoreError false
set modifyData false
set burnInput 0
set hwModel 0
set scModel 1
set portname ""
set baseportname ""

set currentTab ""

set rawDataSortMode 0
set channelSortedParams {}
set wavelengthSortedParams {}
set rawDataLabels {}
set rawDataValues {}
set rawDataParams {}

set dataDisplayMode 0

set calibrationMode 0
set diagramMinValue 0
set diagramMaxValue 65535
set minMaxLock 0
set splineMode 1

set updateCmds {}
set updateConsole false

#set bgcolor #67a9df
set bgcolor #dddddd
set tobgcolor #cccccc
set darkFG #000000
set lightFG #3333ee

set port_baud 115200
set port_databits  8
set port_parity  n
set port_stopbits 1
set port_com ""
set gotCmdAnswer 0
set answerCount 0
set answerNumber 1
set consoleExists 0
set consoleEntryBuffer ""
set consoleEntryIndex -1
set logFileName ""
set logFile ""
set authFileName ""
set authFile ""
set authTrial 0
set authTrialNote ""
set vAuthLogging false
set cmdFileName ""
set cmdFile ""
set cmdLogging false
set cmdLogFileName ""
set cmdLogFile ""
set firmwareFileName ""
set firmwareFile ""
set vOverwrite true
set vLogging false
set vSaveToLog false
set vCmdCapture false
set vCmdPlayback false
set vPlayingback false
set bCmdModeCapture 1
set sampleTarget ""
set sampleCount 0
set vTracing false
set anum ""
set ishexnum false
set lastnum ""
set lastline ""
set SettingsFile ""
set manualButtonWidget ""
set sampleCountWidget ""
set sampleTargetWidget ""
set lastUpdateTimeWidget ""
set colorTuneSliderWidget ""
set autoRunning false
set atCommandList {}
set inAutoMode false
set led0ControlWidget ""
set led1ControlWidget ""
set led2ControlWidget ""
set led3ControlWidget ""
set ledCurrent 0
set ledDCurrent 0
set ledECurrent 0
append lastChar \0
set incomment false
set havenonwhitespace false
set amslogo {}
set amslogofile "./ams_logo_xparent_h30.gif"
set amsicon {}
set amsiconfile "./ams_icon_rgb_png_round.png"
# set amsiconfile "./ams_icon_rgb_neg.gif"
set timeOfDaySetValue ""
set timeOfDayString   ""
set dayOfWeekSetValue ""
set dayOfWeekString   ""
set newPasswordValue  ""
set newPasswordString ""
set platform [lindex [split [platform::generic] -] 0]
set vBursting 0
set scaleWaitNow 0
set lightState 0
set daylightingState 0
set colorTuningState 0
set passwordValue ""
set bPasswordModeAuto 0
set passwordLastSetTime 0
set passwordIsValid 0
set bUpdateModeAuto 0
set bEnableEeprom 0
set bIncludeDerivedVals 1
# TCS_MODE default to X, Y, Z, and Dk
set tcsMode 0
set percentLightOutput 50
set targetLuxVal 150
set targetCCTVal 4250
set targetPWMmixVal 50
set lastDLsliderChange 0
set lastCTsliderChange 0
set statusLastUpdate ""
set lastATcommand ""
set entryNewlines 0
set led0State 0
set led1State 0
set atCommandTimeout 4000
array set bSceneEnable {}
array set sceneStartTime {}
array set sceneStartTimeInt {}
array set sceneDays {}
array set sceneDaysAll {}
array set sceneLuxTarget {}
array set scenePercentOutput {}
array set sceneCCTtarget {}
array set scenePercentPWM1 {}
array set scenePercentPWM2 {}
array set scenePercentPWM3 {}
array set sceneRampMins {}
array set sceneRampStyle {}
array set bSceneDlEnable {}
array set bSceneCtEnable {}
array set bSceneDimEnable {}
array set bSceneOccEnable {}
array set bSceneIncludeUpdateSelect {}
set bSceneIncludeUpdateSelectAll 0
array set bSceneIncludeClearSelect {}
set bSceneIncludeUpdateClearAll 0
set statusLastEvent 0
set statusLastEventString "Dashboard"
set lastEventWidget {}
array set aFilterFreq1 {}
array set aFilterFreq2 {}
array set aFilterTaps  {}
array set aFilterTypes {}
array set aFilterTypeNums {}
array set aFilterTextWidgets {}
set lUpdateProcs {}
set numFilters 0
set filterTypeSetting ""
set numFilterTaps ""
set filterStage ""
set filterTypeSetting ""
set filterTypeNum 0
set filterFreq1 ""
set filterFreq2 ""
set vFiltering false
set filteredFileName ""
set filteredFile ""
set filterApp "ConsoleApplication1.exe"
set statsLastUpdate ""
set haveTempX false
set tempXval  0.0
set haveRhX   false
set rhXval    0.0
set colorControlY1 28
set colorControlY2 68
set espStabilizeHoldoff 120
# set espStabilizeFlag    -1
set espStabilizeFlag    0

set autoSampleInterval 0

#set pulseRateParams "0x03320514"
set pulseRateParams "0x07320514"
set qhrPending false
set hrPending  false

# ams corporate colors
set ams_gray95 #2c292d
set ams_gray   #46555f
set ams_gray70 #7d888f
set ams_gray45 #acb2b7
set ams_gray25 #c8ccd2
set ams_gray10 #e8ecf2
set ams_yellow #f7e600
set ams_blue   #0075b0
set ams_blue70 #4c9ec8
set ams_blue45 #8cc1db
set ams_green  #009f69
set ams_lightgreen #78f078
set ams_red    #df5353
set ams_viola  #8b2dbd
set ams_blackberry #654447
set ams_skin   #ffb690
set ams_wood   #8c6239

# AS7263 Min/Max values
set rMin 0
set rMax 0
set sMin 0
set sMax 0
set tMin 0
set tMax 0
set uMin 0
set uMax 0
set vMin 0
set vMax 0
set wMin 0
set wMax 0
set bSKuseCalibrated 0
set bSKuseR 1
set bSKuseS 1
set bSKuseT 1
set bSKuseV 1
set bSKuseU 1
set bSKuseW 1

set hwModelOverride 0
set usingI2Cadapter false

set logfiletypes {
    {"Log Files" {.csv} }
    {"All Files" *}
}
set logFileCsvDelimiter ";"

set cmdCaptureFileTypes {
    {"Cmd Files" {.cmd} }
    {"All Files" *}
}

set cmdPlaybackFileTypes {
    {"Cmd Files" {.cmd} }
    {"Tcl Files" {.tcl} }
    {"All Files" *}
}

set cmdLogFileTypes {
    {"Log Files" {.txt} }
    {"All Files" *}
}

set firmwarefiletypes {
    {"Firmware Files" {.bin} }
    {"All Files" *}
}

set calibrationDataFileTypes {
    {"Csv Files" {.csv} }
    {"All Files" *}
}
set calibrationDataFileCsvDelimiter ";"

if {$argc > 0 } {
    set hwModelOverride 1
    #    puts "argv is $argv"
}

# check firmware version for hardware model
# returns true for new firmware version
proc checkForNewFwVersion { curHwModel { fwVersionIndex 0 } } {
    global hwModel
    global swVersion
    global newFwVersion21
    global newFwVersion61
    global newFwVersion62
    global newFwVersion63
    global newFwVersion65
    
    switch -- $hwModel {
        21 {
            set newFwVersion [lindex $newFwVersion21 $fwVersionIndex]
        }
        61 {
            set newFwVersion [lindex $newFwVersion61 $fwVersionIndex]
        }
        62 {
            set newFwVersion [lindex $newFwVersion62 $fwVersionIndex]
        }
        63 {
            set newFwVersion [lindex $newFwVersion63 $fwVersionIndex]
        }
        65 {
            set newFwVersion [lindex $newFwVersion65 $fwVersionIndex]
        }
    }
    
    set fwVersion0 [lindex [split $newFwVersion "."] 0]
    set fwVersion1 [lindex [split $newFwVersion "."] 1]
    set fwVersion2 [lindex [split $newFwVersion "."] 2]

    set swVersion0 [lindex [split $swVersion .] 0]
    set swVersion1 [lindex [split $swVersion .] 1]
    set swVersion2 [lindex [split $swVersion .] 2]
    
    set retVal false
    if { ([lsearch -exact $curHwModel $hwModel] >= 0) } {
        if { ($swVersion0 > $fwVersion0) } {
            set retVal true
        } elseif { ($swVersion0 == $fwVersion0) } {
            if { ($swVersion1 > $fwVersion1) } {
                set retVal true
            } elseif { ($swVersion1 == $fwVersion1) } {
                if { ($swVersion2 >= $fwVersion2) } {
                    set retVal true
                }
            }
        }
    }
    # puts "New version $swVersion found for HW model $hwModel"
    return $retVal
}

proc DoLoadSettings {} {
    global platform
    global hwModel
    global swVersion
    global env
    global again
    global againstring
    global inttime
    global SettingsFile
    global passwordValue
    global bPasswordModeAuto
    global targetLuxVal
    global targetCCTVal
    global targetPWMmixVal
    global sampleInterval
    global sampleFreq
    global tcsMode
    global lastDLsliderChange
    global lastCTsliderChange

    if { $hwModel == 0 } {
        set fname "AS7200"
    } else {
        set fname "AS72$hwModel"
    }

    set swver "_$swVersion"
    set fnameext ".sav"

    switch -- $platform {
        win32 {
            set SettingsDir "ams"
            set separator "\\"
            set SettingsFile "$env(HOME)$separator$SettingsDir$separator$fname$swver$fnameext"
            #	    puts "Settings File is $SettingsFile"
        }
        linux {
            set SettingsDir ".ams"
            set separator "/"
            set SettingsFile "$env(HOME)$separator$SettingsDir$separator$fname$swver$fnameext"
        }
        macosx {
            set SettingsDir ".ams"
            set separator "/"
            set SettingsFile "$env(HOME)$separator$SettingsDir$separator$fname$swver$fnameext"
        }
        default {
            puts "Unrecognized platform: $platform"
            exit
        }
    }
    #    puts "Settings file is $SettingsFile"
    #    puts "Script is [info script]"
    #    puts "Script dir is [file dirname [info script]]"

    # If the directory doesn't exist, create it.
    if { ! [file exists [file dirname $SettingsFile ] ] } {
        #	puts "Dir does not exist: [file dirname $SettingsFile ]"
        if { [catch { file mkdir [file dirname $SettingsFile ] } ] } {
            return
        }
    }
    if [file exists $SettingsFile ] {
        set sfp [open $SettingsFile r]
        set settingsData [read $sfp]
        close $sfp
        # Interpret the contents of the settings file.
        set settingsData [split $settingsData "\n"]
        foreach settingsLine $settingsData {
            set lineElements [regexp -all -inline {\S+} $settingsLine]
            switch -- [lindex $lineElements 0] {
                again {
                    set again [lindex $lineElements 1]
                    #		    puts "again is $again"
                    set againstring [lindex {1x 3.7x 16x 64x} $again]
                    #		    puts "againstring is $againstring"
                }
                inttime {
                    set inttime [lindex $lineElements 1]
                    #		    puts "inttime is $inttime"
                }
                passwd {
                    # V = 1987*P + 582767  (both constants are primes)
                    # P = (V - 582767) / 1987
                    set passwordValue [lindex $lineElements 1]
                    set passwordValue [expr [expr $passwordValue - 582767 ] / 1987]
                    #		    puts "Password is $passwordValue"
                }
                passwdMode {
                    set bPasswordModeAuto [lindex $lineElements 1]
                }
                sampleInterval {
                    set sampleInterval [lindex $lineElements 1]
                    set sampleFreq [expr 1000.0 / $sampleInterval]
                }
                tcsMode {
                    set tcsMode [lindex $lineElements 1]
                }
                default {
                    #puts "Unrecognized settings file element: [lindex $lineElements 0]"
                }
            }
        }
    }
}

proc DoSaveSettings {} {
    global again
    global againstring
    global inttime
    global passwordValue
    global SettingsFile
    global bPasswordModeAuto
    global hwModel
    global targetLuxVal
    global targetCCTVal
    global targetPWMmixVal
    global passwordIsValid
    global sampleInterval
    global tcsMode

    # If the directory doesn't exist, create it.
    if { ! [file exists [file dirname $SettingsFile ] ] } {
        #	puts "Dir does not exist: [file dirname $SettingsFile ]"
        if { [catch { file mkdir [file dirname $SettingsFile ] } ] } {
            return
        }
    }
    #    puts "Saving settings file $SettingsFile"
    set sfp [open $SettingsFile w]

    if { $passwordIsValid } {
        # V = 1987*P + 582767  (both constants are primes)
        # P = (V - 582767) / 1987
        set passwordValue [expr [expr $passwordValue * 1987] + 582767]
        puts $sfp "passwd $passwordValue"
        puts $sfp "passwdMode $bPasswordModeAuto"
    }

    puts $sfp "again $again"
    puts $sfp "inttime $inttime"

    if { $hwModel == 61 } {
        puts $sfp "sampleInterval $sampleInterval"
        puts $sfp "tcsMode $tcsMode"
    }
    if { ($hwModel == 63) || ($hwModel == 62) } {
        puts $sfp "tcsMode $tcsMode"
    }
    close $sfp
}

proc listports {} {
    global platform

    set result {}
    switch -- $platform {
        win32 {
            catch {
                package require registry

                set serial_base [join {
                                        HKEY_LOCAL_MACHINE
                                        HARDWARE
                                        DEVICEMAP
                                        SERIALCOMM} \\]
                set values [ registry values $serial_base ]
                foreach value $values {
                    #                                        lappend result \\\\.\\[registry get $serial_base $value]
                    lappend result [registry get $serial_base $value]
                }
            }
        }
        linux {
            set result [glob -nocomplain {/dev/ttyS[0-9]} {/dev/ttyUSB[0-9]}]
        }
        netbsd {
            set result [glob -nocomplain {/dev/tty0[0-9]} {/dev/ttyU[0-9]}]
        }
        openbsd {
            set result [glob -nocomplain {/dev/tty0[0-9]} {/dev/ttyU[0-9]}]
        }
        macosx {
            set result [glob -nocomplain /dev/cu.usb* ]
        }
        default {
            # shouldn't happen
        }
    }

    #    puts [lsort $result]
    return [lsort $result]
}

proc putss { thechan thetext } {
    global newlineChar
    global baseportname
    
    set errmsg ""
    foreach ch $thetext {
        if {[catch {puts -nonewline $thechan $ch} errtxt]} {
            set errmsg $errtxt
            break
        }
    }
    if { $errmsg == "" } {
        if {[catch {puts -nonewline $thechan $newlineChar} errtxt]} {
            set errmsg $errtxt
        }
    }
    if { $errmsg != "" } {
        tk_messageBox -icon error -message "Unable to write to $baseportname." \
            -detail "Write error:\n$errmsg." \
            -title "ams Port Write Failure" -type ok
    }
}

proc doManualATcommands { } {
    global isFwDownloadTool
    global lastATcommand
    global newlineChar
    global consoleExists
    global quietMode
    global entryNewlines
    global responseIsError
    global passwordIsValid
    global passwordValue
    global passwordLastSetTime
    global bPasswordModeAuto

    # Give priority to manually entered AT commands from the console page.
    while { $consoleExists == 1 } {

        if { $entryNewlines >= 1 } {
            # We've received a newline
            set manualATcommand [.consoleEntryFrame.txt get 1.0 1.end]
            set manualATcommand [string trimleft  $manualATcommand]
            set manualATcommand [string trimright $manualATcommand]
            .consoleEntryFrame.txt delete 1.0 end
            .consoleEntryFrame.txt see end
            incr entryNewlines -1

            if { $manualATcommand != "" } {
                set prevQM $quietMode
                set quietMode 0
                # Was a repeat command entered?
                if { ( $lastATcommand != "") &&
                    ([string compare "!!" $manualATcommand] == 0) } {
                    # Do the bang-bang repeat.
                    set currentATcommand "$lastATcommand"
                } else {
                    # Execute the newly entered AT command.
                    set currentATcommand "$manualATcommand"
                    # Remember this command.
                    set lastATcommand $manualATcommand
                }
                doATcommand $currentATcommand                
                set normCmd [string toupper [string trim $currentATcommand]]
                if { ([string first "ATPASSWD=" $normCmd] == 0) } {
                    if { ($responseIsError == 0) } {
                        set passwordIsValid 1
                        set passwordValue [lindex [split $normCmd "="] 1]
                        set passwordLastSetTime [expr [clock seconds] + 360]
                        # check for FW download tool
                        if { $isFwDownloadTool == 1 } {
                            set bPasswordModeAuto 1
                        }
                    } else {
                        set passwordIsValid 0
                    }
                }
                set quietMode $prevQM
            } else {
                # New line is empty.
                break
            }
        } else {
            break
        }
    }
}

proc doATcommandLoopTest { cmd start end { step 1 } } {
    doATcommandLoop $cmd $start $end $step true    
}

proc doATcommandLoop { cmd start end { step 1 } { test false } } {
    for { set param $start } { $param <= $end } { incr param $step } {
        doATcommand [format "$cmd=%d" $param]
        if { $test == true } {
            doATcommand $cmd            
        }
    }
}

# Special command processing during auto run
proc doSyncCommand { args } {
    global autoRunning
    global atCommandList
    
    # check for auto running mode
    if { ($autoRunning == false) } {
        # auto run isn't active
        # evaluate command
        eval $args
    } else {
        # auto run is active
        # add command to list
        lappend atCommandList $args
    }
}

# Process AT commands from list
proc doATcommandList {} {
    global atCommandList
    global lastnum

    if { [llength $atCommandList] == 0 } {
        return
    }
    foreach atCommand $atCommandList {
        eval $atCommand 
        # puts "Command from list: $atCommand lastnum: $lastnum"
    }
    set atCommandList {}
}

# Special AT command processing during auto run
proc doATcommand { cmd } {
    global autoRunning
    global atCommandList
    global inAutoMode
    
    # check for auto running mode
    if { ($autoRunning == false) || ($inAutoMode == true) } {
        # auto run isn't active
        # send AT command and wait for answer
        doATcommandSync $cmd    
    } else {
        # auto run is active
        # add AT command to list
        lappend atCommandList "doATcommandSync $cmd"
    }
}

# Send AT command and wait for answer
proc doATcommandSync { cmd } {
    global port_com
    global gotCmdAnswer
    global answerCount
    global answerNumber
    global responseIsError
    global ignoreError
    global modifyData
    global tcsMode
    global atCommandTimeout
    global lastline
    global lastnum
    global cmdFile
    global vCmdCapture
    global newlineChar
    global showElapsedTimes
    global hwModel

    set gotCmdAnswer 0
    set answerCount 0
    
    # normalize command
    set normCmd [string toupper [string trim $cmd]]

    # check for error workarounds
    set answerNumber 1
    set ignoreError false
    set modifyData false
    if { ($hwModel == 65) && ([checkForNewFwVersion { 65 }] == false) } {
        if { (([string first "ATINTTIME" $normCmd] == 0) || ([string first "ATGAIN" $normCmd] == 0)) } {
            # puts "ATGAIN set answerNumber 3"
            set answerNumber 3
        }
        if { ($normCmd == "ATDATA") && ($tcsMode == 0) } {
            set modifyData true
        }
        if { ([checkForNewFwVersion { 65 } 1] == true) } {
            if { $normCmd == "ATLED0" } {
                # puts "ATLED0 set ignoreError"
                set ignoreError true
                incr answerNumber
            } 
        }
    }
    
    # for debugging
    # if { [string first "ATLED23M" $normCmd] != -1 } {
    #     puts "do cmd: $normCmd"
    # }
    
    if { $showElapsedTimes } {
        # AT command timer
        # puts "Cmd: $cmd"
        set cmdET [clock clicks -milliseconds]
    }
    # Timeout set-up
    after $atCommandTimeout set gotCmdAnswer -1
    # Reset error flag
    set responseIsError 0
    set lastline ""
    # Send the command.
    #    puts "A: $cmd"
    putss $port_com "$cmd"
    showAndLogCmd "$cmd\n"
    if { $vCmdCapture } {
        puts $cmdFile "$cmd"
    }
    # Wait for a response.
    vwait gotCmdAnswer
    if { $gotCmdAnswer == -1 } {
        set responseIsError 1
        # puts "Timeout waiting for $cmd response"
        tk_messageBox -icon error -message "Unable to execute $cmd." \
            -detail "Timeout waiting for $cmd response." \
            -title "ams Command Execution Failure" -type ok
    } else {
        after cancel set gotCmdAnswer -1
    }
    # check for error workarounds
    if { ($ignoreError == true) && ($gotCmdAnswer == 1) && ($responseIsError != 0) } {
        set responseIsError 0
    }
    #    puts "GotCmdAnswer is $gotCmdAnswer"
    if { $showElapsedTimes } {
        # Elapsed time for this command
        set cmdET [expr [clock clicks -milliseconds] - $cmdET]
        puts "Cmd: $cmd \t\tET: $cmdET \t\t$lastline"
    }
    
    # for debugging
    # if { [string first "ATLED23M" $normCmd] != -1 } {
    #     puts "value: $lastnum"
    # }
}

# Just like doATcommand except we don't display the command on the console.
proc doATpasswordCommand {p} {
    global port_com
    global gotCmdAnswer
    global answerCount
    global hwVersion
    global hwModel
    global passwordValue
    global responseIsError
    global atCommandTimeout

    set gotCmdAnswer 0
    set answerCount 0

    #   puts "Sending password $passwordValue"

    # Timeout set-up
    after $atCommandTimeout set gotCmdAnswer -1
    # Reset error flag.
    set responseIsError 0
    # Send the command.
    #   puts $port_com "ATPASSWD=$p"
    putss $port_com "ATPASSWD=$p"
    showAndLogCmd "ATPASSWD=****\n"
    # Wait for a response.
    vwait gotCmdAnswer
    if { $gotCmdAnswer == -1 } {
        # puts "Timeout waiting for ATPASSWD response"
        tk_messageBox -icon error -message "Unable to execute ATPASSWD." \
            -detail "Timeout waiting for ATPASSWD response." \
            -title "ams Command Execution Failure" -type ok
    } else {
        after cancel set gotCmdAnswer -1
    }
}

proc listbox_select {W} {
    global portname
    if { [$W curselection] != ""}  {
        set portname [$W get [$W curselection]]
        #	puts $portname
    }
    #    puts [$W curselection]
}

proc read_port {p} {
    global gotCmdAnswer
    global answerCount
    global answerNumber
    global logFile
    global anum
    global ishexnum
    global lastnum
    global lWidgetHighIndex
    global gettingSample
    global newlineChar
    global crChar
    global sampleSet
    global modifyData
    global curSubsampleNum
    global responseIsError
    global ignoreError
    global lastChar
    global lastline
    global vBursting
    global sampleCount
    global burnInput
    global tcsMode
    global qhrPending
    global hrPending
    global hwModel
    global scModel
    global incomment
    global havenonwhitespace
    global tabchar

    # Read one char and echo it to the text output widget.
    if {[catch {read $p 1} msgchar]} {
        # puts "ErrorCode: $::errorCode"
        # puts "ERRORINFO: $::errorInfo"
        # puts "ErrorMsg: $msgchar"
        set responseIsError 1
        set gotCmdAnswer 1
        return
    }

    # DEBUG ONLY:
    #    puts -nonewline "$msgchar"

    if { $burnInput } {
        return
    }

    showAndLogCmd "$msgchar"

    if { ($msgchar != $newlineChar) && ($msgchar != $crChar) } {
        append lastline $msgchar
        #	puts "lastline=$lastline"
    }

    # If the value is not part of ERROR\n (specifically not an R, for our
    # purposes, then continue to assemble the response.
    if { ($responseIsError == 0) } {
        if { $msgchar == "R" } {
            set responseIsError 1
            set anum ""
            lappend sampleSet "err"
            incr curSubsampleNum
            if { $ignoreError == false } {
                 set lastnum ""
            }
        } elseif { ( $msgchar >= "0" ) && ( $msgchar <= "9") } {
            append anum $msgchar
        } elseif { ( $msgchar >= "A" ) && ( $msgchar <= "F") } {
            append anum $msgchar
        } elseif { ( $msgchar >= "a" ) && ( $msgchar <= "f") } {
            append anum $msgchar
        } elseif { $msgchar == "N" } {
            append anum $msgchar
        } elseif { $msgchar == "." } {
            append anum $msgchar
        } elseif { $msgchar == "-" } {
            append anum $msgchar
        } elseif { ($msgchar == "x") || ($msgchar == "X") } {
            #	    puts "X: anum: $anum"
            # Presume this is a _trailing_ x denoting a hex number.  Also a terminator
            # it may be also a 0x number
            #	    puts "2: anum $anum"
            if { $gettingSample } {
                if { ($modifyData == true) && (($curSubsampleNum == 1) || ($curSubsampleNum == 4)) } {
                    lappend sampleSet 0
                } else {
                    lappend sampleSet $anum
                }
                # puts "1 anum: $anum, cur: $curSubsampleNum, set: $sampleSet"
                incr curSubsampleNum
            }
            # Keep the most recent value so it's available to callers
            set lastnum $anum
            set anum ""
            set ishexnum true
        } elseif { ($anum != "") || ($ishexnum == true) } {
            # Reached a terminator; we have a completed datum if we haven't had an error.
            if { $gettingSample } {
                if { ($modifyData == true) && (($curSubsampleNum == 1) || ($curSubsampleNum == 4)) } {
                    lappend sampleSet 0
                } else {
                    lappend sampleSet $anum
                }
                # puts "2 anum: $anum, cur: $curSubsampleNum, set: $sampleSet"
                incr curSubsampleNum
            }
            # Keep the most recent value so it's available to callers
            if { $ishexnum == true } {
                if { ([string length $lastnum] > 0) && ($anum == "") } {
                    append anum "0x" $lastnum
                } elseif { ($lastnum == "0" ) && ([string length $anum] > 0) } {
                    append lastnum "x" $anum
                    set anum $lastnum
                } else {
                    set responseIsError 1
                    set anum ""
                    lappend sampleSet "err"
                    incr curSubsampleNum
                    if { $ignoreError == false } {
                        set lastnum ""
                    }
                }
            }
            set lastnum $anum
            set anum ""
            set ishexnum false
            # puts "last num 2: $lastnum"
            if { $qhrPending } {
                #		.hrFrame.oFrame.qhrFrame.qhrValue configure -text "$lastnum"
                .hrFrame.oFrame.qhrFrame.txt insert end "$lastnum\n"
                .hrFrame.oFrame.qhrFrame.txt yview moveto 1
                set qhrPending false
                #		puts "Q $lastnum"
            }
            if { $hrPending} {
                .hrFrame.oFrame.hrFrame.hrValue  configure -text "$lastnum"
                #		puts "P $lastnum"
            }
        }
    }

    # Are we bursting?  Leave out the "OK" we'll get from stopping.
    if { (($hwModel == 61) || ($hwModel == 63) || ($hwModel == 62) || ($hwModel == 65)) &&  $vBursting && \
            ($scModel == 1) && ($msgchar !=  "O")  && ($msgchar != "K") && ($tcsMode < 5)} {
        puts -nonewline $logFile "$msgchar"
        #	puts -nonewline "$msgchar"
    }

    # Are we at a comment delimiter with nothing before it?
    if { ($msgchar == "#") && ($havenonwhitespace == false) } {
        set incomment true
    }

    if { ($msgchar != " ") && ($msgchar != $newlineChar) && ($msgchar != $tabchar) } {
        set havenonwhitespace true
    }

    # Are we at EOL?
    if { $msgchar == $newlineChar } {
        if { $incomment } {
            # Burn the entire comment line after sending it to the terminal.
            puts "C: $lastline"
            set responseIsError 0
            set lastline ""
            set incomment false
            set lastnum ""
            set curSubsampleNum 0
            set sampleSet {}
            set havenonwhitespace false
        } elseif { $havenonwhitespace == false } {
            puts $lastline
        } else {
            set havenonwhitespace false
            incr answerCount
            if { $answerCount == $answerNumber } {
                set gotCmdAnswer 1
            }
            # puts "Read port lastline: $lastline"
            if { (($hwModel == 61) || ($hwModel == 63) || ($hwModel == 62)) && $vBursting && \
                    ($scModel == 1) && ($tcsMode < 5) } {
                # Special function mode bursting is handled separately below.
                incr sampleCount
            }
            if { $vBursting == 2 } {
                # Bursting termninated by ATBURST=0 command.
                set vBursting 0
            }
        }
    } elseif { (($hwModel >= 61) && ($hwModel <= 63)) && $vBursting && ($scModel == 1) && \
            ($msgchar == "I") && ($tcsMode > 4) } {
        # In special function mode bursting, we only count interval ('I') lines.
        incr sampleCount
    } elseif { (($hwModel == 61) || ($hwModel == 63) || ($hwModel == 62)) && ($scModel == 1) && \
            $vBursting && ($msgchar == "Q") && ($tcsMode > 4) } {
        # We are expecting a "quick" HR measure soon
        set qhrPending true
    } elseif { (($hwModel == 61) || ($hwModel == 63) || ($hwModel == 62)) && ($scModel == 1) && \
            $vBursting && ($msgchar == "P") && ($tcsMode > 4) } {
        # We are expecting a HR measure soon
        set hrPending true
    }
    set lastChar msgchar
}

proc checkPortSelection {} {
    global isFwDownloadTool
    global portname
    global baseportname
    global port_baud
    global port_databits
    global port_parity
    global port_stopbits
    global port_com
    global inttime
    global again
    global againstring
    global lastnum
    global platform
    global swVersion
    global hwVersion
    global hwModel
    global lightAddress
    global quietMode
    global responseIsError
    global lastline
    global atCommandTimeout
    global sampleInterval
    global sampleIntervalIndex
    global tcsMode
    global hwModelOverride
    global argv
    global atCommandTimeout
    global usingI2Cadapter
    global numPortOpenRetries
    global portRetryHoldOffMs
    global scModel
    global ams_gray25
    global ams_gray95

    # Stretch the timeout value during start-up.
    set tmp $atCommandTimeout
    set atCommandTimeout 5000

    if { $portname == "" } {
        tk_messageBox -icon error -message "Please select the port connected to your ams device." \
            -title "ams Device Port Selection Error" -type ok
    } else {
        #	puts "Selected $portname"

        # Deconstruct the port selection widgets.
        pack forget .butframe.okaybut
        pack forget .butframe.cancelbut
        pack forget .portlist
        pack forget .portsb
        pack forget .butframe

        destroy .butframe.okaybut
        destroy .butframe.cancelbut
        destroy .portlist
        destroy .portsb
        destroy .butframe

        # show status line
        label .portStatusLine -justify left -bg $ams_gray25 -fg $ams_gray95
        pack .portStatusLine -side left -expand 1 -fill x
        
        # Let's show a watch cursor to entertain the user while we get busy.
        . configure -cursor watch
        update

        # Keep the undecorated port name for display purposes
        set baseportname $portname
        # Open the port now.
        if { $platform == "win32" } {
            set portname "\\\\.\\$portname"
        }
        set i 0
        while true {
            #	    puts "Port open attempt $i"
            if { [catch {open $portname { RDWR } } port_com] } {
                incr i
                if { $i >= $numPortOpenRetries } {
                    tk_messageBox -icon error -message "Unable to open $baseportname." \
                        -detail "Please check that $baseportname is not in use." \
                        -title "ams Port Open Failure" -type ok
                    exit
                } else {
                    set vw 0
                    after $portRetryHoldOffMs set vw 1
                    vwait vw
                }
            } else {
                break
            }
        }
        #	puts "Open succeeded."
        # Changed "-buffering none" to "-buffering line"
        fconfigure $port_com -mode $port_baud,$port_parity,$port_databits,$port_stopbits \
            -blocking true -translation auto -buffering line -buffersize 1024
        fileevent $port_com readable [list read_port $port_com ]

        # Let's use a multiple retry mechanism in our first communicaiton with
        # the device since start-up for the '21 and '11 are growing very long.
        set maxloopcount 10
        set loopcount 0
        set successfulATs 0
        while { ($loopcount < $maxloopcount) && ($successfulATs < 3) } {
            # show status message
            .portStatusLine configure -text [format "Trying to connect to port $baseportname (%d)" [expr $maxloopcount - $loopcount]]
            update
            # send detection command
            doATcommand "AT"
            #	    puts "Line: $lastline"
            if { ($responseIsError == 0) && ( [string first "OK" $lastline] >= 0) } {
                incr successfulATs
                #		puts "SuccessfulATs: $successfulATs"
            } else {
                # No luck yet.  Wait a few seconds and try again.
                # puts "AT not successful"
                incr loopcount
                set vwaitVar 0
                after 2000 set vwaitVar 1
                vwait vwaitVar
            }
        }

        # Success?
        if { $loopcount >= $maxloopcount } {
            # No.
            close $port_com
            tk_messageBox -icon error -message "Unresponsive or missing device on $baseportname" \
                -detail "Please check device's power and host connection." \
                -title "ams Device Communication Failure" -type ok
            exit
        }

        # show status message
        .portStatusLine configure -text "Get data from device at port $baseportname"
        update
        
        doATcommand "ATVERHW"
        #	puts "VERHW return is $lastnum responseIsError is $responseIsError"
        if { $responseIsError == 0 } {
            set hwVersion $lastnum
            # tk_messageBox -icon info -message "Debug wait" -title "Debug waite" -type ok
            #	    puts "hwVersion=$hwVersion"
            if {$hwModelOverride == 0} {
                set hwModel [ expr ( [expr $lastnum] & 255 ) ]
                # TEMP for MOONLIGHTING:
                if { $hwModel == 60 } { set hwModel 65 }

                #		puts "hwModel=$hwModel"
                # Scotty model is 1 or 2 (for now).  Based on HW rev. val of 3 or 4.
                set scModel [ expr [ expr ( [expr $lastnum] >> 12 ) ] - 2 ]
                #		puts "scModel=$scModel"
                if { $hwModel == 101 } {
                    set usingI2Cadapter true
                    #		    puts "here1 usingI2Cadapter=$usingI2Cadapter"
                    doATcommand "ATI2CSA=0x92"
                    doATcommand "ATVERHW"
                    set hwVersion $lastnum
                    set hwModel [ expr ( [expr $lastnum] & 255 ) ]
                    #		    puts "Now hwVersion=$hwVersion"
                    #		    puts "Now hwModel=$hwModel"

                    set scModel [ expr [ expr ( [expr $lastnum] >> 12 ) ] - 2 ]
                    #		    puts "scModel=$scModel"
                }
            } else {
                # This enables the use of any HW mode with any model.
                set hwModel $argv
                # Scotty model is 1 or 2 (for now).  Still need even with override.
                set scModel [ expr [ expr ( [expr $lastnum] >> 12 ) ] - 2 ]
                #		puts "scModel=$scModel"
            }
        } else {
            close $port_com
            tk_messageBox -icon error -message "Bad or unexpected response from ams device on $baseportname" \
                -detail "Please check device's power and host connection." \
                -title "ams Device Communication Failure" -type ok
            exit
        }
        doATcommand "ATVERSW"
        #	puts "After ATVERSW cmd error=$responseIsError lastnum=$lastnum"
        if { $responseIsError == 0 } {
            #	    puts "swVersion=$lastnum"
            set swVersion $lastnum
            # Extract the major version integer for use on version
            # compatibility checking below.
            set swVersionMajor [lindex [split $swVersion .] 0]
        } else {
            close $port_com
            tk_messageBox -icon error -message "Bad or unexpected response from ams device on $baseportname" \
                -detail "Please check device's power and host connection." \
                -title "ams Device Communication Failure" -type ok
            exit
        }

        # Let's make sure the hardware and firmware versions are compatible with
        # this version of the dashboard, shall we?
        if { ($scModel == 1) || ((($hwModel == 21) || ($hwModel == 11)) && ($swVersionMajor < 4)) || \
                ((($hwModel >= 61) && ($hwModel <= 63)) && ($swVersionMajor < 2)) } {
            close $port_com
            set scriptName [info script]
            puts $scriptName
            tk_messageBox -icon error -message "Incompatible device firmware" \
                -detail "Device firmware version $swVersion is incompatible with GUI version $scriptName" \
                -title "ams Device Firmware Incompatibility" -type ok
            exit
        }

        # check for FW download tool
        if { $isFwDownloadTool == 0 } {
            # get light id low part
            doATcommand "ATLAI"
            # puts "ATLAI response error: $responseIsError, last num: $lastnum"
            if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
                set lightAddress $lastnum
                
                # get light id high part
                doATcommand "ATLAIE"
                if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
                    incr lightAddress [expr $lastnum << 16]
                }
            } else {
                set lightAddress "<none>"
            }
            
            # Load the saved settings for this application.
            # DoLoadSettings
            
            #   puts "sampleInterval is $sampleInterval"
            if { ($scModel == 1 ) && ($hwModel == 61) } {
                switch -- $tcsMode {
                    0 { # X, Y, Z, Dk
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 1]]) ]
                    }
                    1 { # X, Y, Z, Dk, nIR
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 2]]) ]
                    }
                    2 { # X, Y, Z, Dk, nIR, Cl
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 3]]) ]
                    }
                    3 { # nIR only
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 1]]) ]
                    }
                    4 { # Sensor OFF
                        set sampleIntervalIndex 1
                    }
                    5 { # X, Y, Z, Dk special-function  mode
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 1]]) ]
                    }
                    6 { # nIR SF special-function mode
                        set sampleIntervalIndex [expr int( [expr $sampleInterval / [expr 2.8 * 1]]) ]
                    }
                }
            }
        }

        # delete status line
        pack forget .portStatusLine
        destroy .portStatusLine
            
        #	puts "After load settings, again is $again and againstring is $againstring"
        # Build the main display now
        DoMainDisplay
        raise .

        # Restore the normal cursor.
        . configure -cursor {} ;# RS
        update

        # check for FW download tool
        if { $isFwDownloadTool == 0 } {
            if { ($hwModel != 21) && ($hwModel != 11) } {
                # AS7211 and AS7221 now store the following in high frequency struct
                doSetIntTime  $inttime
                doSetGain $againstring
            }
            
            if { $hwModel == 61 } {
                # The following also calls doSetSampleInterval
                doTCSmodeSelect61
            }
            
            if { 0 } {
                # AS7272 or AS7263
                doTCSmodeSelect62n3
            }
        }

        if { $hwModel == 65 } {
            # Get current bank mode
            doATcommand "ATTCSMD"
            if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
                set tcsMode $lastnum
                # puts "Initialize tcsMode: $tcsMode"
            }
        }
            
        # Restore the normal timeout.
        set atCommandTimeout $tmp

        # Begin echoing commands to the console now that it exists.
        # Could make the preceding commands visible, but both require password,
        # so we don't want to hurt the feelings of non-privileged users...
        set quietMode 0
    }
}

proc DoPortSelect {} {
    global portname
    global bgcolor
    global platform
    global amsiconfile

    if { [file exists $amsiconfile ] } {
        set amsicontype [string trimleft [file extension $amsiconfile] .]
        set amsicon [image create photo -format $amsicontype -file $amsiconfile ]
        wm iconphoto . $amsicon
    }

    wm title . "Select ams Device Port"
    wm resizable . 0 0
    focus .
    raise .

    #    puts [regsub " " [ glob -directory /dev -tails cu.usb* ] "\n"]

    # See how many options we have and how long the longest one is.
    set maxlen 0
    set count 0
    set plist [listports]
    while { $plist == {} } {
        set boxAnswer [tk_messageBox -icon error \
            -message "No candidate ams device ports found.  Is the device connected?" \
            -title "ams Port Enumeration Error" -default retry -type retrycancel -parent . ]
        #	puts "Answer=$boxAnswer"
        if { $boxAnswer == "cancel" } {
            exit
        }
        set plist [listports]
    }

    #    tk::toplevel .portsel

    #    foreach i [ glob -directory /dev -tails cu.usb* ] REMOVED OPEN CURLY
    foreach i $plist {
        #	puts "i=$i"
        if [expr [string length $i] > $maxlen] {
            set maxlen [string length $i]
        }
        incr count
    }
    #    puts $maxlen
    #    puts $count
    if [expr $count > 8] {
        set ysize [expr 8 * 22]
    } elseif [expr $count < 3] {
        set ysize [expr 3 * 22]
    } else {
        set ysize [expr $count * 22]
    }
    if { $platform == "win32" } {
        incr maxlen
        incr maxlen
        set xsize [expr $maxlen * 14]
        set xsize [expr $xsize + 80]
    } else {
        set xsize [expr $maxlen * 14]
    }

    set minXSize 300
    if { $xsize < $minXSize } {
        set xsize $minXSize
    }
    set minYSize 50
    if { $ysize < $minYSize } {
        set ysize $minYSize
    }
    
    set geo [regsub -all " " [list $xsize x $ysize] ""]
    #    puts "maxlen $maxlen"
    #    puts "geo=$geo"

    listbox .portlist -font {system -14 bold} -bd 3 -relief sunken -selectmode single \
        -width $maxlen
    #    foreach i [ glob -directory /dev -tails cu.usb* ] REMOVED OPEN CURLY
    foreach i $plist {
        .portlist insert end $i
    }
    bind .portlist <<ListboxSelect>> [list listbox_select %W]
    bind .portlist <Double-ButtonPress-1> { checkPortSelection }

    scrollbar .portsb -orient vertical -command [list .portlist yview]
    frame  .butframe -bd 3 -relief sunken -bg $bgcolor
    button .butframe.okaybut -text " Open " -command { checkPortSelection } \
        -relief raised -bg $bgcolor  -bd 2 -highlightbackground $bgcolor
    button .butframe.cancelbut -text "Cancel" -command { exit } \
        -relief raised -bg $bgcolor  -bd 2 -highlightbackground $bgcolor
    pack .butframe.okaybut -side top -fill x -padx 10
    pack .butframe.cancelbut -side top -fill x -padx 10

    pack .portlist -side left -expand 1 -fill both
    pack .portsb   -side left -expand 0 -fill y
    pack .butframe -side right -expand 0 -fill both

    wm geometry . $geo
    wm deiconify .
    #    wm withdraw .portsel
    focus .
    raise .
}

proc doLightCheck {} {
    global lightState
    global lastnum
    global responseIsError
    global quietMode
    global gettingSample

    set tmpQM $quietMode
    set quietMode 1
    set tmpGS $gettingSample
    set gettingSample false

    doATcommand "ATLIGHT"
    if { $responseIsError == 0 } {
        set lightState $lastnum
    }

    set quietMode $tmpQM
    set gettingSample $tmpGS
}

# Called only in idle mode.  Has the dim slider moved?
proc doCheckSlider11 {} {
    global lightState
    global responseIsError
    global daylightingState
    global percentLightOutput
    global lastDLsliderChange
    global scaleWaitNow
    global gettingSample
    global lastnum
    global quietMode
    global targetLuxVal

    set tmpGS $gettingSample
    set gettingSample false
    set tmpQM $quietMode
    set quietMode 1

    doLightCheck

    if { ($daylightingState == 0) } {
        # Read the current dimming (output) level
        doATcommand "ATDIM"
        if { ($lightState == 1) && ($responseIsError == 0) && \
                ($percentLightOutput != $lastnum) && \
                ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                #		puts "SLIK output: $lastnum Slider: $percentLightOutput"
                set quietMode 0
                doATcommand "ATDIM=$percentLightOutput"
                set scaleWaitNow 0

            }
        }
    } else {
        doATcommand "ATLUXT"
        # Make sure we match the scale/slider.
        if { ($lightState == 1) && ($responseIsError == 0) && ($lastnum != $targetLuxVal) && \
                ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
            #	    puts "SLIK lux target=$lastnum scale is $targetLuxVal"
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                set quietMode 0
                doATcommand "ATLUXT=$targetLuxVal"
                set scaleWaitNow 0

                .statusFrame.luxTFrame.v configure -text "$targetLuxVal"
            }
        } else {
            .statusFrame.luxTFrame.v configure -text "$lastnum"
        }
    }
    set gettingSample $tmpGS
    set quietMode $tmpQM
}

proc doCheckSlider21 {} {
    global lightState
    global responseIsError
    global daylightingState
    global lastCTsliderChange
    global scaleWaitNow
    global gettingSample
    global colorTuningState
    global lastnum
    global targetPWMmixVal
    global quietMode
    global targetCCTVal
    global colorTuneSliderWidget

    set tmpGS $gettingSample
    set gettingSample false
    set tmpQM $quietMode
    set quietMode 1

    # Do the dimming/LUX as for the AS7211
    doCheckSlider11

    if { $colorTuningState } {
        doATcommand "ATCCTT"
        # Make sure we match the scale/slider.
        if { ($lightState == 1) && ($responseIsError == 0) && ($lastnum != $targetCCTVal) && \
                ([expr [clock seconds] - $lastCTsliderChange] <= 10) } {
            #	    puts "SLIK CCT target=$lastnum scale is $targetCCTVal"
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                set quietMode 0
                doATcommand "ATCCTT=$targetCCTVal"
                set scaleWaitNow 0

                .statusFrame.cctTFrame.v configure -text "$targetCCTVal"
            }
        } else {
            .statusFrame.cctTFrame.v configure -text "$lastnum"
        }
    } else {
        doATcommand "ATLED23M"
        if { ($lightState == 1) && ($responseIsError == 0) && \
                ($targetPWMmixVal != $lastnum) && \
                ([expr [clock seconds] - $lastCTsliderChange] <= 10) } {
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                #		puts "SLIK output: $lastnum PWM Slider: $targetPWMmixVal"
                set quietMode 0
                doATcommand "ATLED23M=$targetPWMmixVal"
                set scaleWaitNow 0

                $colorTuneSliderWidget configure -text "$targetPWMmixVal%"
            }
        }
    }
    set gettingSample $tmpGS
    set quietMode $tmpQM
}

proc doGetSample {} {
    global autoRunning
    
    if { $autoRunning == false } {
        doGetSampleSync        
    }
}

proc doGetSampleSync {} {
    global port_com
    global gotCmdAnswer
    global vLogging
    global sampleCount
    global curSubsampleNum
    global gettingSample
    global autoRunning
    global sampleSet
    global logFile
    global logFileCsvDelimiter
    global lWidgets
    global lWidgetHighIndex
    global lUpdateProcs
    global badSampleCount
    global vDetails
    global manualButtonWidget
    global sampleCountWidget
    global lastUpdateTimeWidget
    global colorTuneSliderWidget
    global statusLastUpdate
    global hwModel
    global scModel
    global responseIsError
    global lastnum
    global daylightingState
    global targetLuxVal
    global colorTuningState
    global targetCCTVal
    global targetPWMmixVal
    global statusLastEvent
    global statusLastEventString
    global lastEventWidget
    global percentLightOutput
    global scaleWaitNow
    global lightState
    global lastDLsliderChange
    global lastCTsliderChange
    global tcsMode
    global autoSampleInterval
    global usingI2Cadapter
    global bIncludeDerivedVals
    global haveTempX
    global haveRhX
    global rawDataParams
    global rawDataValues    
    global dataDisplayMode
    global calibrationMode

    # While we are getting a sample, we don't want the user
    # to request a second sample (in manual mode).
    set updateButtonPrevState [$manualButtonWidget cget -state]
    #	puts "Prev state is $updateButtonPrevState"
    if { $autoRunning == false } {
        $manualButtonWidget configure -state disabled
    }

    set curSubsampleNum 0
    set gettingSample true
    set sampleSet {}

    # To what HW are we connected, pray tell?
    if { $hwModel == 61 } {
        if { $usingI2Cadapter } {
            # Initiate a one-shot cycle.
            doATcommand "ATTCSMD=$tcsMode"
            # Wait for the one-shot cycle to compelte.
            set vw 0
            after $autoSampleInterval set vw 1
            #	    puts "Waiting $autoSampleInterval"
            vwait vw
            #	    puts "Proceeding. TCS mode=$tcsMode"
        }
        if { $scModel == 1 } {
            if { ($tcsMode == 2) } {
                # Read six sensors of raw data
                doATcommand "ATDATA"
                # Read three sensors of calibrated data
                doATcommand "ATXYZC"
                # Send the ATCCTC command.
                doATcommand "ATCCTC"
                # Send the ATDUVC command.
                doATcommand "ATDUVC"
                # Send the ATUVPRIMEC command.
                doATcommand "ATUVPRIMEC"
                # Send the ATSMALLXYC command.
                doATcommand "ATSMALLXYC"
            } elseif { $tcsMode == 1 } {
                # Read six sensors of raw data
                doATcommand "ATDATA"
                # Trim off the trailing Cl value
                set sampleSet [string trimright $sampleSet {0123456789} ]
                set sampleSet [string trimright $sampleSet ]
                set curSubsampleNum [expr $curSubsampleNum - 1]
                # Read three sensors of calibrated data
                doATcommand "ATXYZC"
                # Send the ATCCTC command.
                doATcommand "ATCCTC"
                # Send the ATDUVC command.
                doATcommand "ATDUVC"
                # Send the ATUVPRIMEC command.
                doATcommand "ATUVPRIMEC"
                # Send the ATSMALLXYC command.
                doATcommand "ATSMALLXYC"
            } elseif { $tcsMode == 0 } {
                # Read six sensors of raw data
                doATcommand "ATDATA"
                # Strip off the trailing IR and Cl readings
                set sampleSet [string trimright $sampleSet {0123456789} ]
                set sampleSet [string trimright $sampleSet ]
                set sampleSet [string trimright $sampleSet {0123456789} ]
                set curSubsampleNum [expr $curSubsampleNum - 2]
            } elseif { $tcsMode == 3 } {
                # Read six sensors of raw data
                doATcommand "ATDATA"
                # Extract the IR value in fifth position
                set sampleSet [string trimright $sampleSet {0123456789} ]
                set sampleSet [string trimright $sampleSet ]
                set sampleSet [string trimleft  $sampleSet {0123456789} ]
                set sampleSet [string trimleft  $sampleSet ]
                set sampleSet [string trimleft  $sampleSet {0123456789} ]
                set sampleSet [string trimleft  $sampleSet ]
                set sampleSet [string trimleft  $sampleSet {0123456789} ]
                set sampleSet [string trimleft  $sampleSet ]
                set sampleSet [string trimleft  $sampleSet {0123456789} ]
                set sampleSet [string trimleft  $sampleSet ]
                set curSubsampleNum [expr $curSubsampleNum - 5]
            }
        } elseif { $scModel == 2 } {
            if { $tcsMode == 0 } {
                # X, Y, Z, and nIR
                doATcommand "ATDATA"
                #		puts "sampleSet:$sampleSet"
                set sampleSet [list [lindex $sampleSet 0] [lindex $sampleSet 1] \
                    [lindex $sampleSet 2] [lindex $sampleSet 4]]
                #		puts "sampleSet noCl or Dk:$sampleSet"
                set curSubsampleNum [expr $curSubsampleNum - 2]
            } elseif { $tcsMode == 1 } {
                # X, Y, Dk, and Cl
                doATcommand "ATDATA"
                #		puts "sampleSet:$sampleSet"
                set sampleSet [list [lindex $sampleSet 0] [lindex $sampleSet 1] \
                    [lindex $sampleSet 3] [lindex $sampleSet 5]]

                #		puts "sampleSet noZ no IR:$sampleSet"
                set curSubsampleNum [expr $curSubsampleNum - 2]
            } elseif { $tcsMode == 2 } {
                # Read six sensors of raw data
                doATcommand "ATDATA"
                # Read three sensors of calibrated data
                doATcommand "ATXYZC"
                # Send the ATCCTC command.
                doATcommand "ATCCTC"
                # Send the ATDUVC command.
                doATcommand "ATDUVC"
                # Send the ATUVPRIMEC command.
                doATcommand "ATUVPRIMEC"
                # Send the ATSMALLXYC command.
                doATcommand "ATSMALLXYC"
            }
        }
    } elseif { ($hwModel == 25) } {
        # AS7225 only supports one-shot mode due to I2C limitations.
        # Initiate a one-shot cycle.
        doATcommand "ATTCSMD=3"
        # Wait two times the integration time plus a bit.
        set vw 0
        after $autoSampleInterval set vw 1
        #	puts "Waiting."
        vwait vw
        #	puts "Proceeding. TCS mode=$tcsMode"
        if { $tcsMode == 3 } {
            # Read three sensors of calibrated data - one-shot mode
            doATcommand "ATXYZC"
            # Read the lux value
            doATcommand "ATLUXC"
            # Send the ATCCTC command.
            doATcommand "ATCCTC"
            # Send the ATDUVC command.
            doATcommand "ATDUVC"
            # Send the ATUVPRIMEC command.
            doATcommand "ATUVPRIMEC"
            # Send the ATSMALLXYC command.
            doATcommand "ATSMALLXYC"
        }
    } elseif { ($hwModel == 11) } {
        doLightCheck
        # Read the current dimming (output) level
        doATcommand "ATDIM"

        # Special case: deal with scale/slider slag delays by comparing setting
        # to current dimming value on SLIK.  If we've made a recent change, make
        # sure the two match.
        if { ($lightState == 1) && ($responseIsError == 0) && ($daylightingState == 0) && \
                ($percentLightOutput != $lastnum) && \
                ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
            set gettingSample false
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                #		puts "SLIK output: $lastnum Slider: $percentLightOutput"
                doATcommand "ATDIM=$percentLightOutput"
                set scaleWaitNow 0
            }
            set gettingSample true
        }

        # Read the current calibrated LUX sensor reading
        doATcommand "ATLUXC"

        # Read the current time of day
        doATcommand "ATTIMENOW"

        # Read the current day of the week
        doATcommand "ATDOW"

        # Special case.  Handle the entire widget update here.
        if { $daylightingState } {
            set gettingSample false
            doATcommand "ATLUXT"
            # Make sure we match the scale/slider.
            if { ($lightState == 1) && ($responseIsError == 0) && ($lastnum != $targetLuxVal) && \
                    ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
                #		puts "SLIK lux target=$lastnum scale is $targetLuxVal"
                if { $scaleWaitNow == 0 } {
                    set scaleWaitNow 1
                    doATcommand "ATLUXT=$targetLuxVal"
                    set scaleWaitNow 0
                    .statusFrame.luxTFrame.v configure -text "$targetLuxVal"
                }
            } else {
                .statusFrame.luxTFrame.v configure -text "$lastnum"
            }
            set gettingSample true
        }
    } elseif { ($hwModel == 21) } {
        doLightCheck
        # Read the current dimming (output) level.
        doATcommand "ATLED23M"
        
        # Read the current calibrated CCT value reading.
        doATcommand "ATCCTC"
            
        # Read the current dimming (output) level.
        doATcommand "ATDIM"
            
        # Read the current calibrated LUX sensor reading.
        doATcommand "ATLUXC"

        # Read the current time of day
        doATcommand "ATTIMENOW"

        # Read the current day of the week
        doATcommand "ATDOW"

        # Special case: deal with scale/slider slag delays by comparing setting
        # to current dimming value on SLIK.  If we've made a recent change, make
        # sure the two match.
        if { ($lightState == 1) && ($responseIsError == 0) && ($daylightingState == 0) && \
                ($percentLightOutput != $lastnum) && \
                ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
            set gettingSample false
            if { $scaleWaitNow == 0 } {
                set scaleWaitNow 1
                #		puts "SLIK output: $lastnum Slider: $percentLightOutput"
                doATcommand "ATDIM=$percentLightOutput"
                set scaleWaitNow 0
            }
            set gettingSample true
        }

        # Special case.  Handle the entire widget update here.
        if { $daylightingState } {
            set gettingSample false
            doATcommand "ATLUXT"
            # Make sure we match the scale/slider.
            if { ($lightState == 1) && ($responseIsError == 0) && ($lastnum != $targetLuxVal) && \
                    ([expr [clock seconds] - $lastDLsliderChange] <= 10) } {
                #		puts "SLIK lux target=$lastnum scale is $targetLuxVal"
                if { $scaleWaitNow == 0 } {
                    set scaleWaitNow 1
                    doATcommand "ATLUXT=$targetLuxVal"
                    set scaleWaitNow 0
                    .statusFrame.luxTFrame.v configure -text "$targetLuxVal"
                }
            } else {
                .statusFrame.luxTFrame.v configure -text "$lastnum"
            }
            set gettingSample true
        }

        # Special case.  Handle the entire widget update here.
        if { $colorTuningState } {
            #	    puts "CT=1 doing CCT target widget updates here..."
            set gettingSample false
            doATcommand "ATCCTT"
            # Make sure we match the scale/slider.
            if { ($lightState == 1) && ($responseIsError == 0) && ($lastnum != $targetCCTVal) && \
                    ([expr [clock seconds] - $lastCTsliderChange] <= 10) } {
                #		puts "SLIK CCT target=$lastnum scale is $targetCCTVal"
                if { $scaleWaitNow == 0 } {
                    set scaleWaitNow 1
                    doATcommand "ATCCTT=$targetCCTVal"
                    set scaleWaitNow 0
                    .statusFrame.cctTFrame.v configure -text "$targetCCTVal"
                }
            } else {
                .statusFrame.cctTFrame.v configure -text "$lastnum"
            }
            set gettingSample true
        } else {
            #	    puts "CT=0 doing PWM slider target widget updates here..."
            set gettingSample false
            doATcommand "ATLED23M"
            if { ($lightState == 1) && ($responseIsError == 0) && ($colorTuningState == 0) && \
                    ($targetPWMmixVal != $lastnum) && \
                    ([expr [clock seconds] - $lastCTsliderChange] <= 10) } {
                if { $scaleWaitNow == 0 } {
                    set scaleWaitNow 1
                    #		    puts "SLIK output: $lastnum PWM Slider: $targetPWMmixVal"
                    doATcommand "ATLED23M=$targetPWMmixVal"
                    set scaleWaitNow 0
                    $colorTuneSliderWidget configure -text "$targetPWMmixVal%"
                }
            }
            set gettingSample true
        }
        if { $haveTempX } {
            doATcommand "ATTEMPX"
        }
        if { $haveRhX } {
            doATcommand "ATRHX"
        }
        if { ([checkForNewFwVersion { 21 }] == true) } {
            doShowPwmOvrStatus        
        }
    } elseif { ($hwModel == 63) || ($hwModel == 62) } {
        # Read six sensors of raw data
        doATcommand "ATDATA"

        # Read six sensors of calibrated data
        doATcommand "ATCDATA"
    } elseif { $hwModel == 65 } {
        if { ([checkForNewFwVersion { 65 } 1] == true) } {
            # read sensor calibrated data
            set sampleSet {}
            doATcommand "ATCDATA"
            # set sample set for sensor calibrated data
            set calibSampleSet [lrange $sampleSet 0 end]
        }
        # Read 18 sensors of raw data
        set sampleSet {}
        doATcommand "ATDATA"
    }

    #    puts "curSubsampleNum=$curSubsampleNum   lWidgetHighIndex=$lWidgetHighIndex"
    # Did we get a complete, clean sample?
    if { $curSubsampleNum >= $lWidgetHighIndex } {
        incr sampleCount
        #	puts "SC: $sampleCount"
        $sampleCountWidget configure -text $sampleCount
        set tstamp [clock format [clock seconds] -format "%Y%m%d%H%M%S"]
        set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
        $lastUpdateTimeWidget configure -text "$statusLastUpdate"

        if { ($hwModel == 11) || ($hwModel == 21) } {
            set gettingSample false
            doATcommand "ATEVENT"
            if { ($responseIsError == 0) && [string is integer $lastnum] } {
                #		puts "Raw event: $lastnum"
                # Ignore the DIM bit (fires on any dimming change), LUX low, and CCT bounds
                #		puts "ATEVENT lastnum: $lastnum"
                set lastnum [expr $lastnum & 0xFFF1]
                #		puts "Masked raw event: $lastnum"
                if { $lastnum != 0 } {
                    #		    puts "Non-zero event: $lastnum"
                    # IR dimming?
                    if { [expr $lastnum & 0x0200] != 0 } {
                        # 0-10V dimming?
                        if { [expr $lastnum & 0x0100] != 0 } {
                            # Scene fired?
                            if { [expr $lastnum & 0x0010] != 0 } {
                                # Occupancy event?
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "IR remote, 0-10V dim, Scene, Occ"
                                } else {
                                    set statusLastEventString "IR remote, 0-10V dim, Scene"
                                }
                            } else {
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "IR remote, 0-10V dim, Occ"
                                } else {
                                    set statusLastEventString "IR remote, 0-10V dim"
                                }
                            }
                        } else {
                            # No 0-10V.  Scene fired?
                            if { [expr $lastnum & 0x0010] != 0 } {
                                # Occupancy event?
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "IR remote, Scene, Occ"
                                } else {
                                    set statusLastEventString "IR remote, Scene"
                                }
                            } else {
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "IR remote, Occ"
                                } else {
                                    set statusLastEventString "IR remote"
                                }
                            }
                        }
                    } else {
                        # No IR event
                        # 0-10V dimming?
                        if { [expr $lastnum & 0x0100] != 0 } {
                            # Scene fired?
                            if { [expr $lastnum & 0x0010] != 0 } {
                                # Occupancy event?
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "0-10V dim, Scene, Occ"
                                } else {
                                    set statusLastEventString "0-10V dim, Scene"
                                }
                            } else {
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "0-10V dim, Occ"
                                } else {
                                    set statusLastEventString "0-10V dim"
                                }
                            }
                        } else {
                            # No 0-10V.  Scene fired?
                            if { [expr $lastnum & 0x0010] != 0 } {
                                # Occupancy event?
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "Scene, Occ"
                                } else {
                                    set statusLastEventString "Scene"
                                }
                            } else {
                                if { [expr $lastnum & 0x0001] != 0 } {
                                    set statusLastEventString "Occ"
                                } else {
                                    set statusLastEventString ""
                                }
                            }
                        }
                    }
                    if { $lastnum } {
                        #			puts "Event reg=$lastnum"
                        set statusLastEvent $lastnum
                        $lastEventWidget configure -text "$statusLastEventString"
                    }
                }
                #		puts "Event=$statusLastEvent"
            }
            set gettingSample true
        }

        if { $vLogging } {
            puts -nonewline $logFile "$sampleCount$logFileCsvDelimiter "
        }
        set i 0
        set len [llength $lWidgets]
        #	puts "s:$sampleCount len:$len Set: $sampleSet"
        #	puts "UpDP: $lUpdateProcs Widgets: $lWidgets"
        if { ($hwModel == 65) } {
            foreach rawDataParam $rawDataParams rawDataValue $rawDataValues {
                # get sample value
                # Update the display.
                set subsample [lindex $sampleSet [lindex $rawDataParam 1]]
                if { ($calibrationMode == 0) } {
                    $rawDataValue configure -text $subsample       
                } else {
                    set calibsubsample [lindex $calibSampleSet [lindex $rawDataParam 1]]
                    $rawDataValue configure -text $calibsubsample       
                }
                # Save to the log file as needed
                if { $vLogging } {
                    puts -nonewline $logFile $subsample
                    if { $i <= $lWidgetHighIndex } {
                        puts -nonewline $logFile "$logFileCsvDelimiter "
                    }
                }
                incr i
                if { $i >= $len } {
                    break ;
                }
            }
            # log calibrated data
            if { $vLogging } {
                if { ([checkForNewFwVersion { 65 } 1] == true) } {
                    set i 0
                    foreach rawDataParam $rawDataParams rawDataValue $rawDataValues {
                        # get sample value
                        set calibsubsample [lindex $calibSampleSet [lindex $rawDataParam 1]]
                        # Save to the log file as needed
                        puts -nonewline $logFile $calibsubsample
                        if { $i <= $lWidgetHighIndex } {
                            puts -nonewline $logFile "$logFileCsvDelimiter "
                        }
                        incr i
                        if { $i >= $len } {
                            break ;
                        }
                    }
                }
            }
            if { ($dataDisplayMode == 2) } {
                if { ($calibrationMode == 0) } {
                    showSpectrum $sampleSet
                } else {
                    showSpectrum $calibSampleSet
                }
            }
        } else {
            # puts $sampleSet 
            foreach subsample $sampleSet widge $lWidgets updp $lUpdateProcs {
                #	    puts "i=$i updp=$updp widge=$widge subsample=$subsample"
                # Update the display.
                $updp $widge $subsample
                # Save to the log file as needed
                if { $vLogging } {
                    if { ((($hwModel == 61) && ($scModel == 1)) == 0)  || ($bIncludeDerivedVals == 1) } {
                        puts -nonewline $logFile $subsample
                        if { $i <= $lWidgetHighIndex } {
                            puts -nonewline $logFile "$logFileCsvDelimiter "
                            #			puts -nonewline ", "
                        }
                    } else {
                        # Don't want to log the derived values
                        if { ($tcsMode == 2) && ($i < 6) } {
                            # TCS_MODE X, Y, Z, Dk, nIR, and Cl
                            puts -nonewline $logFile "$subsample$logFileCsvDelimiter "
                        } elseif { ($tcsMode == 1) && ($i < 5) } {
                            # TCS_MODE X, Y, Z, Dk, and nIR
                            puts -nonewline $logFile "$subsample$logFileCsvDelimiter "
                        } elseif { ($tcsMode == 0) && ($i < 4) } {
                            # TCS_MODE X, Y, Z, and Dk
                            puts -nonewline $logFile "$subsample$logFileCsvDelimiter "
                        } elseif { ($tcsMode == 3) && ($i == 0) } {
                            # TCS_MODE nIR only.  Nothing to do.
                            puts -nonewline $logFile "$subsample$logFileCsvDelimiter "
                        }
                    }
                }
                incr i
                if { $i >= $len } {
                    break ;
                }
            }
        }
        if { $vLogging } {
            if { ($hwModel == 21) || ($hwModel == 65) } {
                doATcommand "ATINTTIME"
                if { $responseIsError == 0 } {
                    puts -nonewline $logFile "$lastnum$logFileCsvDelimiter "
                }
                doATcommand "ATGAIN"
                if { $responseIsError == 0 } {
                    puts -nonewline $logFile "$lastnum$logFileCsvDelimiter "
                }
                set sampleSet {}
                doATcommand "ATTEMP"
                if { $responseIsError == 0 } {
                    # puts "Temp value: $lastnum $sampleSet"
                    if { ($hwModel == 65) } {
                        puts -nonewline $logFile "[lindex $sampleSet 0]$logFileCsvDelimiter "
                        puts -nonewline $logFile "[lindex $sampleSet 1]$logFileCsvDelimiter "
                        puts -nonewline $logFile "[lindex $sampleSet 2]$logFileCsvDelimiter "
                    } else {
                        puts -nonewline $logFile "$lastnum$logFileCsvDelimiter "
                    }
                }
            }
            puts $logFile "$tstamp"
            #	    puts "$tstamp"
        }
    } else {
        # Incomplete sample, likely due to timeout.
        incr badSampleCount
        #	puts "Bad samples=$badSampleCount"
        # Special case for the AS7261 when it is not getting valid calibrated values:
        if { ($hwModel == 61) && ($scModel == 1) } {
            set i 0
            if { $tcsMode == 2 } {
                set showNum 6
            } elseif { $tcsMode == 1 } {
                set showNum 5
            } elseif { $tcsMode == 0 } {
                set showNum 4
            } elseif { $tcsMode == 3 } {
                set showNum 1
            } else {
                set showNum 0
            }
            foreach subsample $sampleSet widge $lWidgets updp $lUpdateProcs {
                if { $i >= $showNum} {
                    break ;
                }
                #		puts "i=$i updp=$updp widge=$widge subsample=$subsample"
                # Update the display.
                $updp $widge $subsample
                incr i
            }
        }
    }

    # Restore the previous state of the update button.
    if { $autoRunning == false } {
        $manualButtonWidget configure -state $updateButtonPrevState
    }
    set gettingSample false
    # Show most recently written data at bottom.

}

proc doTCSmodeSelect61 {} {
    global tcsMode
    global sampleInterval
    global sampleIntervalIndex
    global sampleFreq
    global inttime
    global inttimeindex
    global minSI
    global sampleWidgetNames
    global lWidgets
    global lWidgetHighIndex
    global lUpdateProcs
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global CS1label
    global CS2label
    global CS3label
    global usingI2Cadapter
    global autoSampleInterval
    global usingI2Cadapter
    global scModel

    if { $scModel == 1 } {
        if { $tcsMode == 4 } {
            # TCS_MODE_OFF
            .sCntrlFrame.sampleInterval configure -state disabled
            set m 1
            set minSI [expr {double(round(10*[expr $inttime * 3]))/10}]

            .svFrame.s1_value configure -text ""
            .svFrame.s2_value configure -text ""
            .svFrame.s3_value configure -text ""
            .svFrame.s4_value configure -text ""
            .svFrame.s5_value configure -text ""
            .svFrame.s6_value configure -text ""
            .csvFrame.cs1_value configure -text ""
            .csvFrame.cs2_value configure -text ""
            .csvFrame.cs3_value configure -text ""
            .derFrame.cct_value configure -text ""
            .derFrame.duv_value configure -text ""
            .derFrame.up_value configure -text ""
            .derFrame.vp_value configure -text ""
            .derFrame.u_value configure -text ""
            .derFrame.v_value configure -text ""
            .derFrame.x_value configure -text ""
            .derFrame.y_value configure -text ""
            # Disable all of the raw sensor metrics (no sampling)
            .svFrame.s1_value configure -state disabled
            .svFrame.s2_value configure -state disabled
            .svFrame.s3_value configure -state disabled
            .svFrame.s4_value configure -state disabled
            .svFrame.s5_value configure -state disabled
            .svFrame.s6_value configure -state disabled
            # Disable the calibrated sensor metrics (no sampling)
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values (no sampling)
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled
        } elseif { ($tcsMode == 0) || ($tcsMode == 5) } {
            # TCS_MODE X, Y, Z, and Dk
            set minSI $inttime
            .sCntrlFrame.sampleInterval configure -state normal
            .sCntrlFrame.sampleInterval configure -from $minSI -to [expr $minSI * 255] -increment $minSI
            set m 1
            # Enable X, Y, Z, and Dk
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s4_value configure -state normal
            # Write "--  " to the soon to be disabled text fields
            .svFrame.s5_value configure -text "--  "
            .svFrame.s6_value configure -text "--  "
            .csvFrame.cs1_value configure -text "--  "
            .csvFrame.cs2_value configure -text "--  "
            .csvFrame.cs3_value configure -text "--  "
            .derFrame.cct_value configure -text "--  "
            .derFrame.duv_value configure -text "--  "
            .derFrame.up_value configure -text "--  "
            .derFrame.vp_value configure -text "--  "
            .derFrame.u_value configure -text "--  "
            .derFrame.v_value configure -text "--  "
            .derFrame.x_value configure -text "--  "
            .derFrame.y_value configure -text "--  "

            # Disable the nIR and Cl display boxes
            .svFrame.s5_value configure -state disabled
            .svFrame.s6_value configure -state disabled
            # Disable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled

            set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
                .svFrame.s4_value]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]
            set lUpdateProcs [list updateText updateText updateText updateText]
        } elseif { ($tcsMode == 1) } {
            # TCS_MODE X, Y, Z, Dk, and nIR
            set minSI [expr {double(round(10*[expr $inttime * 2]))/10}]
            .sCntrlFrame.sampleInterval configure -state normal
            .sCntrlFrame.sampleInterval configure -from $minSI -to [expr $minSI * 255] -increment $minSI
            set m 2
            # Enable X, Y, Z, Dk, and nIR
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s4_value configure -state normal
            # Disable the Cl display boxes
            .svFrame.s6_value configure -text "--  "
            .svFrame.s6_value configure -state disabled
            # Enable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal
            # Enable the computed values
            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal

            set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $S5label, $CS1label, $CS2label, $CS3label, CCT, Duv, u', v', u, v, x, y, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
                .svFrame.s4_value .svFrame.s5_value \
                .csvFrame.cs1_value .csvFrame.cs2_value .csvFrame.cs3_value \
                .derFrame.cct_value .derFrame.duv_value \
                .derFrame.up_value  .derFrame.vp_value  \
                .derFrame.u_value .derFrame.v_value \
                .derFrame.x_value .derFrame.y_value]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]

            set lUpdateProcs [list updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText ]

        } elseif { $tcsMode == 2 } {
            # TCS_MODE X, Y, Z, Dk, nIR, and Cl
            set minSI [expr {double(round(10*[expr $inttime * 3]))/10}]
            .sCntrlFrame.sampleInterval configure -state normal
            .sCntrlFrame.sampleInterval configure -from $minSI -to [expr $minSI * 255] -increment $minSI
            set m 3
            # Enable X, Y, Z, Dk, nIR, and Cl
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s6_value configure -state normal
            # Enable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal
            # Enable the computed values
            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal

            set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $S5label, $S6label, $CS1label, $CS2label, $CS3label, CCT, Duv, u', v', u, v, x, y, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
                .svFrame.s4_value .svFrame.s5_value .svFrame.s6_value \
                .csvFrame.cs1_value .csvFrame.cs2_value .csvFrame.cs3_value \
                .derFrame.cct_value .derFrame.duv_value \
                .derFrame.up_value  .derFrame.vp_value  \
                .derFrame.u_value .derFrame.v_value \
                .derFrame.x_value .derFrame.y_value]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]

            set lUpdateProcs [list updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText updateText ]
        } elseif { ($tcsMode == 3) || ($tcsMode == 6) } {
            # TCS_MODE nIR only
            set minSI $inttime
            .sCntrlFrame.sampleInterval configure -state normal
            .sCntrlFrame.sampleInterval configure -from $minSI -to [expr $minSI * 255] -increment $minSI
            set m 1
            # Enable nIR only
            .svFrame.s5_value configure -state normal
            .svFrame.s1_value configure -text "--  "
            .svFrame.s2_value configure -text "--  "
            .svFrame.s3_value configure -text "--  "
            .svFrame.s4_value configure -text "--  "
            .svFrame.s6_value configure -text "--  "
            .csvFrame.cs1_value configure -text "--  "
            .csvFrame.cs2_value configure -text "--  "
            .csvFrame.cs3_value configure -text "--  "
            .derFrame.cct_value configure -text "--  "
            .derFrame.duv_value configure -text "--  "
            .derFrame.up_value configure -text "--  "
            .derFrame.vp_value configure -text "--  "
            .derFrame.u_value configure -text "--  "
            .derFrame.v_value configure -text "--  "
            .derFrame.x_value configure -text "--  "
            .derFrame.y_value configure -text "--  "
            # Disable X, Y, Z, Dk, and Cl
            .svFrame.s1_value configure -state disabled
            .svFrame.s2_value configure -state disabled
            .svFrame.s3_value configure -state disabled
            .svFrame.s4_value configure -state disabled
            .svFrame.s6_value configure -state disabled
            # Disable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled
            set sampleWidgetNames "Sample, $S5label, Timestamp"
            set lWidgets [list .svFrame.s5_value ]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]

            set lUpdateProcs [list updateText ]
        }
    } elseif { $scModel == 2} {
        if { $tcsMode == 3 } {
            # TCS_MODE_OFF
            set m 1
            set minSI [expr {double(round(10*[expr $inttime * 1]))/10}]

            .svFrame.s1_value configure -text ""
            .svFrame.s2_value configure -text ""
            .svFrame.s3_value configure -text ""
            .svFrame.s4_value configure -text ""
            .svFrame.s5_value configure -text ""
            .svFrame.s6_value configure -text ""
            .csvFrame.cs1_value configure -text ""
            .csvFrame.cs2_value configure -text ""
            .csvFrame.cs3_value configure -text ""
            .derFrame.cct_value configure -text ""
            .derFrame.duv_value configure -text ""
            .derFrame.up_value configure -text ""
            .derFrame.vp_value configure -text ""
            .derFrame.u_value configure -text ""
            .derFrame.v_value configure -text ""
            .derFrame.x_value configure -text ""
            .derFrame.y_value configure -text ""
            # Disable all of the raw sensor metrics (no sampling)
            .svFrame.s1_value configure -state disabled
            .svFrame.s2_value configure -state disabled
            .svFrame.s3_value configure -state disabled
            .svFrame.s4_value configure -state disabled
            .svFrame.s5_value configure -state disabled
            .svFrame.s6_value configure -state disabled
            # Disable the calibrated sensor metrics (no sampling)
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values (no sampling)
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled
        } elseif { $tcsMode == 0 } {
            # TCS_MODE X, Y, Z, nIR
            set minSI $inttime
            set m 1
            # Enable X, Y, Z, and nIR
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s5_value configure -state normal
            # Write "--  " to the soon to be disabled text fields
            .svFrame.s4_value configure -text "--  "
            .svFrame.s6_value configure -text "--  "
            .csvFrame.cs1_value configure -text "--  "
            .csvFrame.cs2_value configure -text "--  "
            .csvFrame.cs3_value configure -text "--  "
            .derFrame.cct_value configure -text "--  "
            .derFrame.duv_value configure -text "--  "
            .derFrame.up_value configure -text "--  "
            .derFrame.vp_value configure -text "--  "
            .derFrame.u_value configure -text "--  "
            .derFrame.v_value configure -text "--  "
            .derFrame.x_value configure -text "--  "
            .derFrame.y_value configure -text "--  "

            # Disable the Dk and Cl display boxes
            .svFrame.s4_value configure -state disabled
            .svFrame.s6_value configure -state disabled
            # Disable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled

            set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S5label, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
                .svFrame.s5_value]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]
            set lUpdateProcs [list updateText updateText updateText updateText]
        } elseif { ($tcsMode == 1) } {
            # TCS_MODE X, Y, Dk, and Cl
            set minSI [expr {double(round(10*[expr $inttime * 1]))/10}]
            set m 1
            # Enable X, Y, Dk, and Cl
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s6_value configure -state normal
            # Disable the nIR display boxes
            .svFrame.s3_value configure -text "--  "
            .svFrame.s5_value configure -text "--  "
            .svFrame.s3_value configure -state disabled
            .svFrame.s5_value configure -state disabled
            # Disable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state disabled
            .csvFrame.cs2_value configure -state disabled
            .csvFrame.cs3_value configure -state disabled
            # Disable the computed values
            .derFrame.cct_value configure -state disabled
            .derFrame.duv_value configure -state disabled
            .derFrame.up_value configure -state disabled
            .derFrame.vp_value configure -state disabled
            .derFrame.u_value configure -state disabled
            .derFrame.v_value configure -state disabled
            .derFrame.x_value configure -state disabled
            .derFrame.y_value configure -state disabled

            set sampleWidgetNames "Sample, $S1label, $S2label, $S4label, $S6label, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value \
                .svFrame.s4_value .svFrame.s6_value ]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]

            set lUpdateProcs [list updateText updateText updateText \
                updateText updateText ]
        } elseif { $tcsMode == 2 } {
            # TCS_MODE X, Y, Z, Dk, nIR, and Cl
            set minSI [expr {double(round(10*[expr $inttime * 2]))/10}]
            set m 2
            # Enable X, Y, Z, Dk, nIR, and Cl
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s6_value configure -state normal
            # Enable the calibrated sensor metrics
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal
            # Enable the computed values
            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal

            set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $S5label, $S6label, $CS1label, $CS2label, $CS3label, CCT, Duv, u', v', u, v, x, y, Timestamp"
            set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
                .svFrame.s4_value .svFrame.s5_value .svFrame.s6_value \
                .csvFrame.cs1_value .csvFrame.cs2_value .csvFrame.cs3_value \
                .derFrame.cct_value .derFrame.duv_value \
                .derFrame.up_value  .derFrame.vp_value  \
                .derFrame.u_value .derFrame.v_value \
                .derFrame.x_value .derFrame.y_value]
            set lWidgetHighIndex [expr [llength $lWidgets] - 1]

            set lUpdateProcs [list updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText updateText \
                updateText updateText ]
        }
    }

    if { $scModel == 1 } {
        #	puts "sampleIntervalIndex=$sampleIntervalIndex"
        set sampleInterval [expr [expr 2.8 * $m] * $sampleIntervalIndex]
        if { $sampleInterval < $minSI } {
            set sampleInterval $minSI
        }

        # Round it to the nearest tenth.
        set sampleInterval [expr {double(round(10*$sampleInterval))/10}]
        #	puts "sampleInterval=>$sampleInterval"
        set sampleFreq [expr 1000.0 / $sampleInterval]

        set autoSampleInterval [expr [expr { int( $inttime) } ] * $m]
        if { $usingI2Cadapter } {
            set autoSampleInterval [expr $autoSampleInterval + 100]
        }
        .sCntrlFrame.sampleInterval set $sampleInterval
        doSetSampleInterval $sampleInterval
    } elseif { $scModel == 2 } {
        set sampleInterval [expr [expr 2.8 * $m] * $inttimeindex]
    }

    doATcommand "ATTCSMD=$tcsMode"

    # Show most recently written data at bottom.

}

proc doTCSmodeSelect62n3 {} {
    global tcsMode
    global sampleInterval
    global sampleIntervalIndex
    global sampleFreq
    global inttime
    global minSI
    global sampleWidgetNames
    global lWidgets
    global lWidgetHighIndex
    global lUpdateProcs
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global CS1label
    global CS2label
    global CS3label
    global usingI2Cadapter
    global autoSampleInterval
    global usingI2Cadapter
    global scModel

    if { $tcsMode == 3 } {
        # TCS_MODE_OFF
        .svFrame.s1_value configure -text ""
        .svFrame.s2_value configure -text ""
        .svFrame.s3_value configure -text ""
        .svFrame.s4_value configure -text ""
        .svFrame.s5_value configure -text ""
        .svFrame.s6_value configure -text ""
        # Disable all of the raw sensor metrics (no sampling)
        .svFrame.s1_value configure -state disabled
        .svFrame.s2_value configure -state disabled
        .svFrame.s3_value configure -state disabled
        .svFrame.s4_value configure -state disabled
        .svFrame.s5_value configure -state disabled
        .svFrame.s6_value configure -state disabled

        .svFrame.cs1_value configure -text ""
        .svFrame.cs2_value configure -text ""
        .svFrame.cs3_value configure -text ""
        .svFrame.cs4_value configure -text ""
        .svFrame.cs5_value configure -text ""
        .svFrame.cs6_value configure -text ""
        # Disable all of the calibrated sensor metrics (no sampling)
        .svFrame.cs1_value configure -state disabled
        .svFrame.cs2_value configure -state disabled
        .svFrame.cs3_value configure -state disabled
        .svFrame.cs4_value configure -state disabled
        .svFrame.cs5_value configure -state disabled
        .svFrame.cs6_value configure -state disabled
    } elseif { $tcsMode == 0 } {
        # TCS_MODE V, B, G, Y
        set minSI $inttime
        set m 1
        .svFrame.s1_value configure -state normal
        .svFrame.s2_value configure -state normal
        .svFrame.s3_value configure -state normal
        .svFrame.s4_value configure -state normal
        .svFrame.cs1_value configure -state normal
        .svFrame.cs2_value configure -state normal
        .svFrame.cs3_value configure -state normal
        .svFrame.cs4_value configure -state normal
        # Write "--  " to the soon to be disabled text fields
        .svFrame.s5_value configure -state disabled
        .svFrame.s6_value configure -state disabled
        .svFrame.s5_value configure -text "--  "
        .svFrame.s6_value configure -text "--  "
        .svFrame.cs5_value configure -state disabled
        .svFrame.cs6_value configure -state disabled
        .csvFrame.cs5_value configure -text "--  "
        .csvFrame.cs6_value configure -text "--  "

        set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $CS1label, $CS2label, $CS3label, $CS4label, Timestamp"
        set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
            .svFrame.s4_value  .svFrame.cs1_value .svFrame.cs2_value .svFrame.cs3_value \
            .svFrame.cs4_value ]
        set lWidgetHighIndex [expr [llength $lWidgets] - 1]
        set lUpdateProcs [list updateText updateText updateText updateText]
    } elseif { ($tcsMode == 1) } {
        # TCS_MODE G, Y, O, R
        set minSI [expr {double(round(10*[expr $inttime * 1]))/10}]
        set m 1
        .svFrame.s3_value configure -state normal
        .svFrame.s4_value configure -state normal
        .svFrame.s5_value configure -state normal
        .svFrame.s6_value configure -state normal
        # Disable the V and B boxes
        .svFrame.s1_value configure -text "--  "
        .svFrame.s1_value configure -state disabled
        .svFrame.s2_value configure -text "--  "
        .svFrame.s2_value configure -state disabled

        .svFrame.cs1_value configure -text "--  "
        .svFrame.cs1_value configure -state disabled
        .svFrame.cs2_value configure -text "--  "
        .svFrame.cs2_value configure -state disabled

        set sampleWidgetNames "Sample, $S3label, $S4label, $S5label, $S6label, $CS3label, $CS4label, $CS5label, $CS6label, Timestamp"
        set lWidgets [list .svFrame.s3_value .svFrame.s4_value .svFrame.s5_value \
            .svFrame.s6_value  .svFrame.cs3_value .svFrame.cs4_value .svFrame.cs5_value \
            .svFrame.cs6_value ]

        set lWidgetHighIndex [expr [llength $lWidgets] - 1]

        set lUpdateProcs [list updateText updateText updateText \
            updateText updateText ]
    } elseif { $tcsMode == 2 } {
        # TCS_MODE: All skate
        set minSI [expr {double(round(10*[expr $inttime * 2]))/10}]
        set m 2
        .svFrame.s1_value configure -state normal
        .svFrame.s2_value configure -state normal
        .svFrame.s3_value configure -state normal
        .svFrame.s5_value configure -state normal
        .svFrame.s4_value configure -state normal
        .svFrame.s6_value configure -state normal
        # Enable the calibrated sensor metrics
        .csvFrame.cs1_value configure -state normal
        .csvFrame.cs2_value configure -state normal
        .csvFrame.cs3_value configure -state normal
        .csvFrame.cs4_value configure -state normal
        .csvFrame.cs5_value configure -state normal
        .csvFrame.cs6_value configure -state normal

        set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $S5label, $S6label, $CS1label, $CS2label, $CS3label, $CS4label, $CS5label, $CS6label, Timestamp"
        set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
            .svFrame.s4_value .svFrame.s5_value .svFrame.s6_value \
            .csvFrame.cs1_value .csvFrame.cs2_value .csvFrame.cs3_value \
            .csvFrame.cs4_value .csvFrame.cs5_value .csvFrame.cs6_value ]
        set lWidgetHighIndex [expr [llength $lWidgets] - 1]

        set lUpdateProcs [list updateText updateText updateText \
            updateText updateText updateText \
            updateText updateText updateText \
            updateText updateText updateText ]
    }

    #    puts "sampleIntervalIndex=$sampleIntervalIndex"
    set sampleInterval [expr [expr 2.8 * $m] * $sampleIntervalIndex]
    if { $sampleInterval < $minSI } {
        set sampleInterval $minSI
    }

    # Round it to the nearest tenth.
    set sampleInterval [expr {double(round(10*$sampleInterval))/10}]
    #    puts "sampleInterval=>$sampleInterval"
    set sampleFreq [expr 1000.0 / $sampleInterval]

    set autoSampleInterval [expr [expr { int( $inttime) } ] * $m]
    # TEMP: STRETCH THE DELAY
    set autoSampleInterval [expr $autoSampleInterval + 500 ]
    if { $usingI2Cadapter } {
        set autoSampleInterval [expr $autoSampleInterval + 10]
    }
    #    puts "MODE62 TCSmode=$tcsMode"

    doATcommand "ATTCSMD=$tcsMode"

    # Show most recently written data at bottom.

}

proc doSetSampleInterval {s} {
    global sampleInterval
    global sampleIntervalIndex
    global sampleFreq
    global tcsMode
    global minSI

    set sampleInterval $s
    #    puts "sampleInterval=$sampleInterval"
    set sampleFreq [expr 1000.0 / $sampleInterval]
    if { $tcsMode == 4 } {
        .sCntrlFrame.sampleInterval configure -state disabled
        set sampleIntervalIndex 1
    } else {
        set sampleIntervalIndex [expr int( [expr $s / $minSI ]) ]
        #	puts "sampleIntervalIndex=$sampleIntervalIndex"

        # Tell the device to change its sample interval
        doATcommand "ATINTRVL=$sampleIntervalIndex"

        # Show most recently written data at bottom.

    }
}

proc doSetIntTime {s} {
    global inttime
    global inttimeindex
    global port_com
    global autoSampleInterval
    global hwModel
    global tcsMode
    global usingI2Cadapter

    if { $s != "" } {
        set inttime $s
    }
    # How often can we get a fresh sample? Well, that depends on the model...
    if { ($hwModel == 11) || ($hwModel == 21) } {
        # We use IR, and XYZ_Dk here, so two integrations per set.
        set autoSampleInterval [expr [expr { int( $inttime) } ] * 2]
    } elseif { $hwModel == 61 } {
        #	puts "tcsMode = $tcsMode"
        if { $tcsMode == 0 }  {
            set m 1
        } elseif { $tcsMode == 1 } {
            set m 2
        } elseif { $tcsMode == 2 } {
            set m 3
        } elseif { $tcsMode == 3 } {
            set m 1
        } elseif { $tcsMode == 5 } {
            set m 1
        } elseif { $tcsMode == 6 } {
            set m 1
        }
        set autoSampleInterval [expr [expr { int( $inttime) } ] * $m]
        if { $usingI2Cadapter } {
            set autoSampleInterval [expr $autoSampleInterval + 10]
        }
        #	puts "SetIntTime TCSmode=$tcsMode autoSampleInterval=$autoSampleInterval"
    } elseif { $hwModel == 25 } {
        set autoSampleInterval [expr [expr [expr { int( $inttime) } ] * 2] + 10]
        #	puts "inttime = $inttime and autoSampleInterval=$autoSampleInterval"
    } else {
        # For now, assume only one integration on other models.  SUBJECT TO CHANGE.
        set autoSampleInterval [expr { int( $inttime) } ]
    }

    set inttimeindex [expr int($inttime / 2.8)]
    if { $inttimeindex < 1 } {
        set inttimeindex 1        
    }
    if { $inttimeindex > 255 } {
        set inttimeindex 255        
    }
    set inttime [format "%.1f" [expr $inttimeindex * 2.8]]
    #    puts "inttimeindex=$inttimeindex"

    # Tell the device to change its integration time
    # puts $port_com "ATINTTIME=$inttimeindex"
    doATcommand "ATINTTIME=$inttimeindex"

    # Show most recently written data at bottom.

    if { $hwModel == 61 } {
        doTCSmodeSelect61
    }
    if { 0 } {
        # AS7262 or AS7263
        doTCSmodeSelect62n3
    }
}

proc doSetGain {s} {
    global again
    global port_com
    global againstring

    set againstring $s
    if { $s == "1x" } {
        set again 0
    } elseif { $s == "3.7x" } {
        set again 1
    } elseif { $s == "16x" } {
        set again 2
    } else {
        set again 3
    }
    # puts "again is $s or value $again"
    # Tell the device to change the gain setting
    doATcommand "ATGAIN=$again"

    # Show most recently written data at bottom.

}

proc doAutoMode {} {
    global curmode
    global sampleCount
    global sampleTarget
    global vLogging
    global logFile
    global logFileName
    global autoRunning
    global inAutoMode
    global updateButtonState
    global manualButtonWidget
    global sampleTargetWidget
    global led0ControlWidget
    global led1ControlWidget
    global led2ControlWidget ""
    global led3ControlWidget ""
    global autoSampleInterval
    global bUpdateModeAuto
    global hwModel
    global usingI2Cadapter
    global bIncludeDerivedVals
    global scModel

    # Before beginning the fun, disable controls that must remain
    # static while in Auto mode and running.
    set autoRunning true
    $manualButtonWidget configure -text "  Stop     "
    # .sCntrlFrame.int_time configure -state disabled
    # .sCntrlFrame.gain     configure -state disabled
    .logFrame.logSelect configure -state disabled
    if { $hwModel == 61 } {
        if { $scModel == 1 } {
            .sCntrlFrame.tcsModeDisabled   configure -state disabled
            .sCntrlFrame.tcsModeXYZDk      configure -state disabled
            .sCntrlFrame.tcsModeXYZDkIR    configure -state disabled
            .sCntrlFrame.tcsModeXYZDkIRCl  configure -state disabled
            .sCntrlFrame.sampleInterval    configure -state disabled
        } elseif { $scModel == 2 } {
            .sCntrlFrame.tcsMode0          configure -state disabled
            .sCntrlFrame.tcsMode1          configure -state disabled
            .sCntrlFrame.tcsMode2          configure -state disabled
        }
    }

    if { $led0ControlWidget != "" } {
        $led0ControlWidget configure -state disabled
    }
    if { $led1ControlWidget != "" } {
        $led1ControlWidget configure -state disabled
    }
    if { $led2ControlWidget != "" } {
        $led2ControlWidget configure -state disabled
    }
    if { $led3ControlWidget != "" } {
        $led3ControlWidget configure -state disabled
    }

    while { ($curmode == "Auto") && ($autoRunning == true) } {

        # Update any manually entered AT commands that may be pending.
        doManualATcommands
        
        # process AT commands from list
        set inAutoMode true
        doATcommandList        
        set inAutoMode false

        # Refresh the password timer.
        doUpdatePasswordTimer

        if { $updateButtonState == 3 } {
            set autoRunning false
            if { $bUpdateModeAuto } {
                $manualButtonWidget configure -text "  Start    "
            } else {
                $manualButtonWidget configure -text " Sample "
            }

            # .sCntrlFrame.int_time configure -state readonly
            # .sCntrlFrame.gain     configure -state readonly

            .logFrame.logSelect configure -state normal
            if { $led0ControlWidget != "" } {
                $led0ControlWidget configure -state normal
            }
            if { $led1ControlWidget != "" } {
                $led1ControlWidget configure -state normal
            }
            if { $led2ControlWidget != "" } {
                $led2ControlWidget configure -state normal
            }
            if { $led3ControlWidget != "" } {
                $led3ControlWidget configure -state normal
            }
            if { $hwModel == 61 } {
                if { $scModel == 1 } {
                    .sCntrlFrame.tcsModeDisabled   configure -state normal
                    .sCntrlFrame.tcsModeXYZDk      configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIR    configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIRCl  configure -state normal
                    .sCntrlFrame.sampleInterval    configure -state readonly
                } elseif { $scModel == 2 } {
                    .sCntrlFrame.tcsMode0          configure -state normal
                    .sCntrlFrame.tcsMode1          configure -state normal
                    .sCntrlFrame.tcsMode2          configure -state normal
                }
            }
            return
        }
        if { [string is integer -strict $sampleTarget] && \
                (( $sampleTarget > 0 ) && ( $sampleCount >= $sampleTarget )) } {
            # We hit the stopping point.  Stop but remain in Auto mode.
            $manualButtonWidget configure -state normal
            $manualButtonWidget configure -text "  Start    "
            # Reset the sample target value.
            set sampleTarget ""
            $sampleTargetWidget delete 0 end
            # .sCntrlFrame.int_time configure -state readonly
            # .sCntrlFrame.gain     configure -state readonly
            .logFrame.logSelect configure -state normal
            if { $led0ControlWidget != "" } {
                $led0ControlWidget configure -state normal
            }
            if { $led1ControlWidget != "" } {
                $led1ControlWidget configure -state normal
            }
            if { $led2ControlWidget != "" } {
                $led2ControlWidget configure -state normal
            }
            if { $led3ControlWidget != "" } {
                $led3ControlWidget configure -state normal
            }
            if { $hwModel == 61 } {
                if { $scModel == 1 } {
                    .sCntrlFrame.tcsModeDisabled   configure -state normal
                    .sCntrlFrame.tcsModeXYZDk      configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIR    configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIRCl  configure -state normal
                    .sCntrlFrame.sampleInterval    configure -state readonly
                } elseif { $scModel == 2 } {
                    .sCntrlFrame.tcsMode0          configure -state normal
                    .sCntrlFrame.tcsMode1          configure -state normal
                    .sCntrlFrame.tcsMode2          configure -state normal
                }
            }
            set autoRunning false
            set updateButtonState 3

            if { $vLogging } {
                .logFrame.logFileFrame.logName configure -text "<none>              "
                .logFrame.logSelect configure -text " Open Data Log "
                set vLogging false
                flush $logFile
                close $logFile
                set logFile ""
            }
            return
        }
        # Pause for the integration time to avoid over-running the device.
        # I2C interface devices/modes pause in doGetSample to set one-shot mode.
        if { $usingI2Cadapter == false } {
            set vw 0
            after $autoSampleInterval set vw 1
            vwait vw
        }
        # get sample
        set inAutoMode true
        doGetSampleSync
        set inAutoMode false
    }
}

# updateButtonState values:
#     0: Manual mode idle
#     1: Manual mode update pressed, awaiting a sample
#     2: Auto mode, taking samples and kicking names.
#     3: Auto mode, idle awaiting "Start"
#     4: Burst mode, spewing to log file
#     5: Burst mode, idle awaiting file close
proc doUpdateButton {} {
    global updateButtonState
    global curmode
    global autoRunning
    global hwModel
    global vLogging
    global enableBurstMode

    #    puts "E:mode=$curmode   autoRunning=$autoRunning   vLogging=$vLogging updateButtonState=$updateButtonState"
    if { $curmode == "Auto" } {
        if { $vLogging && ($hwModel == 61) && $enableBurstMode } {
            if { $autoRunning } {
                set updateButtonState 5
            } else {
                set updateButtonState 4
            }
        } else {
            # puts "Update button: $autoRunning $updateButtonState"
            if { $autoRunning } {
                set updateButtonState 3
            } else {
                set updateButtonState 2
            }
            # puts "Update button: $autoRunning $updateButtonState"
        }
    } else {
        set updateButtonState 1
    }
    #    puts "L:mode=$curmode   autoRunning=$autoRunning   vLogging=$vLogging updateButtonState=$updateButtonState"
}

proc doBurstMode {} {
    global curmode
    global sampleCount
    global sampleTarget
    global vLogging
    global logFile
    global logFileName
    global autoRunning
    global updateButtonState
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global led0ControlWidget
    global led1ControlWidget
    global led2ControlWidget
    global led3ControlWidget
    global autoSampleInterval
    global bUpdateModeAuto
    global hwModel
    global vBursting
    global quietMode
    global tcsMode
    global vFiltering
    global numFilters
    global aFilterFreq1
    global aFilterFreq2
    global aFilterTaps
    global aFilterTypes
    global aFilterTypeNums
    global aFilterTextWidgets
    global filteredFileName
    global filteredFile
    global filterApp
    global sampleInterval
    global sampleFreq
    global usingI2Cadapter
    global scModel

    # Before beginning the fun, disable controls that must remain
    # static while Bursting.
    set autoRunning true
    $manualButtonWidget configure -text "  Stop     "
    .sCntrlFrame.int_time configure -state disabled
    .sCntrlFrame.gain     configure -state disabled
    .logFrame.logSelect configure -state disabled

    if { $hwModel == 61 } {
        if { $scModel == 1 } {
            .sCntrlFrame.tcsModeDisabled   configure -state disabled
            .sCntrlFrame.tcsModeXYZDk      configure -state disabled
            .sCntrlFrame.tcsModeXYZDkIR    configure -state disabled
            .sCntrlFrame.tcsModeXYZDkIRCl  configure -state disabled
            .sCntrlFrame.sampleInterval    configure -state disabled
        } elseif { $scModel == 2 } {
            .sCntrlFrame.tcsMode0          configure -state disabled
            .sCntrlFrame.tcsMode1          configure -state disabled
            .sCntrlFrame.tcsMode2          configure -state disabled
        }
    }

    if { $led0ControlWidget != "" } {
        $led0ControlWidget configure -state disabled
    }
    if { $led1ControlWidget != "" } {
        $led1ControlWidget configure -state disabled
    }
    if { $led2ControlWidget != "" } {
        $led2ControlWidget configure -state disabled
    }
    if { $led3ControlWidget != "" } {
        $led3ControlWidget configure -state disabled
    }

    .sscFrame.burstMsg configure -text "Busy..."

    #    puts "Sending ATSBURST=$sampleTarget command"
    # Ready to begin.
    set quietMode 1
    set sampleCount 0

    if { [string is integer -strict $sampleTarget]  && ($sampleTarget > 1) && ($sampleTarget <= 65535) } {
        #	puts "Starting burst with sampleTarget=$sampleTarget"
        doATcommand "ATBURST=$sampleTarget"
    } else {
        if { [string is integer -strict $sampleTarget] } {
            if { $sampleTarget == 1 } {
                tk_messageBox -icon info -message "Please note the effect of your \"Stop After\" selection." \
                    -detail "A value of $sampleTarget is equivalent to no target (run until explicitly stopped)." \
                    -title "ams Burst Sample Target Information" -type ok
            } else {
                tk_messageBox -icon info -message "Error in \"Stop After\" value for burst mode operation." \
                    -detail "The upper limit for burst mode operation is 65535." \
                    -title "ams Burst Sample Target Error" -type ok
                set sampleTarget 65535
                $sampleTargetWidget delete 0 end
                $sampleTargetWidget insert end 65535
            }
        }
        #	puts "Starting burst with arg=$sampleTarget"
        # Special case of arg=1 implies run until the user hits the stop button.
        doATcommand "ATBURST=$sampleTarget"
    }
    set vBursting 1

    #    puts "Entering burst loop"
    while { ($curmode == "Auto") && ($autoRunning == true) } {

        set vv 0
        after 20 set vv 1
        vwait vv
        #	puts "sampleCount=$sampleCount"

        # Did the user press the "Stop" button? Have we hit our target?
        if { ($updateButtonState == 5) || ([string is integer -strict $sampleTarget] && \
                ( $sampleTarget > 1 ) && ( $sampleCount >= $sampleTarget )) } {

            #	    puts "Terminating burst.  Sending ATSBURST=0 command"
            set vBursting 2
            doATcommand "ATBURST=0"

            #	    puts "After ATSBURST=0 command vBursting=$vBursting"

            set quietMode 0
            set sampleCount 0

            if { $bUpdateModeAuto } {
                $manualButtonWidget configure -text "  Start    "
                set updateButtonState 3
            } else {
                $manualButtonWidget configure -text " Sample "
                set updateButtonState 0
            }
            set autoRunning false

            .sCntrlFrame.int_time configure -state readonly
            .sCntrlFrame.gain     configure -state readonly

            .logFrame.logSelect configure -state normal
            if { $led0ControlWidget != "" } {
                $led0ControlWidget configure -state normal
            }
            if { $led1ControlWidget != "" } {
                $led1ControlWidget configure -state normal
            }
            if { $led2ControlWidget != "" } {
                $led2ControlWidget configure -state normal
            }
            if { $led3ControlWidget != "" } {
                $led3ControlWidget configure -state normal
            }

            if { $hwModel == 61 } {
                if { $scModel == 1 } {
                    .sCntrlFrame.tcsModeDisabled   configure -state normal
                    .sCntrlFrame.tcsModeXYZDk      configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIR    configure -state normal
                    .sCntrlFrame.tcsModeXYZDkIRCl  configure -state normal
                    .sCntrlFrame.sampleInterval    configure -state readonly
                } elseif { $scModel == 2 } {
                    .sCntrlFrame.tcsMode0          configure -state normal
                    .sCntrlFrame.tcsMode1          configure -state normal
                    .sCntrlFrame.tcsMode2          configure -state normal
                }
            }

            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s6_value configure -state normal
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal

            set sampleTarget ""
            $sampleTargetWidget delete 0 end

            .logFrame.logFileFrame.logName configure -text "<none>              "
            .logFrame.logSelect configure -text " Open Data Log "
            if { $vLogging } {
                set vLogging false
                flush $logFile
                close $logFile
                set logFile ""
            }
            if { $vFiltering } {
                #		puts "sampleInterval is $sampleInterval"
                #		puts "sampleFreq is $sampleFreq"
                array set localFilterArgs {}
                set i 1
                # Do i=1 outside the loop to account for the 16-bit input type
                if { $aFilterTypeNums($i) == 2 } {
                    set localFilterArgs($i) [list -d 1 -f 2 -s $sampleFreq -l $aFilterFreq1($1) \
                        -u $aFilterFreq2($i) -t $aFilterTaps($i) -i 0 -o 1]
                } else {
                    set localFilterArgs($i) [list -d 1 -f $aFilterTypeNums($i) -s $sampleFreq \
                        -x $aFilterFreq1($i) -t $aFilterTaps($i) -i 0 -o 1]
                }
                #		puts "Filter $i args: $localFilterArgs($i)"
                for {set i 2} {$i <= $numFilters} {incr i} {
                    if { $aFilterTypeNums($i) == 2 } {
                        set localFilterArgs($i) [list -d 1 -f 2 -s $sampleFreq -l $aFilterFreq1($1) \
                            -u $aFilterFreq2($i) -t $aFilterTaps($i) -i 1 -o 1]
                    } else {
                        set localFilterArgs($i) [list -d 1 -f $aFilterTypeNums($i) -s $sampleFreq \
                            -x $aFilterFreq1($i) -t $aFilterTaps($i) -i 1 -o 1]
                    }
                    #		    puts "Filter $i args: $localFilterArgs($i)"
                }
                switch -- $numFilters {
                    1 {
                        exec -keepnewline -- $filterApp {*}[split $localFilterArgs(1)] < $logFileName | \
                            > $filteredFileName
                    }
                    2 {
                        exec -keepnewline -- $filterApp {*}[split $localFilterArgs(1)] < $logFileName | \
                            $filterApp {*}[split $localFilterArgs(2)] > $filteredFileName
                    }
                    3 {
                        exec -keepnewline -- $filterApp (*)[split $localFilterArgs(1)] < $logFileName | \
                            $filterApp {*}[split $localFilterArgs(2)] | \
                            $filterApp {*}[split $localFilterArgs(3)] > $filteredFileName
                    }
                    4 {
                        exec -keepnewline -- $filterApp {*}[split $localFilterArgs(1)] < $logFileName | \
                            $filterApp {*}[split $localFilterArgs(2)] | \
                            $filterApp {*}[split $localFilterArgs(3)] | \
                            $filterApp {*}[split $localFilterArgs(4)] > $filteredFileName
                    }
                    5 {
                        exec -keepnewline -- $filterApp {*}[split $localFilterArgs(1)] < $logFileName | \
                            $filterApp {*}[split $localFilterArgs(2)] | \
                            $filterApp {*}[split $localFilterArgs(3)] | \
                            $filterApp {*}[split $localFilterArgs(4)] | \
                            $filterApp {*}[split $localFilterArgs(5)] > $filteredFileName
                    }
                }
                #		puts "Done filtering output."
                set vFiltering false
            }
            set logFileName ""
            set sampleCount 0
            $sampleCountWidget configure -text $sampleCount
            .sscFrame.burstMsg configure -text ""

            return
        }
    }
}

proc doLightState { ltState } {
    global lightState
    global percentLightOutput
    
    set buttonState [.lightCtrlFrame.lightButton cget -state]
    .lightCtrlFrame.lightButton configure -state disabled
    
    set lightState $ltState
    
    if { $lightState == 0 } {
        .lightCtrlFrame.lightButton configure -text " Turn Light On  "
    } else {
        .lightCtrlFrame.lightButton configure -text " Turn Light Off "
        
        if { $percentLightOutput < 5 } {
            set percentLightOutput 5
        }
        doATcommand "ATDIM=$percentLightOutput"
    }
    
    .lightCtrlFrame.lightButton configure -state $buttonState
}

proc doLightButton {} {
    global lightState
    global atCommandTimeout
    global updateButtonState

    # This command can take awhile.  Stretch the timeout value.
    set tmp $atCommandTimeout
    set atCommandTimeout 20000

    if { $lightState == 0 } {
        doATcommand "ATLIGHT=1"
        doLightState 1
    } else {
        doATcommand "ATLIGHT=0"
        doLightState 0
    }

    if { $updateButtonState < 2 } {
        # In manual mode.  Get a sample to show change in state of system.
        doGetSample
    }
        
    # Show most recently written data at bottom.

    set atCommandTimeout $tmp
}

proc doColorTuningState { ctState } {
    global colorTuningState
    global haveRhX
    global haveTempX
    global targetPWMmixVal
    global lastCTsliderChange
    global colorTuneSliderWidget
    global colorControlY1
    
    set buttonState [.lightCtrlFrame.colorTuningButton cget -state]
    .lightCtrlFrame.colorTuningButton configure -state disabled
        
    set colorTuningState $ctState
    
    if { $colorTuningState == 0 } {
        .lightCtrlFrame.colorTuningButton configure -text " Enable Color Tuning "
        # Display the PWM mix slider again
        place forget .lightCtrlFrame.targetCCT
        place .lightCtrlFrame.targetPWMmix  -in .lightCtrlFrame -x 227 -y 8
        place forget .statusFrame.cctTFrame
        if { $haveRhX || $haveTempX } {
            # place .statusFrame.pwmTFrame -in .statusFrame       -x 328 -y $colorControlY1
        } else {
            # place .statusFrame.pwmTFrame -in .statusFrame       -x 410 -y $colorControlY1
        }
        $colorTuneSliderWidget configure -text "$targetPWMmixVal%"
    } else {
        .lightCtrlFrame.colorTuningButton configure -text " Disable Color Tuning "
        # Display the target CCT slider instead of the PWM mix % slider
        place forget .lightCtrlFrame.targetPWMmix
        place .lightCtrlFrame.targetCCT           -in .lightCtrlFrame -x 227 -y 8
        place forget .statusFrame.pwmTFrame
        if { $haveRhX || $haveTempX } {
            place .statusFrame.cctTFrame -in .statusFrame       -x 328 -y $colorControlY1
        } else {
            place .statusFrame.cctTFrame -in .statusFrame       -x 410 -y $colorControlY1
        }
    }
    set lastCTsliderChange [clock seconds]
        
    .lightCtrlFrame.colorTuningButton configure -state $buttonState
}

proc doColorTuningButton {} {
    global colorTuningState
    global targetCCTVal
    global targetPWMmixVal
    global updateButtonState

    if { $colorTuningState == 0 } {
        doATcommand "ATCT=1"
        doATcommand "ATCCTT=$targetCCTVal"
        # Display the target CCT slider instead of the PWM mix % slider
        doColorTuningState 1     
    } else {
        doATcommand "ATCT=0"
        doATcommand "ATLED23M=$targetPWMmixVal"
        # Display the PWM mix slider again
        doColorTuningState 0     
    }

    if { $updateButtonState < 2 } {
        # In manual mode.  Get a sample to show change in state of system.
        doGetSample
    }
        
    # Show most recently written data at bottom.
}

proc doDaylightingState { dlState } {
    global daylightingState
    global hwModel
    global haveRhX
    global haveTempX
    global lastDLsliderChange
    global colorControlY1
    global colorControlY2
    
    set buttonState [.lightCtrlFrame.daylightingButton cget -state]
    .lightCtrlFrame.daylightingButton configure -state disabled
        
    set daylightingState $dlState

    if { $daylightingState == 0 } {
        .lightCtrlFrame.daylightingButton configure -text " Enable Daylighting  "
        # Display the light output % slider again
        place forget .lightCtrlFrame.targetLux
        if { $hwModel == 11 } {
            place .lightCtrlFrame.lightOutputPercent  -in .lightCtrlFrame -x 232 -y 60
        } else {
            place .lightCtrlFrame.lightOutputPercent  -in .lightCtrlFrame -x 227 -y 82
        }
        place forget .statusFrame.luxTFrame
    } else {
        .lightCtrlFrame.daylightingButton configure -text " Disable Daylighting "
        # Display the target lux slider instead of the % output
        place forget .lightCtrlFrame.lightOutputPercent
        if { $hwModel == 11 } {
            place .lightCtrlFrame.targetLux           -in .lightCtrlFrame -x 232 -y 60
        } else {   # AS7221
            place .lightCtrlFrame.targetLux           -in .lightCtrlFrame -x 227 -y 82
        }
        if { $hwModel == 11 } {
            place .statusFrame.luxTFrame -in .statusFrame       -x 260 -y $colorControlY1
        } else {
            if { $haveRhX || $haveTempX } {
                place .statusFrame.luxTFrame -in .statusFrame       -x 328 -y $colorControlY2
            } else {
                place .statusFrame.luxTFrame -in .statusFrame       -x 410 -y $colorControlY2
            }
        }
    }
    set lastDLsliderChange [clock seconds]
        
    .lightCtrlFrame.daylightingButton configure -state $buttonState
}

proc doDaylightingButton {} {
    global daylightingState
    global targetLuxVal
    global percentLightOutput
    global updateButtonState

    if { $daylightingState == 0 } {
        doATcommand "ATDL=1"
        doATcommand "ATLUXT=$targetLuxVal"
        # Display the target lux slider instead of the % output
        doDaylightingState 1        
    } else {
        doATcommand "ATDL=0"
        doATcommand "ATDIM=$percentLightOutput"
        # Display the PWM mix slider again
        doDaylightingState 0        
    }

    if { $updateButtonState < 2 } {
        # In manual mode.  Get a sample to show change in state of system.
        doGetSample
    }
        
    # Show most recently written data at bottom.
}

proc doUpdateTime {} {
    global passwordLastSetTime
    global autoRunning

    # Disable the button while we do some arithmetic.
    .sCntrlFrame.setTimeButton configure -state disabled

    if { $passwordLastSetTime > 0 } {
        # Get the hour without the leading 0
        set hournow   [clock format [clock seconds] -format "%k"]
        set minutenow [clock format [clock seconds] -format "%M"]
        if { $minutenow == "00" } {
            set minutenow 0
        } else {
            set minutenow [string trimleft $minutenow "0"]
        }
        set newTimeVal [expr [expr $hournow * 60] + $minutenow]
        doATcommand "ATTIMENOW=$newTimeVal"
        #	puts "ATTIMENOW=$newTimeVal"
        # Return the day of the week, with Monday = 0, Sunday=6
        set dayOfWeek [expr [clock format [clock seconds] -format "%u"] - 1]
        doATcommand "ATDOW=$dayOfWeek"
        #	puts "ATDOW=$dayOfWeek"
        # Re-enable the button now.
        .sCntrlFrame.setTimeButton configure -state normal
        set printTimeNow [clock format [clock seconds] -format "%l:%M %p %a"]
        .sCntrlFrame.lastTimeSet configure -text "Last Set: $printTimeNow"
        doGetSample
    }
    # Re-enable the button now.
    .sCntrlFrame.setTimeButton configure -state normal

}

proc doSetTimeOfDay {P} {
    global timeOfDaySetValue
    global passwordLastSetTime
    global timeOfDayString
    global ams_viola
    global ams_green
    global ams_gray95
    #    puts "P=$P"

    .sCntrlFrame.setTimeFrame.e configure -fg $ams_gray95

    if { $P == "" } {
        set timeOfDaySetValue ""
        return true
    }
    # Look for one or two numerals leading a ':' and
    # followed by two numerals.  If no trailing am or pm, assume
    # 24-hour style time.
    set hr ""
    set ampm ""
    if { [string match {[0-9]:[0-5][0-9]} $P] } {
        # Something of the form "8:17" has been entered.
        set hr [string range $P 0 0]
        set mn [string range $P 2 3]
    } elseif { [string match {[0-2][0-9]:[0-5][0-9]} $P] } {
        # Something of the form "22:17" has been entered.
        set hr [string range $P 0 1]
        set mn [string range $P 3 4]
    } elseif { [string match {[0-9]:[0-5][0-9][aApP][mM]} $P] } {
        # Something of the form "8:17am" has been entered.
        set hr [string range $P 0 0]
        set mn [string range $P 2 3]
        set ampm [string range $P 4 4]
    } elseif { [string match {[0-9]:[0-5][0-9] [aApP][mM]} $P] } {
        # Something of the form "8:17 am" has been entered.
        set hr [string range $P 0 0]
        set mn [string range $P 2 3]
        set ampm [string range $P 5 5]
    } elseif { [string match {[0-1][0-9]:[0-5][0-9][aApP][mM]} $P] } {
        # Something of the form "10:17am" has been entered.
        set hr [string range $P 0 1]
        set mn [string range $P 3 4]
        set ampm [string range $P 5 5]
    } elseif { [string match {[0-1][0-9]:[0-5][0-9] [aApP][mM]} $P] } {
        # Something of the form "10:17 am" has been entered.
        set hr [string range $P 0 1]
        set mn [string range $P 3 4]
        set ampm [string range $P 6 6]
    }
    if { $hr != "" } {
        # Then we think we have a complete time value ready to set.
        if { ($ampm == "p") || ($ampm == "P") } {
            set timeOfDaySetValue [expr [expr [expr $hr + 12] * 60] + $mn]
        } else {
            set timeOfDaySetValue [expr [expr $hr * 60] + $mn]
        }

        if { $passwordLastSetTime > 0 } {
            #	    puts "Setting time to $timeOfDaySetValue"
            doATcommand "ATTIMENOW=$timeOfDaySetValue"
            #	    set timeOfDayString ""
            .sCntrlFrame.setTimeFrame.e configure -fg $ams_green

            return true
        } else {
            return false
        }
    }
    return true
}

proc doSetDayOfWeek {P} {
    global dayOfWeekSetValue
    global dayOfWeekString
    global passwordLastSetTime
    global ams_viola
    global ams_green
    global ams_gray95
    #    puts "P=$P"

    .sCntrlFrame.setDoWFrame.e configure -fg $ams_gray95

    if { $P == "" } {
        set dayOfWeekSetValue ""
        return true
    }
    set setval ""
    if { [string match {[Mm][Oo][Nn]} $P] } {
        set setval 0
    } elseif { [string match {[Tt][Uu][Ee]} $P] } {
        set setval 1
    } elseif { [string match {[Ww][Ee][Dd]} $P] } {
        set setval 2
    } elseif { [string match {[Tt][Hh][Uu]} $P] } {
        set setval 3
    } elseif { [string match {[Ff][Rr][Ii]} $P] } {
        set setval 4
    } elseif { [string match {[Ss][Aa][Tt]} $P] } {
        set setval 5
    } elseif { [string match {[Ss][Uu][Nn]} $P] } {
        set setval 6
    }
    if { $setval != "" } {
        set dayOfWeekSetValue $setval
        if { $passwordLastSetTime > 0 } {
            #	    puts "Setting Day of Week to $dayOfWeekSetValue"
            doATcommand "ATDOW=$dayOfWeekSetValue"
            #	    set dayOfWeekString ""
            .sCntrlFrame.setDoWFrame.e configure -fg $ams_green

            return true
        } else {
            return false
        }
    }
    return true
}

proc doSetNewPassword {P} {
    global newPasswordValue
    global newPasswordString
    global ams_viola
    global ams_green
    global ams_gray95
    global quietMode
    global passwordLastSetTime
    global passwordValue
    global responseIsError
    global passwordIsValid

    #    puts "P=$P"

    .sCntrlFrame.setNewPasswordFrame.e configure -fg $ams_gray95

    if { $P == "" } {
        set newPasswordValue 0
        return true
    }

    if { [string is integer -strict $P] } {
        # Do we have four digits yet?
        set tmp [string length $P]
        #	puts "Len=$tmp"
        # Make sure the value is between 0 and 9999
        if { ($tmp == 4) } {
            if { ($P >= 0) && ($P < 10000) } {
                set newPasswordValue $P
                #		puts "newvalue is $newPasswordValue"
            } else {
                return false
            }
        } else {
            # Not yet complete, but okay so far.
            return true
        }
    } else {
        # Not an integer
        return false
    }

    if { $newPasswordString != "" } {
        if { $passwordLastSetTime > 0 } {
            #	    puts "Setting password to $newPasswordValue"
            set quietMode 1
            showAndLogCmd "ATSPASSWD=****\n"

            doATcommand "ATSPASSWD=$newPasswordValue"
            set quietMode 0
            if { $responseIsError == 0 } {
                set passwordIsValid 1
                showAndLogCmd "OK\n"

                .sCntrlFrame.setNewPasswordFrame.e configure -fg $ams_green
                set passwordValue $newPasswordValue
                .lightCtrlFrame.pwNotice configure -text ""
                .lightCtrlFrame.daylightingButton configure -state normal
                if { $quietMode == 0 } {
                    .sCntrlFrame.setTimeButton configure -state normal
                }
                return true
            } else {
                set passwordIsValid 0
                # puts "Set pwd valid 0 (doSetNewPassword 1)"
                .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
                .lightCtrlFrame.daylightingButton configure -state disabled
                .pwFrame.pwActiveTimer configure -text "0:00"
                .pwFrame.pwEntry configure -fg $ams_gray95
                if { $quietMode == 0 } {
                    .sCntrlFrame.setTimeButton configure -state disabled
                }
                set passwordLastSetTime 0
                showAndLogCmd "ERROR\n"

                return false
            }
        } else {
            return false
        }
    }
    return true
}

proc doUpdatePasswordTimer {} {
    global isFwDownloadTool
    global passwordLastSetTime
    global bPasswordModeAuto
    global hwModel
    global responseIsError
    global passwordValue
    global passwordIsValid
    global ams_gray95
    global ams_viola
    global ams_green
    global quietMode

    if { ([checkForNewFwVersion { 21 }] == true) } {
        return
    }

    if { $passwordLastSetTime > 0 } {
        set remSecs [expr $passwordLastSetTime - [clock seconds] ]

        if { $remSecs <= 0 } {
            # Are we in auto update mode?
            if { $bPasswordModeAuto } {
                # Freshen the password and reset the counter.
                #		puts "AUTO mode updating password"
                doATpasswordCommand $passwordValue
                if { $responseIsError != 0 } {
                    tk_messageBox -icon error -detail "Bad password." \
                        -message "Password error." -title "ams User Error" -type ok
                    set passwordIsValid 0
                    # puts "Set pwd valid 0 (doUpdatePasswordTimer 1)"
                    set passwordLastSetTime 0
                    # check for FW download tool
                    if { $isFwDownloadTool == 0 } {
                        .pwFrame.pwActiveTimer configure -text "0:00"
                        .pwFrame.pwEntry configure -fg $ams_gray95
                        .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
                        .lightCtrlFrame.daylightingButton configure -state disabled
                        if { $quietMode == 0 } {
                            .sCntrlFrame.setTimeButton configure -state disabled
                        }
                    }
                    return
                } else {
                    set passwordIsValid 1
                    # check for FW download tool
                    if { $isFwDownloadTool == 0 } {
                        .lightCtrlFrame.pwNotice configure -text ""
                        .lightCtrlFrame.daylightingButton configure -state normal
                        if { $quietMode == 0 } {
                            .sCntrlFrame.setTimeButton configure -state normal
                        }
                    }
                }
                set passwordLastSetTime [expr [clock seconds] + 360]
                set remSecs 360
                # check for FW download tool
                if { $isFwDownloadTool == 0 } {
                    # Make sure those items disabled w/o password are enabled now.
                    if { $hwModel == 11 } {
                        .lightCtrlFrame.daylightingButton configure -state normal
                    }
                }
            } else {
                # In manual mode.  Clear timer and return.
                set passwordLastSetTime 0
                set remSecs 0
                puts "MANUAL mode with expired timer"
                # check for FW download tool
                if { $isFwDownloadTool == 0 } {
                    # Make sure those items disabled w/o password are disabled.
                    if { $hwModel == 11 } {
                        .lightCtrlFrame.daylightingButton configure -state disabled
                        .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
                        .sCntrlFrame.int_time configure -state disabled
                        .sCntrlFrame.gain configure -state disabled
                        if { $quietMode == 0 } {
                            .sCntrlFrame.setTimeButton configure -state disabled
                        }
                    }
                }
            }
        } elseif { $remSecs < 60 } {
            # Last minute.  Update now to avoid timer drift sensitivity.
            doATpasswordCommand $passwordValue
            if { $responseIsError != 0 } {
                tk_messageBox -icon error -detail "Bad password." \
                    -message "Password error." -title "ams User Error" -type ok
                set passwordIsValid 0
                # puts "Set pwd valid 0 (doUpdatePasswordTimer 2)"
                set passwordLastSetTime 0
                # check for FW download tool
                if { $isFwDownloadTool == 0 } {
                    .pwFrame.pwActiveTimer configure -text "0:00"
                    .pwFrame.pwEntry configure -fg $ams_gray95
                    .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
                    .lightCtrlFrame.daylightingButton configure -state disabled
                    if { $quietMode == 0 } {
                        .sCntrlFrame.setTimeButton configure -state disabled
                    }
                }
                return
            } else {
                set passwordIsValid 1
                # check for FW download tool
                if { $isFwDownloadTool == 0 } {
                    .lightCtrlFrame.pwNotice configure -text ""
                    .lightCtrlFrame.daylightingButton configure -state normal
                    if { $quietMode == 0 } {
                        .sCntrlFrame.setTimeButton configure -state normal
                    }
                }
            }
            set passwordLastSetTime [expr [clock seconds] + 360]
            set remSecs 360
            # check for FW download tool
            if { $isFwDownloadTool == 0 } {
                # Make sure those items disabled w/o password are enabled now.
                if { $hwModel == 11 } {
                    .lightCtrlFrame.daylightingButton configure -state normal
                    .lightCtrlFrame.pwNotice configure -text ""
                    .sCntrlFrame.int_time configure -state readonly
                    .sCntrlFrame.gain configure -state readonly
                    if { $quietMode == 0 } {
                        .sCntrlFrame.setTimeButton configure -state normal
                    }
                }
            }
        }
        set mins [expr $remSecs / 60]
        set secs [format "%02u" [expr $remSecs % 60]]
        # check for FW download tool
        if { $isFwDownloadTool == 0 } {
            .pwFrame.pwActiveTimer configure -text "$mins:$secs"
            .pwFrame.pwEntry configure -fg $ams_green
        }
    }
    return
}

proc doSetPasswordEntry {P} {
    # puts "doSetPasswordEntry $P"
    return true
}

proc doSetPassword {P} {
    global passwordValue
    global passwordLastSetTime
    global bPasswordModeAuto
    global passwordIsValid
    global ams_viola
    global ams_green
    global ams_gray95
    global quietMode
    global hwModel

    #    set passwordValue $P
    #    puts "Z: passwordValue is $passwordValue P is $P"

    # puts "doSetPassword $P"
    if { $P == "" } {
        return true
    }
    #    puts "quietMode=$quietMode"
    if { [string is integer -strict $P] && ([string length $P] == 4) } {
        if { $bPasswordModeAuto } {
            #	    puts "Sending password $passwordValue P is $P"
            doSendPassword $P
            if { $passwordIsValid } {
                .pwFrame.pwEntry configure -fg $ams_green
                if {[winfo exists .lightCtrlFrame.pwNotice]} {
                    .lightCtrlFrame.pwNotice configure -text ""
                }
                if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                    .lightCtrlFrame.daylightingButton configure -state normal
                }
                if { $quietMode == 0 } {
                    .sCntrlFrame.setTimeButton configure -state normal
                }
                return true
            } else {
                .pwFrame.pwEntry configure -fg $ams_gray95
                set passwordLastSetTime 0
                .pwFrame.pwActiveTimer configure -text "0:00"
                if { ($hwModel == 11) && ($quietMode == 0) } {
                    if {[winfo exists .lightCtrlFrame.pwNotice]} {
                        .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
                    }
                    if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                        .lightCtrlFrame.daylightingButton configure -state disabled
                    }
                    if { $quietMode == 0 } {
                        .sCntrlFrame.setTimeButton configure -state disabled
                    }
                }
                return false
            }
        } else {
            # In manual mode
            set passwordIsValid 0
            # puts "Set pwd valid 0 (doSetPassword 1)"
            .pwFrame.pwEntry configure -fg $ams_gray95
            set passwordLastSetTime 0
            .pwFrame.pwActiveTimer configure -text "0:00"
            if {[winfo exists .lightCtrlFrame.pwNotice]} {
                .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
            }
            if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                .lightCtrlFrame.daylightingButton configure -state disabled
            }
            if { $quietMode == 0 } {
                .sCntrlFrame.setTimeButton configure -state disabled
            }
            return true
        }
    } else {
        # Not yet complete, but okay so far.
        set passwordIsValid 0
        # puts "Set pwd valid 0 (doSetPassword 2)"
        .pwFrame.pwEntry configure -fg $ams_gray95
        set passwordLastSetTime 0
        .pwFrame.pwActiveTimer configure -text "0:00"
        if {[winfo exists .lightCtrlFrame.pwNotice]} {
            .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
        }
        if {[winfo exists .lightCtrlFrame.daylightingButton]} {
            .lightCtrlFrame.daylightingButton configure -state disabled
        }
        if { $quietMode == 0 } {
            .sCntrlFrame.setTimeButton configure -state disabled
        }
        return true
    }
}

proc doSendPassword {p} {
    global passwordLastSetTime
    global hwModel
    global quietMode
    global responseIsError
    global passwordIsValid
    global ams_viola
    global ams_green
    global ams_gray95

    if { ([string length $p] == 4) && [string is integer -strict $p] } {
        doATpasswordCommand $p
        if { $responseIsError != 0 } {
            tk_messageBox -icon error -detail "Bad password." \
                -message "Password error." -title "ams User Error" -type ok
            set passwordIsValid 0
            # puts "Set pwd valid 0 (doSendPassword 1)"
            set passwordLastSetTime 0
            .pwFrame.pwActiveTimer configure -text "0:00"
            .pwFrame.pwEntry configure -fg $ams_gray95
            if {[winfo exists .lightCtrlFrame.pwNotice]} {
                .lightCtrlFrame.pwNotice configure -text "Enter password (Logging) to enable"
            }
            if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                .lightCtrlFrame.daylightingButton configure -state disabled
            }
            if {[winfo exists .lightCtrlFrame.colorTuningButton]} {
                .lightCtrlFrame.colorTuningButton configure -state disabled
            }
            if { $quietMode == 0 } {
                .sCntrlFrame.setTimeButton configure -state disabled
            }

            return
        } else {
            set passwordIsValid 1
            # puts "Set pwd valid 1 (doSendPassword 1)"
            .pwFrame.pwEntry configure -fg $ams_green
            if {[winfo exists .lightCtrlFrame.pwNotice]} {
                .lightCtrlFrame.pwNotice configure -text ""
            }
            if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                .lightCtrlFrame.daylightingButton configure -state normal
            }
            if {[winfo exists .lightCtrlFrame.colorTuningButton]} {
                .lightCtrlFrame.colorTuningButton configure -state normal
            }
            .sCntrlFrame.setTimeButton configure -state normal
        }
        # Set count-down timer to 6 minutes from now.
        set passwordLastSetTime [expr [clock seconds] + 360]
        doUpdatePasswordTimer
        # Make sure those items disabled w/o password are enabled now.
        if { ($quietMode == 0) && ($hwModel == 11) } {
            if {[winfo exists .lightCtrlFrame.daylightingButton]} {
                .lightCtrlFrame.daylightingButton configure -state normal
            }
            if {[winfo exists .lightCtrlFrame.colorTuningButton]} {
                .lightCtrlFrame.colorTuningButton configure -state normal
            }
            if {[winfo exists .lightCtrlFrame.pwNotice]} {
                .lightCtrlFrame.pwNotice configure -text ""
            }
            .sCntrlFrame.int_time configure -state readonly
            .sCntrlFrame.gain configure -state readonly
            if { $quietMode == 0 } {
                .sCntrlFrame.setTimeButton configure -state normal
            }
        }
    }
}

proc doSetStopAfter {P} {
    global sampleTarget
    global sampleCount
    #    puts "P=$P"

    if { $P == "" } {
        set sampleTarget ""
        return true
    }
    if { [string is integer -strict $P] } {
        # Make sure the value is non-negative
        if { $P >= 0 } {
            set sampleTarget [expr $P + $sampleCount]
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

proc doSetAuthMinMax { W P V } {
    #    puts "P=$P"
    #    puts "W=$W"
    #    puts "V=$V"

    if { $V != "key" } {
        return true
    }

    if { $P == "" } {
        return true
    }
    if { [string is integer -strict $P] } {
        # Make sure the value is non-negative
        if { $P >= 0 } {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

proc doPasswordModeSelect {} {
    global bPasswordModeAuto
    global passwordValue

    if { $bPasswordModeAuto } {
        if { ([string length $passwordValue] == 4) && [string is integer -strict $passwordValue] } {
            doSendPassword $passwordValue
        }
        place forget .pwFrame.pwSendButton
    } else {
        place .pwFrame.pwSendButton  -in .pwFrame -x 136 -y 8
    }
}

proc doUpdateModeSelect {} {
    global bUpdateModeAuto
    global hwModel
    global curmode
    global updateButtonState
    global autoRunning
    global manualButtonWidget
    global vLogging
    global led0ControlWidget
    global led1ControlWidget
    global led2ControlWidget
    global led3ControlWidget
    global enableBurstMode
    global usingI2Cadapter
    global scModel

    #    puts "bUpdateModeAuto=$bUpdateModeAuto"
    if { $bUpdateModeAuto } {
        # Entering auto mode.
        set curmode "Auto"
        if { $vLogging && ($hwModel == 61) && $enableBurstMode } {
            set updateButtonState 5
            $manualButtonWidget configure       -text "   Burst    "
        } else {
            set updateButtonState 3
            $manualButtonWidget configure       -text "   Start    "
        }
        set autoRunning false
    } else {
        # Leaving auto mode.
        # .sCntrlFrame.int_time configure -state readonly
        # .sCntrlFrame.gain     configure -state readonly
        .logFrame.logSelect configure -state normal
        if { $led0ControlWidget != "" } {
            $led0ControlWidget configure -state normal
        }
        if { $led1ControlWidget != "" } {
            $led1ControlWidget configure -state normal
        }
        if { $led2ControlWidget != "" } {
            $led2ControlWidget configure -state normal
        }
        if { $led3ControlWidget != "" } {
            $led3ControlWidget configure -state normal
        }
        if { $hwModel == 61 } {
            if { $scModel == 1 } {
                .sCntrlFrame.tcsModeDisabled   configure -state normal
                .sCntrlFrame.tcsModeXYZDk      configure -state normal
                .sCntrlFrame.tcsModeXYZDkIR    configure -state normal
                .sCntrlFrame.tcsModeXYZDkIRCl  configure -state normal
                .sCntrlFrame.sampleInterval    configure -state readonly
            } elseif { $scModel == 2 } {
                .sCntrlFrame.tcsMode0          configure -state normal
                .sCntrlFrame.tcsMode1          configure -state normal
                .sCntrlFrame.tcsMode2          configure -state normal
            }

            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s6_value configure -state normal
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal
        }
        set curmode "Manual"
        set updateButtonState 0
        set autoRunning false
        $manualButtonWidget configure       -text " Sample "
    }
    #    puts "curmode=$curmode updateButtonState=$updateButtonState"
}

proc doLED0OLD {} {
    global led0State
    if { $led0State == 0 } {
        set led0State 1
        doATcommand "ATLED0=100"
        .sscFrame.ledFrame.led0Button configure -text " Turn LED0 Off "
    } else {
        set led0State 0
        doATcommand "ATLED0=0"
        .sscFrame.ledFrame.led0Button configure -text " Turn LED0 On  "
    }
    # Show most recently written data at bottom.

}

proc doLED1OLD {} {
    global led1State
    if { $led1State == 0 } {
        set led1State 1
        doATcommand "ATLED1=100"
        .sscFrame.ledFrame.led1Button configure -text " Turn LED1 Off "
    } else {
        set led1State 0
        doATcommand "ATLED1=0"
        .sscFrame.ledFrame.led1Button configure -text " Turn LED1 On  "
    }
    # Show most recently written data at bottom.

}

# ledCurrent bits 0:1 define the LED_IND current thusly:
#            00b -> 1 mA
#            01b -> 2 mA
#            10b -> 4 mA
#            11b -> 8 mA

proc doLED0 { s } {
    global ledCurrent

    if { $s == "OFF" } {
        doATcommand "ATLED0=0"
    } else {
        if { $s == "1mA" } {
            set ledCurrent [expr $ledCurrent & 0xF0]
        } elseif { $s == "2mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0xF0] | 0x01]
        } elseif { $s == "4mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0xF0] | 0x02]
        } elseif { $s == "8mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0xF0] | 0x03]
        }
        doATcommand "ATLEDC=$ledCurrent"
        doATcommand "ATLED0=100"
    }
    # Show most recently written data at bottom.

}

# ledCurrent bits 5:4 define the LED_DRV current thusly:
#            00b -> 12.5 mA
#            01b -> 25 mA
#            10b -> 50 mA
#            11b -> 100 mA

proc doLED1 { s } {
    global ledCurrent

    #    puts "doLED1 (1) s=$s"
    if { $s == "OFF" } {
        doATcommand "ATLED1=0"
    } else {
        if { $s == "12.5mA" } {
            set ledCurrent [expr $ledCurrent & 0x0F]
        } elseif { $s == "25mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0x0F] | 0x10]
        } elseif { $s == "50mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0x0F] | 0x20]
        } elseif { $s == "100mA" } {
            set ledCurrent [expr [expr $ledCurrent & 0x0F] | 0x30]
        }
        doATcommand "ATLEDC=$ledCurrent"
        doATcommand "ATLED1=100"
    }
    # Show most recently written data at bottom.

    #    puts "doLED1 (2) s=$s"
}

# ledCurrent bits 5:4 define the LED_DRV current thusly:
#            00b -> 12.5 mA
#            01b -> 25 mA
#            10b -> 50 mA
#            11b -> 100 mA

proc doLED2 { s } {
    global ledDCurrent

    #    puts "doLED2 (1) s=$s"
    if { $s == "OFF" } {
        doATcommand "ATLED2=0"
    } else {
        if { $s == "12.5mA" } {
            set ledDCurrent [expr $ledDCurrent & 0x0F]
        } elseif { $s == "25mA" } {
            set ledDCurrent [expr [expr $ledDCurrent & 0x0F] | 0x10]
        } elseif { $s == "50mA" } {
            set ledDCurrent [expr [expr $ledDCurrent & 0x0F] | 0x20]
        } elseif { $s == "100mA" } {
            set ledDCurrent [expr [expr $ledDCurrent & 0x0F] | 0x30]
        }
        doATcommand "ATLEDD=$ledDCurrent"
        doATcommand "ATLED2=100"
    }
    # Show most recently written data at bottom.

    #    puts "doLED2 (2) s=$s"
}

# ledCurrent bits 5:4 define the LED_DRV current thusly:
#            00b -> 12.5 mA
#            01b -> 25 mA
#            10b -> 50 mA
#            11b -> 100 mA

proc doLED3 { s } {
    global ledECurrent

    #    puts "doLED3 (1) s=$s"
    if { $s == "OFF" } {
        doATcommand "ATLED3=0"
    } else {
        if { $s == "12.5mA" } {
            set ledECurrent [expr $ledECurrent & 0x0F]
        } elseif { $s == "25mA" } {
            set ledECurrent [expr [expr $ledECurrent & 0x0F] | 0x10]
        } elseif { $s == "50mA" } {
            set ledECurrent [expr [expr $ledECurrent & 0x0F] | 0x20]
        } elseif { $s == "100mA" } {
            set ledECurrent [expr [expr $ledECurrent & 0x0F] | 0x30]
        }
        doATcommand "ATLEDE=$ledECurrent"
        doATcommand "ATLED3=100"
    }
    # Show most recently written data at bottom.

    #    puts "doLED3 (2) s=$s"
}

proc doOpenAuthLogFile {} {
    global logfiletypes
    global authFileName
    global authFile
    global vAuthLogging
    global authTrial

    if { $vAuthLogging == false } {
        set authFileName [tk_getSaveFile -title "Select Authentication Log File" \
            -filetypes $logfiletypes -parent .]
        if { $authFileName != ""} {
            if { ! [string match "*.csv" $authFileName] } {
                set authFileName "$authFileName.csv"
            }
            .skmcFrame.authLogFrame.authLogName configure -text $authFileName
            .skmcFrame.authLog configure -text " Close Authentication Log "

            set authFile [open $authFileName w]
            set vAuthLogging true
            set authTrial 0
            puts $authFile "Trial, Use Cal?, WUVTSR Mask, Fails, Failing Regs, Description"
        }
    } else {
        .skmcFrame.authLogFrame.authLogName configure -text "<none>              "
        .skmcFrame.authLog configure -text " Open Authentication Log  "
        set vAuthLogging false
        #	puts "Closing $authFileName"
        flush $authFile
        close $authFile
        set authFile ""
        set authFileName ""
    }
}

proc doOpenDataLogFile {} {
    global logfiletypes
    global logFileName
    global logFile
    global logFileCsvDelimiter
    global sampleCountWidget
    global sampleCount
    global vLogging
    global sampleWidgetNames
    global hwModel
    global bUpdateModeAuto
    global manualButtonWidget
    global curmode
    global tcsMode
    global vFiltering
    global numFilters
    global aFilterFreq1
    global aFilterFreq2
    global aFilterTaps
    global aFilterTypes
    global aFilterTypeNums
    global aFilterTextWidgets
    global filteredFileName
    global filteredFile
    global filterApp
    global sampleInterval
    global enableBurstMode
    global bIncludeDerivedVals
    global rawDataSortMode    
    global rawDataParams

    if { $vLogging == false } {
        set logFileName [tk_getSaveFile -title "Select Data Log File" -filetypes $logfiletypes -parent .]
        if { $logFileName != ""} {
            if { ! [string match "*.csv" $logFileName] } {
                set logFileName "$logFileName.csv"
            }
            .logFrame.logFileFrame.logName configure -text $logFileName
            .logFrame.logSelect configure -text " Close Data Log "
            # Reset the sample count
            set sampleCount 0
            $sampleCountWidget configure -text $sampleCount
            set logFile [open $logFileName w]
            set vLogging true
            # make the first line in the file the column headers
            if { ($hwModel == 61) } {
                if { $enableBurstMode  || ($bIncludeDerivedVals == 0) } {
                    # Here, we're using BURST mode output for log files.
                    if { $tcsMode == 0 } {
                        puts $logFile "Sample$logFileCsvDelimiter Xraw$logFileCsvDelimiter Yraw$logFileCsvDelimiter Zraw$logFileCsvDelimiter Dk"
                    } elseif { $tcsMode == 1 } {
                        puts $logFile "Sample$logFileCsvDelimiter Xraw$logFileCsvDelimiter Yraw$logFileCsvDelimiter Zraw$logFileCsvDelimiter Dk$logFileCsvDelimiter nIR"
                    } elseif { $tcsMode == 2 } {
                        puts $logFile "Sample$logFileCsvDelimiter Xraw$logFileCsvDelimiter Yraw$logFileCsvDelimiter Zraw$logFileCsvDelimiter Dk$logFileCsvDelimiter nIR$logFileCsvDelimiter Cl"
                    } elseif { $tcsMode == 3 } {
                        puts $logFile "Sample$logFileCsvDelimiter nIR"
                    }
                } else {
                    # Not bursting
                    set sampleLables [string map ", $logFileCsvDelimiter" $sampleWidgetNames]
                    puts $logFile "$sampleLables"
                }
            } elseif { ($hwModel == 65) } {
                # first header line
                puts -nonewline $logFile [lindex $sampleWidgetNames 0]
                foreach rawDataValue $rawDataParams {
                    puts -nonewline $logFile "$logFileCsvDelimiter [lindex $rawDataValue 0]"
                }
                if { ([checkForNewFwVersion { 65 } 1] == true) } {
                    foreach rawDataValue $rawDataParams {
                        puts -nonewline $logFile "$logFileCsvDelimiter Cal. [lindex $rawDataValue 0]"
                    }
                }
                set lableList [lrange $sampleWidgetNames 19 end]
                set sampleLables [string map ", $logFileCsvDelimiter" $lableList]
                puts $logFile "$logFileCsvDelimiter $sampleLables"
                # second header line
                if { $rawDataSortMode == 1 } {
                    puts -nonewline $logFile "nm"
                    set waveLengthLine ""
                    foreach rawDataValue $rawDataParams {
                        set labelValue [lindex $rawDataValue 0]
                        set waveLengthStart [expr [string first "(" $labelValue] + 1]
                        set waveLengthEnd [expr [string first "nm)" $labelValue] - 1]                    
                        set waveLength [string range $labelValue $waveLengthStart $waveLengthEnd]
                        append waveLengthLine "$logFileCsvDelimiter $waveLength"
                    }
                    puts -nonewline $logFile "$waveLengthLine"
                    if { ([checkForNewFwVersion { 65 } 1] == true) } {
                        puts -nonewline $logFile "$waveLengthLine"
                    }
                    puts $logFile ""
                }
            } else {
                set sampleLables [string map ", $logFileCsvDelimiter" $sampleWidgetNames]
                puts $logFile "$sampleLables"
            }
            if { ($hwModel == 11) || ($hwModel == 21) } {
                .statusFrame.loggingStatusLabel configure -text "Logging Enabled"
            }
            if { ($hwModel == 0) || ($hwModel == 61) } {
                # Go into continuous mode in anticipation of bursting to the file
                set bUpdateModeAuto 1
                set curmode "Auto"
                #		puts "Opened $logFileName mode=$curmode"
                if { $enableBurstMode } {
                    $manualButtonWidget configure -text "  Burst    "
                    # Disable the display items since while bursting
                    .derFrame.cct_value configure -state disabled
                    .derFrame.duv_value configure -state disabled
                    .derFrame.up_value configure -state disabled
                    .derFrame.vp_value configure -state disabled
                    .derFrame.u_value configure -state disabled
                    .derFrame.v_value configure -state disabled
                    .derFrame.x_value configure -state disabled
                    .derFrame.y_value configure -state disabled
                    .svFrame.s1_value configure -state disabled
                    .svFrame.s2_value configure -state disabled
                    .svFrame.s3_value configure -state disabled
                    .svFrame.s4_value configure -state disabled
                    .svFrame.s5_value configure -state disabled
                    .svFrame.s6_value configure -state disabled
                    .csvFrame.cs1_value configure -state disabled
                    .csvFrame.cs2_value configure -state disabled
                    .csvFrame.cs3_value configure -state disabled
                    # Set up for real-time filtering as appropriate.
                    if { $numFilters > 0 } {
                        set filteredFileName [string map { ".csv" "filt.csv" } $logFileName]
                        #		    puts "Filtered log file is $filteredFileName"
                        set filteredFile [open $filteredFileName w]
                        set vFiltering true
                    }
                } else {
                    $manualButtonWidget configure -text "  Start    "
                }
            }
        } else {
            .logFrame.logFileFrame.logName configure -text "<none>              "
            .logFrame.logSelect configure -text " Open Data Log "
            if { ($hwModel == 11) || ($hwModel == 21) } {
                .statusFrame.loggingStatusLabel configure -text ""
            }
            if { ($hwModel == 0) || ($hwModel == 61) } {
                if { $bUpdateModeAuto } {
                    $manualButtonWidget configure -text "  Start    "
                } else {
                    $manualButtonWidget configure -text "  Sample   "
                }
                .derFrame.cct_value configure -state normal
                .derFrame.duv_value configure -state normal
                .derFrame.up_value configure -state normal
                .derFrame.vp_value configure -state normal
                .derFrame.u_value configure -state normal
                .derFrame.v_value configure -state normal
                .derFrame.x_value configure -state normal
                .derFrame.y_value configure -state normal
                .svFrame.s1_value configure -state normal
                .svFrame.s2_value configure -state normal
                .svFrame.s3_value configure -state normal
                .svFrame.s4_value configure -state normal
                .svFrame.s5_value configure -state normal
                .svFrame.s6_value configure -state normal
                .csvFrame.cs1_value configure -state normal
                .csvFrame.cs2_value configure -state normal
                .csvFrame.cs3_value configure -state normal
            }
        }
    } else {
        .logFrame.logFileFrame.logName configure -text "<none>              "
        .logFrame.logSelect configure -text " Open Data Log "
        set vLogging false
        #	puts "Closing $logFileName"
        flush $logFile
        close $logFile
        set logFile ""
        set sampleCount 0
        $sampleCountWidget configure -text $sampleCount
        if { ($hwModel == 11) || ($hwModel == 21) } {
            .statusFrame.loggingStatusLabel configure -text ""
        }
        if { ($hwModel == 0) || ($hwModel == 61) } {
            if { $bUpdateModeAuto } {
                $manualButtonWidget configure -text "  Start    "
            } else {
                $manualButtonWidget configure -text "  Sample   "
            }
            .derFrame.cct_value configure -state normal
            .derFrame.duv_value configure -state normal
            .derFrame.up_value configure -state normal
            .derFrame.vp_value configure -state normal
            .derFrame.u_value configure -state normal
            .derFrame.v_value configure -state normal
            .derFrame.x_value configure -state normal
            .derFrame.y_value configure -state normal
            .svFrame.s1_value configure -state normal
            .svFrame.s2_value configure -state normal
            .svFrame.s3_value configure -state normal
            .svFrame.s4_value configure -state normal
            .svFrame.s5_value configure -state normal
            .svFrame.s6_value configure -state normal
            .csvFrame.cs1_value configure -state normal
            .csvFrame.cs2_value configure -state normal
            .csvFrame.cs3_value configure -state normal
        }
        set logFileName ""
    }
}

proc updateText {widge newtxt} {
    $widge configure -text $newtxt
}

proc updateColorTunePercent {widge newtxt} {
    global colorTuningState
    
    if { $colorTuningState == 1 } {
        $widge configure -text "$newtxt%"
    }
}
    
proc updateRhXPercent {widge newtxt} {
    global rhXval
    global espStabilizeHoldoff
    global espStabilizeFlag
    
    # puts "RhX $newtxt"

    if { $espStabilizeFlag == -1 } {
        set espStabilizeFlag [clock seconds]
        $widge configure -text "-    "
    } elseif { $espStabilizeFlag > 0 } {
        set secsDelta [expr [clock seconds] - $espStabilizeFlag]
        if { $secsDelta > $espStabilizeHoldoff} {
            set espStabilizeFlag 0
        }
        $widge configure -text "-    "
    } else {
        if { [string is double -strict $newtxt] } {
            set rhXval $newtxt
            set newtxt [format "%.1f" $newtxt]
            $widge configure -text "$newtxt%"
        }
    }
}

proc updateTempC {widge newtxt} {
    global tempXval
    global espStabilizeHoldoff
    global espStabilizeFlag
    
    # puts "TempC $newtxt"

    if { $espStabilizeFlag == -1 } {
        set espStabilizeFlag [clock seconds]
        $widge configure -text "-    "
    } elseif { $espStabilizeFlag > 0 } {
        set secsDelta [expr [clock seconds] - $espStabilizeFlag]
        if { $secsDelta > $espStabilizeHoldoff} {
            set espStabilizeFlag 0
        }
        $widge configure -text "-    "
    } else {
        if { [string is double -strict $newtxt] } {
            set tempXval $newtxt
            set newtxt [format "%.1f" $newtxt]
            $widge configure -text "$newtxt C"
        }
    }
}

# Used only for percent light output (dimming)
proc updateTextDimmingPercent {widge newtxt} {
    global daylightingState
    global percentLightOutput
    global lightState

    doLightCheck

    if { ($lightState == 1) && ($daylightingState == 0) && ($newtxt != $percentLightOutput) } {
        #	puts "SLIK dimming at $newtxt slider at $percentLightOutput"
        doATcommand "ATDIM=$percentLightOutput"
        set newtxt $percentLightOutput
    }
    $widge configure -text "$newtxt%"
}

proc updateTimeOfDay {widge newtxt} {
    #    puts "updateTimeOfDay newttxt=$newtxt"
    if { ([string is integer -strict $newtxt]) && ($newtxt != 0xFFFF) } {
        set hr [expr $newtxt / 60 ]
        set mn [format "%02u" [expr $newtxt % 60 ]]
        if { $hr > 12 } {
            set hr [expr $hr - 12]
            set ap "pm"
        } elseif { $hr == 12 } {
            set ap "pm"
        } elseif { $hr == 0 } {
            set hr 12
            set ap "am"
        } else {
            set ap "am"
        }
        $widge configure -text "$hr:$mn$ap"
        .sCntrlFrame.currentSlikTime configure -text "Current: $hr:$mn $ap"
    } else {
        $widge configure -text "not set"
        .sCntrlFrame.currentSlikTime configure -text "Time not set"

    }
}

proc updateDayOfWeek {widge newtxt} {
    if { ([string is integer -strict $newtxt]) && ($newtxt < 7) } {
        $widge configure -text [lindex {Mon Tue Wed Thu Fri Sat Sun} $newtxt]
    } else {
        $widge configure -text "not set"
    }
}

proc doAuthenticate {} {
    global rMin
    global rMax
    global sMin
    global sMax
    global tMin
    global tMax
    global uMin
    global uMax
    global vMin
    global vMax
    global wMin
    global wMax
    global bSKuseCalibrated
    global lastnum
    global responseIsError
    global bSKuseR
    global bSKuseS
    global bSKuseT
    global bSKuseV
    global bSKuseU
    global bSKuseW
    global authTrial
    global authTrialNote
    global authFile
    global vAuthLogging

    # Transfer the min-max values.
    doATcommand "ATRMIN=$rMin"
    doATcommand "ATRMAX=$rMax"
    doATcommand "ATSMIN=$sMin"
    doATcommand "ATSMAX=$sMax"
    doATcommand "ATTMIN=$tMin"
    doATcommand "ATTMAX=$tMax"
    doATcommand "ATUMIN=$uMin"
    doATcommand "ATUMAX=$uMax"
    doATcommand "ATVMIN=$vMin"
    doATcommand "ATVMAX=$vMax"
    doATcommand "ATWMIN=$wMin"
    doATcommand "ATWMAX=$wMax"

    if { $bSKuseCalibrated } {
        set chanMaskReg  0x80
    } else {
        set chanMaskReg  0x00
    }

    if { $bSKuseR } {
        set chanMaskReg [expr $chanMaskReg |  0x01]
    }
    if { $bSKuseS } {
        set chanMaskReg [expr $chanMaskReg |  0x02]
    }
    if { $bSKuseT } {
        set chanMaskReg [expr $chanMaskReg |  0x04]
    }
    if { $bSKuseU } {
        set chanMaskReg [expr $chanMaskReg |  0x08]
    }
    if { $bSKuseV } {
        set chanMaskReg [expr $chanMaskReg |  0x10]
    }
    if { $bSKuseW } {
        set chanMaskReg [expr $chanMaskReg |  0x20]
    }

    doATcommand "ATAUTH=$chanMaskReg"
    if { $responseIsError == 0 } {
        set authResult $lastnum
        incr authTrial
        # Parse the results.
        set chanMaskReg [expr $chanMaskReg & 0x7F]
        set numfails [expr [expr $authResult & 0xC0] >> 6]
        if { $numfails == 3 } {
            set numfails "3+"
        }
        set fails [expr $authResult & 0x3F]
        if { [expr $fails & 0x01] } {
            set failingRegs "R"
        } else {
            set failingRegs " "
        }
        if { [expr $fails & 0x02] } {
            append failingRegs "S"
        } else {
            append failingRegs " "
        }
        if { [expr $fails & 0x04] } {
            append failingRegs "T"
        } else {
            append failingRegs " "
        }
        if { [expr $fails & 0x08] } {
            append failingRegs "U"
        } else {
            append failingRegs " "
        }
        if { [expr $fails & 0x10] } {
            append failingRegs "V"
        } else {
            append failingRegs " "
        }
        if { [expr $fails & 0x20] } {
            append failingRegs "W"
        } else {
            append failingRegs " "
        }
        .skmcFrame.trialFrame.trial configure -text "$authTrial"
        .skmcFrame.failsFrame.fails configure -text "$numfails"
        .skmcFrame.failRegsFrame.regs configure -text "$failingRegs"
        # Write the results if we have a log open.
        if { $vAuthLogging } {
            puts $authFile \
                "$authTrial, $bSKuseCalibrated, $chanMaskReg, \'$numfails, $failingRegs, $authTrialNote"
        }
        # To allow debug output temporarily for Timmy.
        doATcommand "ATTIM"
    }

}

proc DoskProcessingDisplay {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global rMin
    global rMax
    global sMin
    global sMax
    global tMin
    global tMax
    global uMin
    global uMax
    global vMin
    global vMax
    global wMin
    global wMax
    global bSKuseCalibrated
    global lastnum
    global responseIsError
    global bSKuseR
    global bSKuseS
    global bSKuseT
    global bSKuseV
    global bSKuseU
    global bSKuseW
    global authTrial
    global authTrialNote
    global platform

    # Read the current min/max values for each sensor.
    doATcommand "ATRMIN"
    if { $responseIsError == 0 } {
        set rMin $lastnum
    }
    doATcommand "ATRMAX"
    if { $responseIsError == 0 } {
        set rMax $lastnum
    }
    doATcommand "ATSMIN"
    if { $responseIsError == 0 } {
        set sMin $lastnum
    }
    doATcommand "ATSMAX"
    if { $responseIsError == 0 } {
        set sMax $lastnum
    }
    doATcommand "ATTMIN"
    if { $responseIsError == 0 } {
        set tMin $lastnum
    }
    doATcommand "ATTMAX"
    if { $responseIsError == 0 } {
        set tMax $lastnum
    }
    doATcommand "ATUMIN"
    if { $responseIsError == 0 } {
        set uMin $lastnum
    }
    doATcommand "ATUMAX"
    if { $responseIsError == 0 } {
        set uMax $lastnum
    }
    doATcommand "ATVMIN"
    if { $responseIsError == 0 } {
        set vMin $lastnum
    }
    doATcommand "ATVMAX"
    if { $responseIsError == 0 } {
        set vMax $lastnum
    }
    doATcommand "ATWMIN"
    if { $responseIsError == 0 } {
        set wMin $lastnum
    }
    doATcommand "ATWMAX"
    if { $responseIsError == 0 } {
        set wMax $lastnum
    }

    # ------------------------ nIR Sensor Match Limits
    frame .skmlFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 358 -height 390 -background $ams_gray25
    label .skmlFrame.label -text "nIR Sensor Match Limits" -font {system -8 bold} -bg $ams_gray25 \
        -fg $ams_gray95

    label .skmlFrame.labelMin -text "Min" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    label .skmlFrame.labelMax -text "Max" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .skmlFrame.r_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.r_labelN -text "R (610nm) " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.r_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd {doSetAuthMinMax %W %P %V } \
        -textvariable rMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.r_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.r_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable rMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.r_labelN .skmlFrame.r_valueN .skmlFrame.r_labelX .skmlFrame.r_valueX \
        -in .skmlFrame.r_frame -side left

    frame .skmlFrame.s_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.s_labelN -text "S (680nm) " -justify left  -font {TkMenuFont -14}
    entry .skmlFrame.s_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable sMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.s_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.s_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable sMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.s_labelN .skmlFrame.s_valueN .skmlFrame.s_labelX .skmlFrame.s_valueX \
        -in .skmlFrame.s_frame -side left

    frame .skmlFrame.t_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.t_labelN -text "T (730nm) " -justify left  -font {TkMenuFont -14}
    entry .skmlFrame.t_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V] \
        -textvariable tMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.t_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.t_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable tMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.t_labelN .skmlFrame.t_valueN .skmlFrame.t_labelX .skmlFrame.t_valueX \
        -in .skmlFrame.t_frame -side left

    frame .skmlFrame.u_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.u_labelN -text "U (760nm) " -justify left  -font {TkMenuFont -14}
    entry .skmlFrame.u_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable uMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.u_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.u_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable uMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.u_labelN .skmlFrame.u_valueN .skmlFrame.u_labelX .skmlFrame.u_valueX \
        -in .skmlFrame.u_frame -side left

    frame .skmlFrame.v_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.v_labelN -text "V (810nm) " -justify left  -font {TkMenuFont -14}
    entry .skmlFrame.v_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable vMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.v_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.v_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable vMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.v_labelN .skmlFrame.v_valueN .skmlFrame.v_labelX .skmlFrame.v_valueX \
        -in .skmlFrame.v_frame -side left

    frame .skmlFrame.w_frame -bd 2 -relief raised -padx 2 -pady 1
    label .skmlFrame.w_labelN -text "W (860nm) " -justify left  -font {TkMenuFont -14}
    entry .skmlFrame.w_valueN -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable wMin \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    label .skmlFrame.w_labelX -text "   " -justify left -font {TkMenuFont -14}
    entry .skmlFrame.w_valueX -text "    " -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetAuthMinMax %W %P %V ] \
        -textvariable wMax \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering authentication filter limit." \
			     -title "ams Entry Error" -type ok}
    pack .skmlFrame.w_labelN .skmlFrame.w_valueN .skmlFrame.w_labelX .skmlFrame.w_valueX \
        -in .skmlFrame.w_frame -side left

    place .skmlFrame.label           -in .skmlFrame      -x   4 -y   4
    place .skmlFrame.labelMin        -in .skmlFrame      -x 140 -y   30
    place .skmlFrame.labelMax        -in .skmlFrame      -x 218 -y   30
    place .skmlFrame.r_frame         -in .skmlFrame      -x  45 -y   55
    place .skmlFrame.s_frame         -in .skmlFrame      -x  45 -y   110
    place .skmlFrame.t_frame         -in .skmlFrame      -x  45 -y   165
    place .skmlFrame.u_frame         -in .skmlFrame      -x  45 -y   220
    place .skmlFrame.v_frame         -in .skmlFrame      -x  45 -y   275
    place .skmlFrame.w_frame         -in .skmlFrame      -x  45 -y   330

    place .skmlFrame    -in .theNoteBook.skProcessing.skFrame  -x 30 -y 16

    # ------------------------ nIR Sensor Match Control
    frame .skmcFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 358 -height 390 -background $ams_gray25
    label .skmcFrame.label -text "Authentication Control" -font {system -8 bold} -bg $ams_gray25 \
        -fg $ams_gray95
    label .skmcFrame.labelChM -text "Select Channels" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    checkbutton .skmcFrame.useR -text "R" -variable bSKuseR -bg $ams_gray25 -fg $ams_gray95
    checkbutton .skmcFrame.useS -text "S" -variable bSKuseS -bg $ams_gray25 -fg $ams_gray95
    checkbutton .skmcFrame.useT -text "T" -variable bSKuseT -bg $ams_gray25 -fg $ams_gray95
    checkbutton .skmcFrame.useU -text "U" -variable bSKuseU -bg $ams_gray25 -fg $ams_gray95
    checkbutton .skmcFrame.useV -text "V" -variable bSKuseV -bg $ams_gray25 -fg $ams_gray95
    checkbutton .skmcFrame.useW -text "W" -variable bSKuseW -bg $ams_gray25 -fg $ams_gray95

    # Enable them all by default.
    .skmcFrame.useR   select
    .skmcFrame.useS   select
    .skmcFrame.useT   select
    .skmcFrame.useU   select
    .skmcFrame.useV   select
    .skmcFrame.useW   select

    label .skmcFrame.labelSrcSel -text "Select Source" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    radiobutton .skmcFrame.useRaw -text "Raw Sensor Data" -variable bSKuseCalibrated -value 0 \
        -bg $ams_gray25 -fg $ams_gray95
    radiobutton .skmcFrame.useCal -text "Calibrated Data" -variable bSKuseCalibrated -value 1 \
        -bg $ams_gray25 -fg $ams_gray95

    button .skmcFrame.doAuth -text " Authenticate " -command { doAuthenticate } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95

    labelframe .skmcFrame.trialNoteFrame -text "Trial Note" -font {-size 9 -weight bold} \
        -width 342 -height 58 -fg $ams_gray95 -bg $ams_gray25 -relief groove -bd 3
    entry .skmcFrame.trialNoteFrame.trialNote -text "    " -justify left \
        -width 54 -relief sunken -bd 3 -textvariable authTrialNote
    place .skmcFrame.trialNoteFrame.trialNote -in .skmcFrame.trialNoteFrame -x 2 -y 4

    frame .skmcFrame.trialFrame -bd 2 -relief raised -padx 2 -pady 1 -bg $ams_gray25
    label .skmcFrame.trialFrame.label -text "Trial " -justify left -bg $ams_gray25 -fg $ams_gray95
    label .skmcFrame.trialFrame.trial -text "$authTrial" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 3 -anchor e
    pack .skmcFrame.trialFrame.label .skmcFrame.trialFrame.trial -in .skmcFrame.trialFrame -side left

    frame .skmcFrame.failsFrame -bd 2 -relief raised -padx 2 -pady 1 -bg $ams_gray25
    label .skmcFrame.failsFrame.label -text "Fails " -justify left -bg $ams_gray25 -fg $ams_gray95
    label .skmcFrame.failsFrame.fails -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 3 -anchor e
    pack .skmcFrame.failsFrame.label .skmcFrame.failsFrame.fails -in .skmcFrame.failsFrame -side left

    frame .skmcFrame.failRegsFrame -bd 2 -relief raised -padx 2 -pady 1 -bg $ams_gray25
    label .skmcFrame.failRegsFrame.label -text "Failing Regs " -justify left -bg $ams_gray25 -fg $ams_gray95
    label .skmcFrame.failRegsFrame.regs -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 8 -anchor e
    pack .skmcFrame.failRegsFrame.label .skmcFrame.failRegsFrame.regs -in .skmcFrame.failRegsFrame -side left

    button .skmcFrame.authLog -text " Open Authentication Log  " -command { doOpenAuthLogFile } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    labelframe .skmcFrame.authLogFrame -text "Authentication Log" -font {-size 9 -weight bold} \
        -width 342 -height 48 -fg $ams_gray95 -bg $ams_gray25 -relief groove -bd 3
    if { $platform == "win32" } {
        label .skmcFrame.authLogFrame.authLogName -text "<none>              " -justify right -bg $ams_gray25 \
            -fg $ams_gray95 -font "-family helvetica -size 10 -slant italic" -width 41
    } else {
        label .skmcFrame.authLogFrame.authLogName -text "<none>              " -justify right -bg $ams_gray25 \
            -fg $ams_gray95 -font "-family helvetica -size 11 -slant italic" -width 41
    }
    place .skmcFrame.authLogFrame.authLogName -in .skmcFrame.authLogFrame -x 2 -y 4

    place .skmcFrame.label           -in .skmcFrame      -x  4   -y    4
    place .skmcFrame.labelChM        -in .skmcFrame      -x  120 -y   30
    place .skmcFrame.useR            -in .skmcFrame      -x  30  -y   50
    place .skmcFrame.useS            -in .skmcFrame      -x  80  -y   50
    place .skmcFrame.useT            -in .skmcFrame      -x  130 -y   50
    place .skmcFrame.useU            -in .skmcFrame      -x  180 -y   50
    place .skmcFrame.useV            -in .skmcFrame      -x  230 -y   50
    place .skmcFrame.useW            -in .skmcFrame      -x  280 -y   50

    place .skmcFrame.labelSrcSel     -in .skmcFrame      -x  120 -y   85
    place .skmcFrame.useRaw          -in .skmcFrame      -x   50 -y  103
    place .skmcFrame.useCal          -in .skmcFrame      -x  200 -y  103

    place .skmcFrame.doAuth          -in .skmcFrame      -x   80 -y  150
    place .skmcFrame.trialFrame      -in .skmcFrame      -x  200 -y  147
    place .skmcFrame.trialNoteFrame  -in .skmcFrame      -x    4 -y  180

    place .skmcFrame.failsFrame      -in .skmcFrame      -x   45 -y  245
    place .skmcFrame.failRegsFrame   -in .skmcFrame      -x  160 -y  245

    place .skmcFrame.authLog         -in .skmcFrame      -x   95 -y  299
    place .skmcFrame.authLogFrame    -in .skmcFrame      -x    4 -y  330

    place .skmcFrame    -in .theNoteBook.skProcessing.skFrame  -x 418 -y 16

}

proc Do7265SensorDisplay {} {
    global vOverwrite
    global vLogging
    global lWidgets
    global lWidgetHighIndex
    global amslogo
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bUpdateModeAuto
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global S7label
    global S8label
    global S9label
    global S10label
    global S11label
    global S12label
    global S13label
    global S14label
    global S15label
    global S16label
    global S17label
    global S18label
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lUpdateProcs
    global led0ControlWidget
    global led1ControlWidget
    global led2ControlWidget
    global led3ControlWidget
    global updateCmds
    global dataDisplayMode    
    global calibrationMode
    global diagramMinValue
    global diagramMaxValue
    global minMaxLock
    global splineMode
    global channelSortedParams
    global wavelengthSortedParams
    global rawDataParams
    global rawDataLabels
    global rawDataValues    

    # ------------------------ Moonlighting Control Panel
    frame .sscFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 736 -height 160 -background $ams_gray25
    label .sscFrame.label -text "Control & Status " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    frame .sscFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 110 -width 200
    label .sscFrame.sampleModeLabel -text "Update Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .sscFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .sscFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .sscFrame.sampleUpdate
    label .sscFrame.burstMsg -text "" -fg $ams_gray95  -bg $ams_gray25

    frame .sscFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .sscFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .sscFrame.sampleStopAfter.v
    pack .sscFrame.sampleStopAfter.l .sscFrame.sampleStopAfter.v \
        -in .sscFrame.sampleStopAfter -side left

    frame .sscFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 110 -width 130
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .sscFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .sscFrame.luTimeL

    frame .sscFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleCount.l -text "Samples" -justify left
    label .sscFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .sscFrame.sampleCount.v

    frame .sscFrame.ledFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 110 -width 340
    label .sscFrame.ledFrame.l       -text "LED Control (Electronic Shutter)"  \
        -fg $ams_gray95  -bg $ams_gray25

    label .sscFrame.ledFrame.led0label -text "LED0: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA} -wrap true -borderwidth 3 \
        -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
    set led0ControlWidget .sscFrame.ledFrame.led0Spinbox

    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLED0" { .sscFrame.ledFrame.led0Spinbox set [expr { $lastnum == 0 } ? { "OFF" } : { "1mA" }] }
    
    label .sscFrame.ledFrame.led1label -text "LED1: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .sscFrame.ledFrame.led1Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
        -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED1 %s }
    set led1ControlWidget .sscFrame.ledFrame.led1Spinbox
        
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLEDC" { set lastCmdNum [lindex {12.5mA 25mA 50mA 100mA} [expr ([expr $lastnum] >> 4) & 0x03]] }
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLED1" { .sscFrame.ledFrame.led1Spinbox set [expr { $lastnum == 0 } ? { "OFF" } : { $lastCmdNum }] }
        
    label .sscFrame.ledFrame.led2label -text "LED2: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .sscFrame.ledFrame.led2Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
        -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED2 %s }
    set led2ControlWidget .sscFrame.ledFrame.led2Spinbox
        
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLEDD" { set lastCmdNum [lindex {12.5mA 25mA 50mA 100mA} [expr ([expr $lastnum] >> 4) & 0x03]] }
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLED2" { .sscFrame.ledFrame.led2Spinbox set [expr { $lastnum == 0 } ? { "OFF" } : { $lastCmdNum }] }
        
    label .sscFrame.ledFrame.led3label -text "LED3: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .sscFrame.ledFrame.led3Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
        -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED3 %s }
    set led3ControlWidget .sscFrame.ledFrame.led3Spinbox

    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLEDE" { set lastCmdNum [lindex {12.5mA 25mA 50mA 100mA} [expr ([expr $lastnum] >> 4) & 0x03]] }
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "ATLED3" { .sscFrame.ledFrame.led3Spinbox set [expr { $lastnum == 0 } ? { "OFF" } : { $lastCmdNum }] }

    # don't change the order of these commands
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "" { updateTcsMode }
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "" { doGetSample }
        
    place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   2 -y  2
    place .sscFrame.ledFrame.led0label    -in .sscFrame.ledFrame   -x  33 -y 32
    place .sscFrame.ledFrame.led0Spinbox  -in .sscFrame.ledFrame   -x  68 -y 30
    place .sscFrame.ledFrame.led1label    -in .sscFrame.ledFrame   -x 183 -y 32
    place .sscFrame.ledFrame.led1Spinbox  -in .sscFrame.ledFrame   -x 218 -y 30
    place .sscFrame.ledFrame.led2label    -in .sscFrame.ledFrame   -x  33 -y 68
    place .sscFrame.ledFrame.led2Spinbox  -in .sscFrame.ledFrame   -x  68 -y 66
    place .sscFrame.ledFrame.led3label    -in .sscFrame.ledFrame   -x 183 -y 68
    place .sscFrame.ledFrame.led3Spinbox  -in .sscFrame.ledFrame   -x 218 -y 66

    pack  .sscFrame.sampleCount.l .sscFrame.sampleCount.v -in .sscFrame.sampleCount -side left
    place .sscFrame.sampleCount -in .sscFrame.statusFrame  -x   6 -y  66
    place .sscFrame.l           -in .sscFrame.statusFrame  -x   4 -y   4
    place .sscFrame.luLabel     -in .sscFrame.statusFrame  -x  24 -y  22
    place .sscFrame.luTimeL     -in .sscFrame.statusFrame  -x  34 -y  42

    place .sscFrame.sampleModeLabel   -in .sscFrame.sampleMode -x 4   -y 4
    #   place .sscFrame.sampleModeAuto    -in .sscFrame.sampleMode -x 16  -y 24
    #   place .sscFrame.sampleModeManual  -in .sscFrame.sampleMode -x 16  -y 44
    place .sscFrame.continuousMode    -in .sscFrame.sampleMode -x 16  -y 26
    place .sscFrame.sampleUpdate      -in .sscFrame.sampleMode -x 120 -y 26
    place .sscFrame.sampleStopAfter   -in .sscFrame.sampleMode -x 40  -y 66
    #    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 126 -y 52
    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 46 -y 46

    place .sscFrame.label             -in .sscFrame -x   4 -y   2
    place .sscFrame.sampleMode        -in .sscFrame -x  22 -y  26
    place .sscFrame.statusFrame       -in .sscFrame -x 230 -y  26
    place .sscFrame.ledFrame          -in .sscFrame -x 368 -y  26
    place .sscFrame    -in .theNoteBook.moonlightSensor.sFrame  -x 30  -y 10

    # ------------------------ Sensor Values
    frame .nSVFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 736 -height 230 -background $ams_gray25
    
    # create display configuration controls
    frame .nSVFrame.displayConfigureFrame -bg $ams_gray25
        
    label .nSVFrame.displayConfigureFrame.labelShow                  -text "Show" \
        -bg $ams_gray25 -fg $ams_gray95
    radiobutton .nSVFrame.displayConfigureFrame.buttonRawData        -text "Raw"            -variable calibrationMode -value 0 \
        -bg $ams_gray25 -fg $ams_gray95 -command doCalibrationMode
    radiobutton .nSVFrame.displayConfigureFrame.buttonCalibratedData -text "Calibrated"     -variable calibrationMode -value 1 \
        -bg $ams_gray25 -fg $ams_gray95 -command doCalibrationMode
    label .nSVFrame.displayConfigureFrame.labelData                  -text "Data    sorted by" \
        -bg $ams_gray25 -fg $ams_gray95
    radiobutton .nSVFrame.displayConfigureFrame.buttonChannel        -text "Channel"        -variable dataDisplayMode -value 0 \
        -bg $ams_gray25 -fg $ams_gray95 -command doDataDisplayMode
    radiobutton .nSVFrame.displayConfigureFrame.buttonWavelength     -text "Wavelength   or" -variable dataDisplayMode -value 1 \
        -bg $ams_gray25 -fg $ams_gray95 -command doDataDisplayMode
    radiobutton .nSVFrame.displayConfigureFrame.buttonSpectrum       -text "as Spectrum"    -variable dataDisplayMode -value 2 \
        -bg $ams_gray25 -fg $ams_gray95 -command doDataDisplayMode
    
    # place display configuration controls
    grid .nSVFrame.displayConfigureFrame.labelShow              -in .nSVFrame.displayConfigureFrame -row 0 -column 0
    grid .nSVFrame.displayConfigureFrame.buttonRawData          -in .nSVFrame.displayConfigureFrame -row 0 -column 1
    grid .nSVFrame.displayConfigureFrame.buttonCalibratedData   -in .nSVFrame.displayConfigureFrame -row 0 -column 2
    grid .nSVFrame.displayConfigureFrame.labelData              -in .nSVFrame.displayConfigureFrame -row 0 -column 3
    grid .nSVFrame.displayConfigureFrame.buttonChannel          -in .nSVFrame.displayConfigureFrame -row 0 -column 4
    grid .nSVFrame.displayConfigureFrame.buttonWavelength       -in .nSVFrame.displayConfigureFrame -row 0 -column 5
    grid .nSVFrame.displayConfigureFrame.buttonSpectrum         -in .nSVFrame.displayConfigureFrame -row 0 -column 6
    
    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "" { enableSortMode }

    if { ([checkForNewFwVersion { 65 } 1] == false) } {
        set calibrationMode 0
        .nSVFrame.displayConfigureFrame.buttonCalibratedData configure -state disabled
    }

    # create spectrum display controls
    frame .nSVFrame.spectrumFrame -bg $ams_gray25
    
    canvas .nSVFrame.spectrumFrame.diagram -bg white -width 550 -height 150
        
    checkbutton .nSVFrame.spectrumFrame.buttonMinMaxLock -text "Lock" -variable minMaxLock \
        -bg $ams_gray25 -fg $ams_gray95
    checkbutton .nSVFrame.spectrumFrame.buttonSplineMode -text "Spline" -variable splineMode \
        -bg $ams_gray25 -fg $ams_gray95

    set minMaxLabelWidth 9
    set wafelengthLabelWidth 6
    
    label .nSVFrame.spectrumFrame.dist_0 -text "" -bg $ams_gray25 -fg $ams_gray95 -width [expr $minMaxLabelWidth - $wafelengthLabelWidth / 2]
    label .nSVFrame.spectrumFrame.dist_1 -text "" -bg $ams_gray25 -fg $ams_gray95 -width [expr $wafelengthLabelWidth / 2]
    label .nSVFrame.spectrumFrame.dist_2 -text "" -bg $ams_gray25 -fg $ams_gray95 -width [expr $wafelengthLabelWidth / 2]
    label .nSVFrame.spectrumFrame.dist_3 -text "" -bg $ams_gray25 -fg $ams_gray95 -width [expr $minMaxLabelWidth - $wafelengthLabelWidth / 2]
        
    label .nSVFrame.spectrumFrame.labelYmax -text "$diagramMaxValue" -anchor e -bg $ams_gray25 -fg $ams_gray95 -width $minMaxLabelWidth
    label .nSVFrame.spectrumFrame.labelYmin -text "$diagramMinValue" -anchor e -bg $ams_gray25 -fg $ams_gray95 -width $minMaxLabelWidth
    
    label .nSVFrame.spectrumFrame.label_0 -text  "350" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_1 -text  "450" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_2 -text  "550" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_3 -text  "650" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_4 -text  "750" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_5 -text  "850" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_6 -text  "950" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    label .nSVFrame.spectrumFrame.label_7 -text "1050" -anchor center -bg $ams_gray25 -fg $ams_gray95 -width $wafelengthLabelWidth
    
    grid .nSVFrame.spectrumFrame.labelYmax          -in .nSVFrame.spectrumFrame -row 0 -column  0 -columnspan  2 -sticky ne -padx { 0 4 }
    grid .nSVFrame.spectrumFrame.buttonSplineMode   -in .nSVFrame.spectrumFrame -row 0 -column 23 -columnspan  2 -sticky ne -padx { 4 0 }
    grid .nSVFrame.spectrumFrame.dist_0             -in .nSVFrame.spectrumFrame -row 1 -column  0
    grid .nSVFrame.spectrumFrame.dist_1             -in .nSVFrame.spectrumFrame -row 1 -column  1
    grid .nSVFrame.spectrumFrame.diagram            -in .nSVFrame.spectrumFrame -row 0 -column  2 -columnspan 21 -rowspan 5
    grid .nSVFrame.spectrumFrame.dist_2             -in .nSVFrame.spectrumFrame -row 1 -column 23
    grid .nSVFrame.spectrumFrame.dist_3             -in .nSVFrame.spectrumFrame -row 1 -column 24
    grid .nSVFrame.spectrumFrame.buttonMinMaxLock   -in .nSVFrame.spectrumFrame -row 2 -column  0 -columnspan  2 -sticky n
    grid .nSVFrame.spectrumFrame.labelYmin          -in .nSVFrame.spectrumFrame -row 4 -column  0 -columnspan  2 -sticky se -padx { 0 4 }
    grid .nSVFrame.spectrumFrame.label_0            -in .nSVFrame.spectrumFrame -row 6 -column  1 -columnspan  2 -sticky w
    grid .nSVFrame.spectrumFrame.label_1            -in .nSVFrame.spectrumFrame -row 6 -column  4 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_2            -in .nSVFrame.spectrumFrame -row 6 -column  7 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_3            -in .nSVFrame.spectrumFrame -row 6 -column 10 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_4            -in .nSVFrame.spectrumFrame -row 6 -column 13 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_5            -in .nSVFrame.spectrumFrame -row 6 -column 16 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_6            -in .nSVFrame.spectrumFrame -row 6 -column 19 -columnspan  2
    grid .nSVFrame.spectrumFrame.label_7            -in .nSVFrame.spectrumFrame -row 6 -column 22 -columnspan  2 -sticky e
    
    grid rowconfigure .nSVFrame.spectrumFrame 5 -minsize 4

    lappend updateCmds $hwModel .theNoteBook.moonlightSensor "" { setSpectrumDisplayParameters }

    # create raw data display controls
    frame .nSVFrame.rawDataFrame -bg $ams_gray25
        
    set cannelLabelWidth 10
    set cannelValueWidth 6
        
    label .nSVFrame.rawDataFrame.label1 -text "AS72651" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .nSVFrame.rawDataFrame.r_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.r_label -text "R (610nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.r_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.r_label .nSVFrame.rawDataFrame.r_value -in .nSVFrame.rawDataFrame.r_frame -side left

    frame .nSVFrame.rawDataFrame.s_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.s_label -text "S (680nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.s_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.s_label .nSVFrame.rawDataFrame.s_value -in .nSVFrame.rawDataFrame.s_frame -side left

    frame .nSVFrame.rawDataFrame.t_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.t_label -text "T (730nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.t_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.t_label .nSVFrame.rawDataFrame.t_value -in .nSVFrame.rawDataFrame.t_frame -side left

    frame .nSVFrame.rawDataFrame.u_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.u_label -text "U (760nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.u_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.u_label .nSVFrame.rawDataFrame.u_value -in .nSVFrame.rawDataFrame.u_frame -side left

    frame .nSVFrame.rawDataFrame.v_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.v_label -text "V (810nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.v_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.v_label .nSVFrame.rawDataFrame.v_value -in .nSVFrame.rawDataFrame.v_frame -side left

    frame .nSVFrame.rawDataFrame.w_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.w_label -text "W (860nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.w_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.w_label .nSVFrame.rawDataFrame.w_value -in .nSVFrame.rawDataFrame.w_frame -side left

    label .nSVFrame.rawDataFrame.label2 -text "AS72652" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .nSVFrame.rawDataFrame.g_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.g_label -text "G (560nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.g_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.g_label .nSVFrame.rawDataFrame.g_value -in .nSVFrame.rawDataFrame.g_frame -side left

    frame .nSVFrame.rawDataFrame.h_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.h_label -text "H (585nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.h_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.h_label .nSVFrame.rawDataFrame.h_value -in .nSVFrame.rawDataFrame.h_frame -side left

    frame .nSVFrame.rawDataFrame.i_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.i_label -text "I (645nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.i_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.i_label .nSVFrame.rawDataFrame.i_value -in .nSVFrame.rawDataFrame.i_frame -side left

    frame .nSVFrame.rawDataFrame.j_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.j_label -text "J (705nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.j_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.j_label .nSVFrame.rawDataFrame.j_value -in .nSVFrame.rawDataFrame.j_frame -side left

    frame .nSVFrame.rawDataFrame.k_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.k_label -text "K (900nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.k_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.k_label .nSVFrame.rawDataFrame.k_value -in .nSVFrame.rawDataFrame.k_frame -side left

    frame .nSVFrame.rawDataFrame.l_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.l_label -text "L (940nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.l_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.l_label .nSVFrame.rawDataFrame.l_value -in .nSVFrame.rawDataFrame.l_frame -side left

    label .nSVFrame.rawDataFrame.label3 -text "AS72653" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .nSVFrame.rawDataFrame.a_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.a_label -text "A (410nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.a_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.a_label .nSVFrame.rawDataFrame.a_value -in .nSVFrame.rawDataFrame.a_frame -side left

    frame .nSVFrame.rawDataFrame.b_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.b_label -text "B (435nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.b_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.b_label .nSVFrame.rawDataFrame.b_value -in .nSVFrame.rawDataFrame.b_frame -side left

    frame .nSVFrame.rawDataFrame.c_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.c_label -text "C (460nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.c_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.c_label .nSVFrame.rawDataFrame.c_value -in .nSVFrame.rawDataFrame.c_frame -side left

    frame .nSVFrame.rawDataFrame.d_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.d_label -text "D (485nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.d_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.d_label .nSVFrame.rawDataFrame.d_value -in .nSVFrame.rawDataFrame.d_frame -side left

    frame .nSVFrame.rawDataFrame.e_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.e_label -text "E (510nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.e_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.e_label .nSVFrame.rawDataFrame.e_value -in .nSVFrame.rawDataFrame.e_frame -side left

    frame .nSVFrame.rawDataFrame.f_frame -bd 1 -relief raised -padx 1 -pady 1
    label .nSVFrame.rawDataFrame.f_label -text "F (535nm) " -justify left -width $cannelLabelWidth
    label .nSVFrame.rawDataFrame.f_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 2 \
        -width $cannelValueWidth -anchor e
    pack .nSVFrame.rawDataFrame.f_label .nSVFrame.rawDataFrame.f_value -in .nSVFrame.rawDataFrame.f_frame -side left

    label .nSVFrame.rawDataFrame.distanceLabel1 -text " " -bg $ams_gray25 -fg $ams_gray95
    label .nSVFrame.rawDataFrame.distanceLabel2 -text " " -bg $ams_gray25 -fg $ams_gray95
    label .nSVFrame.rawDataFrame.distanceLabel3 -text " " -bg $ams_gray25 -fg $ams_gray95

    # place raw data controls
    grid .nSVFrame.rawDataFrame.distanceLabel1  -in .nSVFrame.rawDataFrame -row 0 -column 0
    grid .nSVFrame.rawDataFrame.label1          -in .nSVFrame.rawDataFrame -row 0 -column 1 -sticky e
    grid .nSVFrame.rawDataFrame.r_frame         -in .nSVFrame.rawDataFrame -row 0 -column 2 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.s_frame         -in .nSVFrame.rawDataFrame -row 1 -column 2 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.t_frame         -in .nSVFrame.rawDataFrame -row 2 -column 2 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.u_frame         -in .nSVFrame.rawDataFrame -row 3 -column 2 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.v_frame         -in .nSVFrame.rawDataFrame -row 4 -column 2 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.w_frame         -in .nSVFrame.rawDataFrame -row 5 -column 2 -padx 2 -pady 2 -sticky e

    grid .nSVFrame.rawDataFrame.distanceLabel2  -in .nSVFrame.rawDataFrame -row 0 -column 3
    grid .nSVFrame.rawDataFrame.label2          -in .nSVFrame.rawDataFrame -row 0 -column 4 -sticky e
    grid .nSVFrame.rawDataFrame.g_frame         -in .nSVFrame.rawDataFrame -row 0 -column 5 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.h_frame         -in .nSVFrame.rawDataFrame -row 1 -column 5 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.i_frame         -in .nSVFrame.rawDataFrame -row 2 -column 5 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.j_frame         -in .nSVFrame.rawDataFrame -row 3 -column 5 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.k_frame         -in .nSVFrame.rawDataFrame -row 4 -column 5 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.l_frame         -in .nSVFrame.rawDataFrame -row 5 -column 5 -padx 2 -pady 2 -sticky e

    grid .nSVFrame.rawDataFrame.distanceLabel3  -in .nSVFrame.rawDataFrame -row 0 -column 6
    grid .nSVFrame.rawDataFrame.label3          -in .nSVFrame.rawDataFrame -row 0 -column 7 -sticky e
    grid .nSVFrame.rawDataFrame.a_frame         -in .nSVFrame.rawDataFrame -row 0 -column 8 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.b_frame         -in .nSVFrame.rawDataFrame -row 1 -column 8 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.c_frame         -in .nSVFrame.rawDataFrame -row 2 -column 8 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.d_frame         -in .nSVFrame.rawDataFrame -row 3 -column 8 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.e_frame         -in .nSVFrame.rawDataFrame -row 4 -column 8 -padx 2 -pady 2 -sticky e
    grid .nSVFrame.rawDataFrame.f_frame         -in .nSVFrame.rawDataFrame -row 5 -column 8 -padx 2 -pady 2 -sticky e

    grid columnconfigure .nSVFrame.rawDataFrame { .nSVFrame.rawDataFrame.label1 .nSVFrame.rawDataFrame.label2 .nSVFrame.rawDataFrame.label3 } -minsize 80
    
    # place configure display, raw data frames in main frame
    place .nSVFrame.displayConfigureFrame   -in .nSVFrame   -x   4 -y    2
    place .nSVFrame.rawDataFrame            -in .nSVFrame   -x   4 -y   35
        
    place .nSVFrame     -in .theNoteBook.moonlightSensor.sFrame  -x 30 -y 176

    # Set the widget list used to get samples
    # check channel order
    if { ([checkForNewFwVersion { 65 }] == false) } {
        set sampleWidgetNames "Sample, R, S, T, U, V, W, J, I, G, H, K, L, D, C, A, B, E, F, Int Time, Gain, Temp AS72651, Temp AS72652, Temp AS72653, Timestamp"
            
        set channelSortedParams [list \
             { "R (610nm)"  0 } \
             { "S (680nm)"  1 } \
             { "T (730nm)"  2 } \
             { "U (760nm)"  3 } \
             { "V (810nm)"  4 } \
             { "W (860nm)"  5 } \
             { "G (560nm)"  8 } \
             { "H (585nm)"  9 } \
             { "I (645nm)"  7 } \
             { "J (705nm)"  6 } \
             { "K (900nm)" 10 } \
             { "L (940nm)" 11 } \
             { "A (410nm)" 14 } \
             { "B (435nm)" 15 } \
             { "C (460nm)" 13 } \
             { "D (485nm)" 12 } \
             { "E (510nm)" 16 } \
             { "F (535nm)" 17 } \
        ]
        
        set wavelengthSortedParams [list \
             { "A (410nm)" 14 410 } \
             { "B (435nm)" 15 435 } \
             { "C (460nm)" 13 460 } \
             { "D (485nm)" 12 485 } \
             { "E (510nm)" 16 510 } \
             { "F (535nm)" 17 535 } \
             { "G (560nm)"  8 560 } \
             { "H (585nm)"  9 585 } \
             { "R (610nm)"  0 610 } \
             { "I (645nm)"  7 645 } \
             { "S (680nm)"  1 680 } \
             { "J (705nm)"  6 705 } \
             { "T (730nm)"  2 730 } \
             { "U (760nm)"  3 760 } \
             { "V (810nm)"  4 810 } \
             { "W (860nm)"  5 860 } \
             { "K (900nm)" 10 900 } \
             { "L (940nm)" 11 940 } \
        ]
    } else {
        set sampleWidgetNames "Sample, R, S, T, U, V, W, G, H, I, J, K, L, A, B, C, D, E, F, Int Time, Gain, Temp AS72651, Temp AS72652, Temp AS72653, Timestamp"    
            
        set channelSortedParams [list \
             { "R (610nm)"  0 } \
             { "S (680nm)"  1 } \
             { "T (730nm)"  2 } \
             { "U (760nm)"  3 } \
             { "V (810nm)"  4 } \
             { "W (860nm)"  5 } \
             { "G (560nm)"  6 } \
             { "H (585nm)"  7 } \
             { "I (645nm)"  8 } \
             { "J (705nm)"  9 } \
             { "K (900nm)" 10 } \
             { "L (940nm)" 11 } \
             { "A (410nm)" 12 } \
             { "B (435nm)" 13 } \
             { "C (460nm)" 14 } \
             { "D (485nm)" 15 } \
             { "E (510nm)" 16 } \
             { "F (535nm)" 17 } \
        ]
        
        set wavelengthSortedParams [list \
             { "A (410nm)" 12 410 } \
             { "B (435nm)" 13 435 } \
             { "C (460nm)" 14 460 } \
             { "D (485nm)" 15 485 } \
             { "E (510nm)" 16 510 } \
             { "F (535nm)" 17 535 } \
             { "G (560nm)"  6 560 } \
             { "H (585nm)"  7 585 } \
             { "R (610nm)"  0 610 } \
             { "I (645nm)"  8 645 } \
             { "S (680nm)"  1 680 } \
             { "J (705nm)"  9 705 } \
             { "T (730nm)"  2 730 } \
             { "U (760nm)"  3 760 } \
             { "V (810nm)"  4 810 } \
             { "W (860nm)"  5 860 } \
             { "K (900nm)" 10 900 } \
             { "L (940nm)" 11 940 } \
        ]
    }

    set rawDataParams $channelSortedParams
    
    set rawDataLabels [list \
        .nSVFrame.rawDataFrame.r_label \
        .nSVFrame.rawDataFrame.s_label \
        .nSVFrame.rawDataFrame.t_label \
        .nSVFrame.rawDataFrame.u_label \
        .nSVFrame.rawDataFrame.v_label \
        .nSVFrame.rawDataFrame.w_label \
        .nSVFrame.rawDataFrame.g_label \
        .nSVFrame.rawDataFrame.h_label \
        .nSVFrame.rawDataFrame.i_label \
        .nSVFrame.rawDataFrame.j_label \
        .nSVFrame.rawDataFrame.k_label \
        .nSVFrame.rawDataFrame.l_label \
        .nSVFrame.rawDataFrame.a_label \
        .nSVFrame.rawDataFrame.b_label \
        .nSVFrame.rawDataFrame.c_label \
        .nSVFrame.rawDataFrame.d_label \
        .nSVFrame.rawDataFrame.e_label \
        .nSVFrame.rawDataFrame.f_label \
    ]
    
    set rawDataValues [list \
        .nSVFrame.rawDataFrame.r_value \
        .nSVFrame.rawDataFrame.s_value \
        .nSVFrame.rawDataFrame.t_value \
        .nSVFrame.rawDataFrame.u_value \
        .nSVFrame.rawDataFrame.v_value \
        .nSVFrame.rawDataFrame.w_value \
        .nSVFrame.rawDataFrame.g_value \
        .nSVFrame.rawDataFrame.h_value \
        .nSVFrame.rawDataFrame.i_value \
        .nSVFrame.rawDataFrame.j_value \
        .nSVFrame.rawDataFrame.k_value \
        .nSVFrame.rawDataFrame.l_value \
        .nSVFrame.rawDataFrame.a_value \
        .nSVFrame.rawDataFrame.b_value \
        .nSVFrame.rawDataFrame.c_value \
        .nSVFrame.rawDataFrame.d_value \
        .nSVFrame.rawDataFrame.e_value \
        .nSVFrame.rawDataFrame.f_value \
    ]
        
    set lWidgets [list .nSVFrame.rawDataFrame.r_value .nSVFrame.rawDataFrame.s_value .nSVFrame.rawDataFrame.t_value \
                       .nSVFrame.rawDataFrame.u_value .nSVFrame.rawDataFrame.v_value .nSVFrame.rawDataFrame.w_value \
                       .nSVFrame.rawDataFrame.j_value .nSVFrame.rawDataFrame.i_value .nSVFrame.rawDataFrame.g_value \
                       .nSVFrame.rawDataFrame.h_value .nSVFrame.rawDataFrame.k_value .nSVFrame.rawDataFrame.l_value \
                       .nSVFrame.rawDataFrame.d_value .nSVFrame.rawDataFrame.c_value .nSVFrame.rawDataFrame.a_value \
                       .nSVFrame.rawDataFrame.b_value .nSVFrame.rawDataFrame.e_value .nSVFrame.rawDataFrame.f_value ]

    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateText updateText updateText \
                           updateText updateText updateText \
                           updateText updateText updateText \
                           updateText updateText updateText \
                           updateText updateText updateText \
                           updateText updateText updateText]
}

# Update bank mode
proc updateTcsMode {} {
    global responseIsError
    global tcsMode
    global lastnum
    
    doATcommand "ATTCSMD"
    if { $responseIsError == 0 } {
        set tcsMode $lastnum
        after 500    
    }
    # puts "Update tcsMode: $tcsMode"
}

# Switch between raw data or calibrated data
proc doCalibrationMode {} {
    global calibrationMode
    
    # check calibration mode
    switch -- $calibrationMode {
        0 {
            # in raw data mode
        }
        1 {
            # in calibrated data mode
        }
    }
    # get sample to refresh data display
    doGetSample
}

# Switch between sorted data or spectrum display
proc doDataDisplayMode {} {
    global dataDisplayMode
    
    # check display mode
    switch -- $dataDisplayMode {
        0 {
            # in channel sorted mode
            doSetRawDataSortMode 0
            # configure controls
            place forget .nSVFrame.spectrumFrame
            place .nSVFrame.rawDataFrame            -in .nSVFrame   -x   4 -y   35
        }
        1 {
            # in wavelength sorted mode
            doSetRawDataSortMode 1
            # configure controls
            place forget .nSVFrame.spectrumFrame
            place .nSVFrame.rawDataFrame            -in .nSVFrame   -x   4 -y   35
        }
        2 {
            # in spectrum mode
            # set spectrum display parameters
            doSyncCommand setSpectrumDisplayParameters  
            # configure controls
            place forget .nSVFrame.rawDataFrame
            place .nSVFrame.spectrumFrame           -in .nSVFrame   -x   4 -y   35
        }
    }
    # get sample to refresh data display
    doGetSample
}
    
# Switch between sorted by channel or by wavelength
proc doSetRawDataSortMode { sortMode } {
    global rawDataSortMode
    global channelSortedParams
    global wavelengthSortedParams
    global rawDataParams
    global rawDataLabels    

    #set new raw data sort mode
    set rawDataSortMode $sortMode
    switch -- $rawDataSortMode {
        0 {
            # sorted by channel
            set rawDataParams $channelSortedParams
            
            grid .nSVFrame.rawDataFrame.label1
            grid .nSVFrame.rawDataFrame.label2
            grid .nSVFrame.rawDataFrame.label3
        }
        1 {
            # sorted by wavelength
            set rawDataParams $wavelengthSortedParams
            
            grid remove .nSVFrame.rawDataFrame.label1
            grid remove .nSVFrame.rawDataFrame.label2
            grid remove .nSVFrame.rawDataFrame.label3
        }
    }
    foreach rawDataParam $rawDataParams rawDataLabel $rawDataLabels {
        $rawDataLabel configure -text [lindex $rawDataParam 0]       
    }
}

# Enable / disable sort mode depending from logging state
proc enableSortMode {} {
    global vLogging    
    global rawDataSortMode
    
    # check if log file is open
    if { $vLogging == true } {
        switch -- $rawDataSortMode {
            0 {
                # sorted by channel
                .nSVFrame.displayConfigureFrame.buttonWavelength configure -state disabled
            }
            1 {
                # sorted by wavelength
                .nSVFrame.displayConfigureFrame.buttonChannel    configure -state disabled
            }
        }
    } else {
        .nSVFrame.displayConfigureFrame.buttonChannel    configure -state normal
        .nSVFrame.displayConfigureFrame.buttonWavelength configure -state normal
    }
}

# Set spectrum display parameters
proc setSpectrumDisplayParameters {} {
    global dataDisplayMode
    global tcsMode
    
    # puts "Set spectrum parameters: $dataDisplayMode"
    # check display mode
    if { $dataDisplayMode == 2 } {
        # in spectrum display mode
        # set bank mode
        doATcommand "ATTCSMD=2"
        set tcsMode 2
        after 500    
        # puts "Set tcsMode: $tcsMode"
    }    
}

# Show the measured spectrum
proc showSpectrum { measureValues } {
    global calibrationMode
    global diagramMinValue
    global diagramMaxValue
    global minMaxLock
    global splineMode
    global wavelengthSortedParams

    # check measure values
    if { [llength $measureValues] != 18 } {
        puts "Bad measure value length([llength $measureValues]): $measureValues"
        return
    }
    # in not or sensor calibrated spectrum mode
    set spectrumValues {}        
    set wavelengthValues {}        
    foreach measureParam $wavelengthSortedParams {
        # get spectrum value
        set spectrumValue [lindex $measureValues [lindex $measureParam 1]]
        if { ($calibrationMode == 1) && (([string is double $spectrumValue] == 0) || ([string compare $spectrumValue "NaN"] == 0)) } {
            puts "Measure value $spectrumValue found in $measureValues"
            return
        }
        # save spectrum min and max values
        if { [llength $spectrumValues] == 0 } {
            set spectrumMin $spectrumValue
            set spectrumMax $spectrumValue
        } else {
            set spectrumMin [expr $spectrumValue < $spectrumMin ? $spectrumValue : $spectrumMin]
            set spectrumMax [expr $spectrumValue > $spectrumMax ? $spectrumValue : $spectrumMax]
        }
        lappend spectrumValues $spectrumValue
        # get wavelength value
        set wavelength [lindex $measureParam 2]
        lappend wavelengthValues $wavelength
    }
    # puts "Spectrum: $spectrumValues"
    # puts "Spectrum min: $spectrumMin"
    # puts "Spectrum max: $spectrumMax"
    # puts "Wavelength: $wavelengthValues"
 
    # check data values
    if { $spectrumMax == $spectrumMin } {
        set spectrumMin [expr $spectrumMin - 1]
        set spectrumMax [expr $spectrumMax + 1]
    }
    
    # set diagram min max values
    if { $minMaxLock == 0 } {
        set diagramMinValue $spectrumMin
        set diagramMaxValue $spectrumMax
        .nSVFrame.spectrumFrame.labelYmin configure -text "[formatNumericValue $diagramMinValue]"    
        .nSVFrame.spectrumFrame.labelYmax configure -text "[formatNumericValue $diagramMaxValue]"    
    }
    
    # set transformation coordinates
    set canvasXmin 0
    set canvasXmax [.nSVFrame.spectrumFrame.diagram cget -width]
    set canvasYmin [expr [.nSVFrame.spectrumFrame.diagram cget -height] - 2]
    set canvasYmax 2
        
    # puts "canvas size: $canvasXmin $canvasXmax $canvasYmin $canvasYmax"

    set dataXmin 350
    set dataXmax 1050
    set dataYmin $diagramMinValue
    set dataYmax $diagramMaxValue

    set gainX [expr double($canvasXmax - $canvasXmin) / double($dataXmax - $dataXmin)]
    set offsetX [expr $canvasXmin - $gainX * $dataXmin]

    set gainY [expr double($canvasYmax - $canvasYmin) / double($dataYmax - $dataYmin)]
    set offsetY [expr $canvasYmin - $gainY * $dataYmin]
    
    # prepare spectrum plot
    set spectrumPlot {}
    foreach wavelength $wavelengthValues spectrumValue $spectrumValues {
        lappend spectrumPlot [expr $gainX * $wavelength + $offsetX] [expr $gainY * $spectrumValue + $offsetY]
    }
    
    # puts "Spectrum plot: $spectrumPlot"
    
    # clear graph
    .nSVFrame.spectrumFrame.diagram delete "all"
        
    # plot spectrum
    if { $splineMode == 1 } {
        set smoothValue "bezier"
    } else {
        set smoothValue 0
    }
    .nSVFrame.spectrumFrame.diagram create line $spectrumPlot -smooth $smoothValue
}

# format numeric values
proc formatNumericValue { value } {
    
    # puts "Format value: $value"
    set absValue [expr abs($value)]
    if { ($absValue < 100000) && ($absValue >= 0.01) } {
        return [format "%0.3f" $value]
    } else {
        return [format "%#.4g" $value]
    }
}

# Calculate spectrum by multiplying calibration matrix with measure values
# Return spectrum values, spectrum min, spectrum max  
proc calculateSpectrum { measureValues calibrationMatrix } {
    
    set spectrumValues {}
    set spectrumMin 0
    set spectrumMax 0
    set column [lindex $calibrationMatrix 0]
    set columnNumber [llength $column]
    set rowNumber [llength $calibrationMatrix]
    set measureNumber [llength $measureValues]
    
    # check if calibration matrix size corresponds with measure value size
    if { $columnNumber != $measureNumber } {
        tk_messageBox -icon error \
        -message "Calibration matrix has bad size" \
        -detail "Calibration matrix has $columnNumber instead of $measureNumber columns" \
        -title "ams Calibration Matrix Dimension Failure" -type ok
        return [list false]
    }
    # multiply calibration matrix with measure values
    for { set rowIndex 0 } { $rowIndex < $rowNumber } { incr rowIndex } {
        set spectrumValue 0
        for { set columnIndex 0 } { $columnIndex < $columnNumber } { incr columnIndex } {
            if { [catch {
                    set matrixDotValue [string map { "," "." } [lindex $calibrationMatrix $rowIndex $columnIndex]]
                    set spectrumValue [expr $spectrumValue + [lindex $measureValues $columnIndex] * $matrixDotValue ]
                 } errorMessage] } {
                tk_messageBox -icon error \
                -message "Calibration calculation error" \
                -detail "Calibration matrix has bad value in row $rowIndex column $columnIndex" \
                -title "ams Calibration Matrix Value Failure" -type ok
                set spectrumValues {}
                return [list false]
            }
        }
        # save spectrum min and max values
        if { [llength $spectrumValues] == 0 } {
            set spectrumMin $spectrumValue
            set spectrumMax $spectrumValue
        } else {
            set spectrumMin [expr $spectrumValue < $spectrumMin ? $spectrumValue : $spectrumMin]
            set spectrumMax [expr $spectrumValue > $spectrumMax ? $spectrumValue : $spectrumMax]
        }
        lappend spectrumValues $spectrumValue
    }
    return [list true $spectrumValues $spectrumMin $spectrumMax]
}
    
proc Do7263nIRSensorDisplay {} {
    global vOverwrite
    global vLogging
    global lWidgets
    global lWidgetHighIndex
    global amslogo
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bUpdateModeAuto
    global statusLastUpdate
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global S7label
    global S8label
    global S9label
    global S10label
    global S11label
    global S12label
    global S13label
    global S14label
    global S15label
    global S16label
    global S17label
    global S18label

    global CS1label
    global CS2label
    global CS3label
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lUpdateProcs
    global led0ControlWidget
    global led1ControlWidget

    # ------------------------ nIR Sensor Control Panel
    frame .sscFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 386 -height 240 -background $ams_gray25
    label .sscFrame.label -text "Control & Status " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    frame .sscFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .sscFrame.sampleModeLabel -text "Metric Update Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .sscFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .sscFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .sscFrame.sampleUpdate
    label .sscFrame.burstMsg -text "" -fg $ams_gray95  -bg $ams_gray25

    frame .sscFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .sscFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .sscFrame.sampleStopAfter.v
    pack .sscFrame.sampleStopAfter.l .sscFrame.sampleStopAfter.v \
        -in .sscFrame.sampleStopAfter -side left

    frame .sscFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 130
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .sscFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .sscFrame.luTimeL

    frame .sscFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleCount.l -text "Samples" -justify left
    label .sscFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .sscFrame.sampleCount.v
    frame .sscFrame.ledFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 60 -width 340
    label .sscFrame.ledFrame.l       -text "LED Control (Electronic Shutter)"  \
        -fg $ams_gray95  -bg $ams_gray25
    if { 0 } {
        button .sscFrame.ledFrame.led0Button -text " Turn LED0 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED0 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led0ControlWidget .sscFrame.ledFrame.led0Button
        doATcommand "ATLED0=0"
        button .sscFrame.ledFrame.led1Button -text " Turn LED1 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED1 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led1ControlWidget .sscFrame.ledFrame.led1Button
        doATcommand "ATLED1=0"
        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0Button   -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1Button   -in .sscFrame.ledFrame   -x 228 -y 24
    } else {
        label .sscFrame.ledFrame.led0label -text "LED0: " -justify left -bg $ams_gray25 -fg $ams_gray95
        if { 0 } {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA 2mA 4mA 8mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        } else {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        }
        set led0ControlWidget .sscFrame.ledFrame.led0Spinbox
        label .sscFrame.ledFrame.led1label -text "LED1: " -justify left -bg $ams_gray25 -fg $ams_gray95
        spinbox .sscFrame.ledFrame.led1Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
            -font {system -12 bold} -exportselection true -state readonly \
            -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED1 %s }
        set led1ControlWidget .sscFrame.ledFrame.led1Spinbox

        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0label    -in .sscFrame.ledFrame   -x  43 -y 26
        place .sscFrame.ledFrame.led0Spinbox  -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1label    -in .sscFrame.ledFrame   -x 193 -y 26
        place .sscFrame.ledFrame.led1Spinbox  -in .sscFrame.ledFrame   -x 228 -y 24
    }

    pack .sscFrame.sampleCount.l .sscFrame.sampleCount.v -in .sscFrame.sampleCount -side left
    place .sscFrame.sampleCount -in .sscFrame.statusFrame  -x   6 -y  76
    place .sscFrame.l           -in .sscFrame.statusFrame  -x   4 -y   4
    place .sscFrame.luLabel     -in .sscFrame.statusFrame  -x  24 -y  26
    place .sscFrame.luTimeL     -in .sscFrame.statusFrame  -x  34 -y  46

    place .sscFrame.sampleModeLabel   -in .sscFrame.sampleMode -x 4   -y 4
    #   place .sscFrame.sampleModeAuto    -in .sscFrame.sampleMode -x 16  -y 24
    #   place .sscFrame.sampleModeManual  -in .sscFrame.sampleMode -x 16  -y 44
    place .sscFrame.continuousMode    -in .sscFrame.sampleMode -x 16  -y 32
    place .sscFrame.sampleUpdate      -in .sscFrame.sampleMode -x 120 -y 32
    place .sscFrame.sampleStopAfter   -in .sscFrame.sampleMode -x 40  -y 76
    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 126 -y 58

    place .sscFrame.label             -in .sscFrame -x  4 -y   4
    place .sscFrame.sampleMode        -in .sscFrame -x  22 -y  32
    place .sscFrame.statusFrame       -in .sscFrame -x 230 -y  32
    place .sscFrame.ledFrame          -in .sscFrame -x  22 -y 160

    place .sscFrame    -in .theNoteBook.nIRSensor.sFrame  -x 30  -y 16

    # ------------------------ Sensor Values
    frame .nIRFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 330 -height 390 -background $ams_gray25
    label .nIRFrame.label -text "nIR Sensor Values " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    label .nIRFrame.labelR -text "Raw" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    label .nIRFrame.labelC -text "Calibrated" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .nIRFrame.r_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.r_label -text "R (610nm) " -justify left -font {TkMenuFont -14}
    label .nIRFrame.r_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.r_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.r_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.r_label .nIRFrame.r_value .nIRFrame.r_labelD .nIRFrame.r_valueC -in .nIRFrame.r_frame -side left

    frame .nIRFrame.s_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.s_label -text "S (680nm) " -justify left  -font {TkMenuFont -14}
    label .nIRFrame.s_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.s_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.s_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.s_label .nIRFrame.s_value .nIRFrame.s_labelD .nIRFrame.s_valueC -in .nIRFrame.s_frame -side left

    frame .nIRFrame.t_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.t_label -text "T (730nm) " -justify left  -font {TkMenuFont -14}
    label .nIRFrame.t_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.t_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.t_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.t_label .nIRFrame.t_value .nIRFrame.t_labelD .nIRFrame.t_valueC -in .nIRFrame.t_frame -side left

    frame .nIRFrame.u_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.u_label -text "U (760nm) " -justify left  -font {TkMenuFont -14}
    label .nIRFrame.u_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.u_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.u_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.u_label .nIRFrame.u_value .nIRFrame.u_labelD .nIRFrame.u_valueC -in .nIRFrame.u_frame -side left

    frame .nIRFrame.v_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.v_label -text "V (810nm) " -justify left  -font {TkMenuFont -14}
    label .nIRFrame.v_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.v_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.v_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.v_label .nIRFrame.v_value .nIRFrame.v_labelD .nIRFrame.v_valueC -in .nIRFrame.v_frame -side left

    frame .nIRFrame.w_frame -bd 2 -relief raised -padx 2 -pady 1
    label .nIRFrame.w_label -text "W (860nm) " -justify left  -font {TkMenuFont -14}
    label .nIRFrame.w_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .nIRFrame.w_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .nIRFrame.w_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .nIRFrame.w_label .nIRFrame.w_value .nIRFrame.w_labelD .nIRFrame.w_valueC -in .nIRFrame.w_frame -side left

    place .nIRFrame.label           -in .nIRFrame      -x   4 -y   4
    place .nIRFrame.labelR          -in .nIRFrame      -x 140 -y   30
    place .nIRFrame.labelC          -in .nIRFrame      -x 207 -y   30
    place .nIRFrame.r_frame         -in .nIRFrame      -x  45 -y   55
    place .nIRFrame.s_frame         -in .nIRFrame      -x  45 -y   110
    place .nIRFrame.t_frame         -in .nIRFrame      -x  45 -y   165
    place .nIRFrame.u_frame         -in .nIRFrame      -x  45 -y   220
    place .nIRFrame.v_frame         -in .nIRFrame      -x  45 -y   275
    place .nIRFrame.w_frame         -in .nIRFrame      -x  45 -y   330

    place .nIRFrame    -in .theNoteBook.nIRSensor.sFrame  -x 440 -y 16

    # Set the widget list used to get samples
    set sampleWidgetNames "Sample, R, S, T, U, V, W, Timestamp"
    set lWidgets [list .nIRFrame.r_value  .nIRFrame.s_value  .nIRFrame.t_value \
        .nIRFrame.u_value  .nIRFrame.v_value  .nIRFrame.w_value \
        .nIRFrame.r_valueC .nIRFrame.s_valueC .nIRFrame.t_valueC \
        .nIRFrame.u_valueC .nIRFrame.v_valueC .nIRFrame.w_valueC]
    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText updateText]
}

proc Do7262SensorDisplay {} {
    global vOverwrite
    global vLogging
    global lWidgets
    global lWidgetHighIndex
    global amslogo
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bUpdateModeAuto
    global statusLastUpdate
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global CS1label
    global CS2label
    global CS3label
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lUpdateProcs
    global led0ControlWidget
    global led1ControlWidget

    # ------------------------ Sensor Control Panel
    frame .sscFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 386 -height 240 -background $ams_gray25
    label .sscFrame.label -text "Control & Status " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    frame .sscFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .sscFrame.sampleModeLabel -text "Metric Update Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .sscFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .sscFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .sscFrame.sampleUpdate
    label .sscFrame.burstMsg -text "" -fg $ams_gray95  -bg $ams_gray25

    frame .sscFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .sscFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .sscFrame.sampleStopAfter.v
    pack .sscFrame.sampleStopAfter.l .sscFrame.sampleStopAfter.v \
        -in .sscFrame.sampleStopAfter -side left

    frame .sscFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 130
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .sscFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .sscFrame.luTimeL

    frame .sscFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleCount.l -text "Samples" -justify left
    label .sscFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .sscFrame.sampleCount.v
    frame .sscFrame.ledFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 60 -width 340
    label .sscFrame.ledFrame.l       -text "LED Control (Electronic Shutter)"  \
        -fg $ams_gray95  -bg $ams_gray25
    if { 0 } {
        button .sscFrame.ledFrame.led0Button -text " Turn LED0 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED0 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led0ControlWidget .sscFrame.ledFrame.led0Button
        doATcommand "ATLED0=0"
        button .sscFrame.ledFrame.led1Button -text " Turn LED1 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED1 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led1ControlWidget .sscFrame.ledFrame.led1Button
        doATcommand "ATLED1=0"
        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0Button   -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1Button   -in .sscFrame.ledFrame   -x 228 -y 24
    } else {
        label .sscFrame.ledFrame.led0label -text "LED0: " -justify left -bg $ams_gray25 -fg $ams_gray95
        if { 0 } {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA 2mA 4mA 8mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        } else {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        }
        set led0ControlWidget .sscFrame.ledFrame.led0Spinbox
        label .sscFrame.ledFrame.led1label -text "LED1: " -justify left -bg $ams_gray25 -fg $ams_gray95
        spinbox .sscFrame.ledFrame.led1Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
            -font {system -12 bold} -exportselection true -state readonly \
            -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED1 %s }
        set led1ControlWidget .sscFrame.ledFrame.led1Spinbox

        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0label    -in .sscFrame.ledFrame   -x  43 -y 26
        place .sscFrame.ledFrame.led0Spinbox  -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1label    -in .sscFrame.ledFrame   -x 193 -y 26
        place .sscFrame.ledFrame.led1Spinbox  -in .sscFrame.ledFrame   -x 228 -y 24
    }

    pack .sscFrame.sampleCount.l .sscFrame.sampleCount.v -in .sscFrame.sampleCount -side left
    place .sscFrame.sampleCount -in .sscFrame.statusFrame  -x   6 -y  76
    place .sscFrame.l           -in .sscFrame.statusFrame  -x   4 -y   4
    place .sscFrame.luLabel     -in .sscFrame.statusFrame  -x  24 -y  26
    place .sscFrame.luTimeL     -in .sscFrame.statusFrame  -x  34 -y  46

    place .sscFrame.sampleModeLabel   -in .sscFrame.sampleMode -x 4   -y 4
    #   place .sscFrame.sampleModeAuto    -in .sscFrame.sampleMode -x 16  -y 24
    #   place .sscFrame.sampleModeManual  -in .sscFrame.sampleMode -x 16  -y 44
    place .sscFrame.continuousMode    -in .sscFrame.sampleMode -x 16  -y 32
    place .sscFrame.sampleUpdate      -in .sscFrame.sampleMode -x 120 -y 32
    place .sscFrame.sampleStopAfter   -in .sscFrame.sampleMode -x 40  -y 76
    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 126 -y 58

    place .sscFrame.label             -in .sscFrame -x  4 -y   4
    place .sscFrame.sampleMode        -in .sscFrame -x  22 -y  32
    place .sscFrame.statusFrame       -in .sscFrame -x 230 -y  32
    place .sscFrame.ledFrame          -in .sscFrame -x  22 -y 160

    place .sscFrame    -in .theNoteBook.s62Sensor.sFrame  -x 30  -y 16

    # ------------------------ Sensor Values
    frame .s62Frame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 330 -height 390 -background $ams_gray25
    label .s62Frame.label -text "Spectral Sensor Values " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    label .s62Frame.labelR -text "Raw" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    label .s62Frame.labelC -text "Calibrated" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .s62Frame.v_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.v_label -text "V (450nm) " -justify left -font {TkMenuFont -14}
    label .s62Frame.v_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.v_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.v_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.v_label .s62Frame.v_value .s62Frame.v_labelD .s62Frame.v_valueC -in .s62Frame.v_frame -side left

    frame .s62Frame.b_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.b_label -text "B (500nm) " -justify left  -font {TkMenuFont -14}
    label .s62Frame.b_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.b_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.b_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.b_label .s62Frame.b_value .s62Frame.b_labelD .s62Frame.b_valueC -in .s62Frame.b_frame -side left

    frame .s62Frame.g_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.g_label -text "G (550nm) " -justify left  -font {TkMenuFont -14}
    label .s62Frame.g_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.g_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.g_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.g_label .s62Frame.g_value .s62Frame.g_labelD .s62Frame.g_valueC -in .s62Frame.g_frame -side left

    frame .s62Frame.y_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.y_label -text "Y (570nm) " -justify left  -font {TkMenuFont -14}
    label .s62Frame.y_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.y_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.y_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.y_label .s62Frame.y_value .s62Frame.y_labelD .s62Frame.y_valueC -in .s62Frame.y_frame -side left

    frame .s62Frame.o_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.o_label -text "O (600nm) " -justify left  -font {TkMenuFont -14}
    label .s62Frame.o_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.o_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.o_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.o_label .s62Frame.o_value .s62Frame.o_labelD .s62Frame.o_valueC -in .s62Frame.o_frame -side left

    frame .s62Frame.r_frame -bd 2 -relief raised -padx 2 -pady 1
    label .s62Frame.r_label -text "W (650nm) " -justify left  -font {TkMenuFont -14}
    label .s62Frame.r_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    label .s62Frame.r_labelD -text "   " -justify left -font {TkMenuFont -14}
    label .s62Frame.r_valueC -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 8 -anchor e
    pack .s62Frame.r_label .s62Frame.r_value .s62Frame.r_labelD .s62Frame.r_valueC -in .s62Frame.r_frame -side left

    place .s62Frame.label           -in .s62Frame      -x   4 -y   4
    place .s62Frame.labelR          -in .s62Frame      -x 140 -y   30
    place .s62Frame.labelC          -in .s62Frame      -x 207 -y   30
    place .s62Frame.v_frame         -in .s62Frame      -x  45 -y   55
    place .s62Frame.b_frame         -in .s62Frame      -x  45 -y   110
    place .s62Frame.g_frame         -in .s62Frame      -x  45 -y   165
    place .s62Frame.y_frame         -in .s62Frame      -x  45 -y   220
    place .s62Frame.o_frame         -in .s62Frame      -x  45 -y   275
    place .s62Frame.r_frame         -in .s62Frame      -x  45 -y   330

    place .s62Frame    -in .theNoteBook.s62Sensor.sFrame  -x 440 -y 16

    # Set the widget list used to get samples
    set sampleWidgetNames "Sample, V, B, G, Y, O, R, Timestamp"
    set lWidgets [list .s62Frame.v_value  .s62Frame.b_value  .s62Frame.g_value \
        .s62Frame.y_value  .s62Frame.o_value  .s62Frame.r_value \
        .s62Frame.v_valueC .s62Frame.b_valueC .s62Frame.g_valueC \
        .s62Frame.y_valueC .s62Frame.o_valueC .s62Frame.r_valueC]
    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText updateText]
}

proc Do7261SpectralSensorDisplay {} {
    global vOverwrite
    global vLogging
    global lWidgets
    global lWidgetHighIndex
    global amslogo
    global hwModel
    global scModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bUpdateModeAuto
    global statusLastUpdate
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global CS1label
    global CS2label
    global CS3label
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lUpdateProcs
    global led0ControlWidget
    global led1ControlWidget
    global usingI2Cadapter
    global tcsMode

    if { 0 } {
        if { $usingI2Cadapter } {
            # Continuous X, Y, Z, and Dk mode is the only continous mode supported
            set tcsMode 0
        }
    }

    if { $scModel == 2} {
        # Default to 6 sensors/two cycles per sample
        set tcsMode 2
    }

    # ------------------------ Spectral Sensor Control Panel
    frame .sscFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 386 -height 240 -background $ams_gray25
    label .sscFrame.label -text "Control & Status " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    frame .sscFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .sscFrame.sampleModeLabel -text "Metric Update Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .sscFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .sscFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .sscFrame.sampleUpdate
    label .sscFrame.burstMsg -text "" -fg $ams_gray95  -bg $ams_gray25

    frame .sscFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .sscFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .sscFrame.sampleStopAfter.v
    pack .sscFrame.sampleStopAfter.l .sscFrame.sampleStopAfter.v \
        -in .sscFrame.sampleStopAfter -side left

    frame .sscFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 130
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .sscFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .sscFrame.luTimeL

    frame .sscFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleCount.l -text "Samples" -justify left
    label .sscFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .sscFrame.sampleCount.v
    frame .sscFrame.ledFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 60 -width 340
    label .sscFrame.ledFrame.l       -text "LED Control (Electronic Shutter)"  \
        -fg $ams_gray95  -bg $ams_gray25
    if { 0 } {
        button .sscFrame.ledFrame.led0Button -text " Turn LED0 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED0 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led0ControlWidget .sscFrame.ledFrame.led0Button
        doATcommand "ATLED0=0"
        button .sscFrame.ledFrame.led1Button -text " Turn LED1 On " -bg $ams_gray25 -fg $ams_gray95 \
            -command { doLED1 } -relief raised -bd 2 -highlightbackground $ams_gray25
        set led1ControlWidget .sscFrame.ledFrame.led1Button
        doATcommand "ATLED1=0"
        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0Button   -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1Button   -in .sscFrame.ledFrame   -x 228 -y 24
    } else {
        label .sscFrame.ledFrame.led0label -text "LED0: " -justify left -bg $ams_gray25 -fg $ams_gray95
        if { 0 } {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA 2mA 4mA 8mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        } else {
            spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA} -wrap true -borderwidth 3 \
                -font {system -12 bold} -exportselection true -state readonly \
                -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
        }
        set led0ControlWidget .sscFrame.ledFrame.led0Spinbox
        label .sscFrame.ledFrame.led1label -text "LED1: " -justify left -bg $ams_gray25 -fg $ams_gray95
        spinbox .sscFrame.ledFrame.led1Spinbox -values {OFF 12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
            -font {system -12 bold} -exportselection true -state readonly \
            -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED1 %s }
        set led1ControlWidget .sscFrame.ledFrame.led1Spinbox

        place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
        place .sscFrame.ledFrame.led0label    -in .sscFrame.ledFrame   -x  43 -y 26
        place .sscFrame.ledFrame.led0Spinbox  -in .sscFrame.ledFrame   -x  78 -y 24
        place .sscFrame.ledFrame.led1label    -in .sscFrame.ledFrame   -x 193 -y 26
        place .sscFrame.ledFrame.led1Spinbox  -in .sscFrame.ledFrame   -x 228 -y 24
    }

    pack .sscFrame.sampleCount.l .sscFrame.sampleCount.v -in .sscFrame.sampleCount -side left
    place .sscFrame.sampleCount -in .sscFrame.statusFrame  -x   6 -y  76
    place .sscFrame.l           -in .sscFrame.statusFrame  -x   4 -y   4
    place .sscFrame.luLabel     -in .sscFrame.statusFrame  -x  24 -y  26
    place .sscFrame.luTimeL     -in .sscFrame.statusFrame  -x  34 -y  46

    place .sscFrame.sampleModeLabel   -in .sscFrame.sampleMode -x 4   -y 4
    #   place .sscFrame.sampleModeAuto    -in .sscFrame.sampleMode -x 16  -y 24
    #   place .sscFrame.sampleModeManual  -in .sscFrame.sampleMode -x 16  -y 44
    place .sscFrame.continuousMode    -in .sscFrame.sampleMode -x 16  -y 32
    place .sscFrame.sampleUpdate      -in .sscFrame.sampleMode -x 120 -y 32
    place .sscFrame.sampleStopAfter   -in .sscFrame.sampleMode -x 40  -y 76
    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 126 -y 58

    place .sscFrame.label             -in .sscFrame -x  4 -y   4
    place .sscFrame.sampleMode        -in .sscFrame -x  22 -y  32
    place .sscFrame.statusFrame       -in .sscFrame -x 230 -y  32
    place .sscFrame.ledFrame          -in .sscFrame -x  22 -y 160

    place .sscFrame    -in .theNoteBook.spectralSensor.sFrame  -x 30  -y 16

    # ------------------------ Computed Values
    frame .derFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 318 -height 240 -background $ams_gray25
    label .derFrame.label -text "Computed Values " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .derFrame.cct_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.cct_label -text "CCT   " -justify left -font {TkMenuFont -14}
    label .derFrame.cct_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.cct_label .derFrame.cct_value -in .derFrame.cct_frame -side left

    frame .derFrame.duv_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.duv_label -text "Duv   " -justify left  -font {TkMenuFont -14}
    label .derFrame.duv_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.duv_label .derFrame.duv_value -in .derFrame.duv_frame -side left

    frame .derFrame.up_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.up_label -text "u'      " -justify left  -font {TkMenuFont -14}
    label .derFrame.up_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.up_label .derFrame.up_value -in .derFrame.up_frame -side left

    frame .derFrame.vp_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.vp_label -text "v'      " -justify left  -font {TkMenuFont -14}
    label .derFrame.vp_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.vp_label .derFrame.vp_value -in .derFrame.vp_frame -side left

    frame .derFrame.u_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.u_label -text "u       " -justify left  -font {TkMenuFont -14}
    label .derFrame.u_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.u_label .derFrame.u_value -in .derFrame.u_frame -side left

    frame .derFrame.v_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.v_label -text "v       " -justify left  -font {TkMenuFont -14}
    label .derFrame.v_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.v_label .derFrame.v_value -in .derFrame.v_frame -side left

    frame .derFrame.x_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.x_label -text "x      " -justify left  -font {TkMenuFont -14}
    label .derFrame.x_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.x_label .derFrame.x_value -in .derFrame.x_frame -side left

    frame .derFrame.y_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.y_label -text "y      " -justify left  -font {TkMenuFont -14}
    label .derFrame.y_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.y_label .derFrame.y_value -in .derFrame.y_frame -side left

    place .derFrame.label             -in .derFrame      -x   4 -y   4
    place .derFrame.cct_frame         -in .derFrame      -x  27 -y   32
    place .derFrame.duv_frame         -in .derFrame      -x 166 -y   32
    place .derFrame.up_frame          -in .derFrame      -x  27 -y   80
    place .derFrame.vp_frame          -in .derFrame      -x 166 -y   80
    place .derFrame.u_frame           -in .derFrame      -x  27 -y  128
    place .derFrame.v_frame           -in .derFrame      -x 166 -y  128
    place .derFrame.x_frame           -in .derFrame      -x  27 -y  176
    place .derFrame.y_frame           -in .derFrame      -x 166 -y  176

    place .derFrame    -in .theNoteBook.spectralSensor.sFrame  -x 442 -y 16

    # ------------------------ Raw Sensor Data
    frame .svFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 386 -height 140 -background $ams_gray25
    label .svFrame.label -text "Raw Sensor Metrics" -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .svFrame.s1_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s1_label -text "$S1label" -justify left
    label .svFrame.s1_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s1_label .svFrame.s1_value -in .svFrame.s1_frame -side left

    frame .svFrame.s2_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s2_label -text "$S2label" -justify left
    label .svFrame.s2_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s2_label .svFrame.s2_value -in .svFrame.s2_frame -side left

    frame .svFrame.s3_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s3_label -text "$S3label" -justify left
    label .svFrame.s3_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s3_label .svFrame.s3_value -in .svFrame.s3_frame -side left

    frame .svFrame.s4_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s4_label -text "$S4label" -justify left
    label .svFrame.s4_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s4_label .svFrame.s4_value -in .svFrame.s4_frame -side left

    frame .svFrame.s5_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s5_label -text "$S5label" -justify left
    label .svFrame.s5_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s5_label .svFrame.s5_value -in .svFrame.s5_frame -side left

    frame .svFrame.s6_frame -bd 2 -relief raised -padx 2 -pady 1
    label .svFrame.s6_label -text "$S6label" -justify left
    label .svFrame.s6_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .svFrame.s6_label .svFrame.s6_value -in .svFrame.s6_frame -side left
    # Swapped s4 (nIR) and s5 (Dk) positions.
    place .svFrame.label    -in .svFrame -x   4 -y 4
    place .svFrame.s1_frame -in .svFrame -x  26 -y 38
    place .svFrame.s2_frame -in .svFrame -x 145 -y 38
    place .svFrame.s3_frame -in .svFrame -x 264 -y 38
    place .svFrame.s4_frame -in .svFrame -x  26 -y 92
    place .svFrame.s5_frame -in .svFrame -x 145 -y 92
    place .svFrame.s6_frame -in .svFrame -x 264 -y 92

    place .svFrame    -in .theNoteBook.spectralSensor.sFrame  -x 30 -y 270

    # ------------------------ Calibrated Sensor Data
    frame .csvFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 318 -height 140 -background $ams_gray25
    label .csvFrame.label -text "CIE 1931 Calibrated Sensor Metrics" -font {system -8 bold} \
        -bg $ams_gray25 -fg $ams_gray95

    frame .csvFrame.cs1_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs1_label -text "$CS1label" -justify left
    label .csvFrame.cs1_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs1_label .csvFrame.cs1_value -in .csvFrame.cs1_frame -side left

    frame .csvFrame.cs2_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs2_label -text "$CS2label" -justify left
    label .csvFrame.cs2_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs2_label .csvFrame.cs2_value -in .csvFrame.cs2_frame -side left

    frame .csvFrame.cs3_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs3_label -text "$CS3label" -justify left
    label .csvFrame.cs3_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs3_label .csvFrame.cs3_value -in .csvFrame.cs3_frame -side left

    place .csvFrame.label    -in .csvFrame  -x   4 -y 4
    place .csvFrame.cs1_frame -in .csvFrame -x   6 -y 38
    place .csvFrame.cs2_frame -in .csvFrame -x 110 -y 38
    place .csvFrame.cs3_frame -in .csvFrame -x 214 -y 38

    place .csvFrame    -in .theNoteBook.spectralSensor.sFrame  -x 442 -y 270

    # Set the widget list used to get samples.
    set sampleWidgetNames "Sample, $S1label, $S2label, $S3label, $S4label, $S5label, $S6label, $CS1label, $CS2label, $CS3label, CCT, Duv, u', v', u, v, x, y, Timestamp"
    set lWidgets [list .svFrame.s1_value .svFrame.s2_value .svFrame.s3_value \
        .svFrame.s4_value .svFrame.s5_value .svFrame.s6_value \
        .csvFrame.cs1_value .csvFrame.cs2_value .csvFrame.cs3_value \
        .derFrame.cct_value .derFrame.duv_value \
        .derFrame.up_value  .derFrame.vp_value  \
        .derFrame.u_value .derFrame.v_value \
        .derFrame.x_value .derFrame.y_value]
    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText updateText \
        updateText updateText \
        updateText updateText \
        updateText updateText \
        updateText updateText ]
}

proc Do7225Display {} {
    global vOverwrite
    global vLogging
    global lWidgets
    global lWidgetHighIndex
    global amslogo
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bUpdateModeAuto
    global statusLastUpdate
    global S1label
    global S2label
    global S3label
    global S4label
    global S5label
    global S6label
    global CS1label
    global CS2label
    global CS3label
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lUpdateProcs
    global led0ControlWidget
    global led1ControlWidget
    global tcsMode

    set tcsMode 3

    # ------------------------ True Color Sensor Control Panel
    frame .sscFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 386 -height 240 -background $ams_gray25
    label .sscFrame.label -text "Control & Status " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95
    frame .sscFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .sscFrame.sampleModeLabel -text "Metric Update Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .sscFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .sscFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .sscFrame.sampleUpdate
    label .sscFrame.burstMsg -text "" -fg $ams_gray95  -bg $ams_gray25

    frame .sscFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .sscFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .sscFrame.sampleStopAfter.v
    pack .sscFrame.sampleStopAfter.l .sscFrame.sampleStopAfter.v \
        -in .sscFrame.sampleStopAfter -side left

    frame .sscFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 130
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .sscFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .sscFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .sscFrame.luTimeL

    frame .sscFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .sscFrame.sampleCount.l -text "Samples" -justify left
    label .sscFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .sscFrame.sampleCount.v
    frame .sscFrame.ledFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 60 -width 340
    label .sscFrame.ledFrame.l       -text "LED Control (Electronic Shutter)"  \
        -fg $ams_gray95  -bg $ams_gray25

    label .sscFrame.ledFrame.led0label -text "LED0: " -justify left -bg $ams_gray25 -fg $ams_gray95
    # When using the AS72A1 with in-line VCC resistor, only allow 1mA.
    if { 0 } {
        spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA 2mA 4mA 8mA} -wrap true -borderwidth 3 \
            -font {system -12 bold} -exportselection true -state readonly \
            -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
    } else {
        spinbox .sscFrame.ledFrame.led0Spinbox -values {OFF 1mA} -wrap true -borderwidth 3 \
            -font {system -12 bold} -exportselection true -state readonly \
            -relief sunken -width 5 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doLED0 %s }
    }
    set led0ControlWidget .sscFrame.ledFrame.led0Spinbox

    place .sscFrame.ledFrame.l            -in .sscFrame.ledFrame   -x   4 -y  4
    place .sscFrame.ledFrame.led0label    -in .sscFrame.ledFrame   -x  43 -y 26
    place .sscFrame.ledFrame.led0Spinbox  -in .sscFrame.ledFrame   -x  78 -y 24

    pack .sscFrame.sampleCount.l .sscFrame.sampleCount.v -in .sscFrame.sampleCount -side left
    place .sscFrame.sampleCount -in .sscFrame.statusFrame  -x   6 -y  76
    place .sscFrame.l           -in .sscFrame.statusFrame  -x   4 -y   4
    place .sscFrame.luLabel     -in .sscFrame.statusFrame  -x  24 -y  26
    place .sscFrame.luTimeL     -in .sscFrame.statusFrame  -x  34 -y  46

    place .sscFrame.sampleModeLabel   -in .sscFrame.sampleMode -x 4   -y 4
    #   place .sscFrame.sampleModeAuto    -in .sscFrame.sampleMode -x 16  -y 24
    #   place .sscFrame.sampleModeManual  -in .sscFrame.sampleMode -x 16  -y 44
    place .sscFrame.continuousMode    -in .sscFrame.sampleMode -x 16  -y 32
    place .sscFrame.sampleUpdate      -in .sscFrame.sampleMode -x 120 -y 32
    place .sscFrame.sampleStopAfter   -in .sscFrame.sampleMode -x 40  -y 76
    place .sscFrame.burstMsg          -in .sscFrame.sampleMode -x 126 -y 58

    place .sscFrame.label             -in .sscFrame -x  4 -y   4
    place .sscFrame.sampleMode        -in .sscFrame -x  22 -y  32
    place .sscFrame.statusFrame       -in .sscFrame -x 230 -y  32
    place .sscFrame.ledFrame          -in .sscFrame -x  22 -y 160

    place .sscFrame    -in .theNoteBook.trueColorSensor.sFrame  -x 30  -y 16

    # ------------------------ Computed Values
    frame .derFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 318 -height 240 -background $ams_gray25
    label .derFrame.label -text "Computed Values " -font {system -8 bold} -bg $ams_gray25 -fg $ams_gray95

    frame .derFrame.cct_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.cct_label -text "CCT   " -justify left -font {TkMenuFont -14}
    label .derFrame.cct_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.cct_label .derFrame.cct_value -in .derFrame.cct_frame -side left

    frame .derFrame.duv_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.duv_label -text "Duv   " -justify left  -font {TkMenuFont -14}
    label .derFrame.duv_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.duv_label .derFrame.duv_value -in .derFrame.duv_frame -side left

    frame .derFrame.up_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.up_label -text "u'      " -justify left  -font {TkMenuFont -14}
    label .derFrame.up_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.up_label .derFrame.up_value -in .derFrame.up_frame -side left

    frame .derFrame.vp_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.vp_label -text "v'      " -justify left  -font {TkMenuFont -14}
    label .derFrame.vp_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.vp_label .derFrame.vp_value -in .derFrame.vp_frame -side left

    frame .derFrame.u_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.u_label -text "u       " -justify left  -font {TkMenuFont -14}
    label .derFrame.u_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.u_label .derFrame.u_value -in .derFrame.u_frame -side left

    frame .derFrame.v_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.v_label -text "v       " -justify left  -font {TkMenuFont -14}
    label .derFrame.v_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.v_label .derFrame.v_value -in .derFrame.v_frame -side left

    frame .derFrame.x_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.x_label -text "x      " -justify left  -font {TkMenuFont -14}
    label .derFrame.x_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.x_label .derFrame.x_value -in .derFrame.x_frame -side left

    frame .derFrame.y_frame -bd 2 -relief raised -padx 2 -pady 1
    label .derFrame.y_label -text "y      " -justify left  -font {TkMenuFont -14}
    label .derFrame.y_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 7 -anchor e
    pack .derFrame.y_label .derFrame.y_value -in .derFrame.y_frame -side left

    place .derFrame.label             -in .derFrame      -x   4 -y   4
    place .derFrame.cct_frame         -in .derFrame      -x  27 -y   32
    place .derFrame.duv_frame         -in .derFrame      -x 166 -y   32
    place .derFrame.up_frame          -in .derFrame      -x  27 -y   80
    place .derFrame.vp_frame          -in .derFrame      -x 166 -y   80
    place .derFrame.u_frame           -in .derFrame      -x  27 -y  128
    place .derFrame.v_frame           -in .derFrame      -x 166 -y  128
    place .derFrame.x_frame           -in .derFrame      -x  27 -y  176
    place .derFrame.y_frame           -in .derFrame      -x 166 -y  176

    place .derFrame    -in .theNoteBook.trueColorSensor.sFrame  -x 442 -y 16

    # ------------------------ Calibrated Sensor Data
    frame .csvFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 318 -height 140 -background $ams_gray25
    label .csvFrame.label -text "CIE 1931 Calibrated Sensor Metrics" -font {system -8 bold} \
        -bg $ams_gray25 -fg $ams_gray95

    frame .csvFrame.cs1_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs1_label -text "$CS1label" -justify left
    label .csvFrame.cs1_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs1_label .csvFrame.cs1_value -in .csvFrame.cs1_frame -side left

    frame .csvFrame.cs2_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs2_label -text "$CS2label" -justify left
    label .csvFrame.cs2_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs2_label .csvFrame.cs2_value -in .csvFrame.cs2_frame -side left

    frame .csvFrame.cs3_frame -bd 2 -relief raised -padx 2 -pady 1
    label .csvFrame.cs3_label -text "$CS3label" -justify left
    label .csvFrame.cs3_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs3_label .csvFrame.cs3_value -in .csvFrame.cs3_frame -side left

    frame .csvFrame.cs4_frame -bd 2 -relief raised -padx 1 -pady 1
    label .csvFrame.cs4_label -text "Lux" -justify left
    label .csvFrame.cs4_value -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -14 bold} -width 6 -anchor e
    pack .csvFrame.cs4_label .csvFrame.cs4_value -in .csvFrame.cs4_frame -side left

    place .csvFrame.label    -in .csvFrame  -x   4 -y 4
    place .csvFrame.cs1_frame -in .csvFrame -x   6 -y 38
    place .csvFrame.cs2_frame -in .csvFrame -x 110 -y 38
    place .csvFrame.cs3_frame -in .csvFrame -x 214 -y 38
    place .csvFrame.cs4_frame -in .csvFrame -x 110 -y 86

    place .csvFrame    -in .theNoteBook.trueColorSensor.sFrame  -x 442 -y 270

    # Set the widget list used to get samples
    set sampleWidgetNames "Sample, $CS1label, $CS2label, $CS3label, Lux, CCT, Duv, u', v', u, v, x, y, Timestamp"
    set lWidgets [list .csvFrame.cs1_value .csvFrame.cs2_value \
        .csvFrame.cs3_value .csvFrame.cs4_value \
        .derFrame.cct_value .derFrame.duv_value \
        .derFrame.up_value  .derFrame.vp_value  \
        .derFrame.u_value .derFrame.v_value \
        .derFrame.x_value .derFrame.y_value]
    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateText updateText updateText updateText \
        updateText updateText \
        updateText updateText \
        updateText updateText \
        updateText updateText ]
}

proc doSetFilterType {s} {
    global filterTypeSetting
    global filterTypeNum

    set filterTypeSetting $s
    if { $s == "High Pass FIR" } {
        .addFilterPopup.freq1L configure -text "Transition Frequency (Hz): "
        place forget .addFilterPopup.freq2F
        set filterTypeNum 1
    } elseif { $s == "Low  Pass FIR" } {
        .addFilterPopup.freq1L configure -text "Transition Frequency (Hz): "
        place forget .addFilterPopup.freq2F
        set filterTypeNum 3
    } else {
        .addFilterPopup.freq1L configure -text "Lower Frequency (Hz):       "
        .addFilterPopup.freq2E configure -state normal
        place .addFilterPopup.freq2F -in .addFilterPopup -x 10 -y 210
        set filterTypeNum 2
    }
}

proc doSetFilterTaps {P} {
    global numFilterTaps

    if { $P == "" } {
        return true
    }
    if { ![string is integer -strict $P] || ($P <= 0) } {
        tk_messageBox -icon info -message "Error in tap count." \
            -detail "The number of filter taps must be a positive integer." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .addFilterPopup
        raise .addFilterPopup
        return false
    } else {
        set numFilterTaps $P
        return true
    }
}

proc doSetFilterStage {P} {
    global filterStage

    if { $P == "" } {
        return true
    }
    if { ![string is integer -strict $P] || ($P <= 0) || ($P > 5) } {
        tk_messageBox -icon info -message "Error in filter stage." \
            -detail "The filter stage must be a positive integer in the range \[1..5\]." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .addFilterPopup
        raise .addFilterPopup
        return false
    } else {
        set filterStage $P
        return true
    }
}

proc doSetFilterFreq {P n} {
    global filterTypeSetting
    global filterFreq1
    global filterFreq2
    global sampleFreq

    if { $P == "" } {
        return true
    }

    # In case we need to print an error message:
    if { $filterTypeSetting == "Band Pass FIR"} {
        if { $n == 1 } {
            set freqType "lower"
        } else {
            set freqType "upper"
        }
    } else {
        set freqType "transition"
    }

    if { ![string is double $P] || ($P <= 0) } {
        tk_messageBox -icon info -message "Error in setting filter $freqType frequency." \
            -detail "The filter $freqType frequency must be positive." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .addFilterPopup
        raise .addFilterPopup
        return false
    } elseif { ![string is double $P] || ($P >= [expr $sampleFreq / 2]) } {
        set freq [format {%0.4f} $sampleFreq]
        tk_messageBox -icon info -message "Error in setting filter $freqType frequency." \
            -detail "The filter $freqType frequency must be no greater than half the sample frequency ($freq Hz)." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .addFilterPopup
        raise .addFilterPopup
        return false

    } else {
        if { $n == 1 } {
            set filterFreq1 $P
        } else {
            set filterFreq2 $P
        }
        return true
    }
}

proc doAddFilterStageFinalize {} {
    global filterTypeSetting
    global filterTypeNum
    global numFilterTaps
    global filterFreq1
    global filterFreq2
    global filterStage
    global numFilters

    global aFilterFreq1
    global aFilterFreq2
    global aFilterTaps
    global aFilterTypes
    global aFilterTypeNums
    global aFilterTextWidgets

    #    puts "Filter stage is $filterStage"
    #    puts "Filter type is $filterTypeSetting"
    #    puts "Number of taps is $numFilterTaps"
    #    puts "Filter frequency 1 is $filterFreq1"
    #    puts "Filter frequency 2 is $filterFreq2"
    #    puts "Filter type num is $filterTypeNum"

    if { ($filterStage == "") || ($numFilterTaps == "") || ($filterFreq1 == "") ||  \
            (($filterTypeSetting == "Band Pass FIR") && ($filterFreq2 == "")) } {
        tk_messageBox -icon info -message "Error in filter definition." \
            -detail "All filter attributes must be defined." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .addFilterPopup
        raise .addFilterPopup
        return
    }

    set aFilterFreq1($filterStage) $filterFreq1
    set aFilterFreq2($filterStage) $filterFreq2
    set aFilterTaps($filterStage)  $numFilterTaps
    set aFilterTypes($filterStage) $filterTypeSetting
    set aFilterTypeNums($filterStage) $filterTypeNum

    if {$filterTypeSetting == "Band Pass FIR"} {
        $aFilterTextWidgets($filterStage) configure -text \
            "Stage $filterStage:  $filterTypeSetting.  Taps=$numFilterTaps.  F1=$filterFreq1 and F2=$filterFreq2."
    } else {
        $aFilterTextWidgets($filterStage) configure -text \
            "Stage $filterStage:  $filterTypeSetting.  Taps=$numFilterTaps.  F1=$filterFreq1."
    }

    incr numFilters

    # Done with the popup
    destroy .addFilterPopup
}

proc doAddFilterStage {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global filterStage
    global numFilters
    global numFilterTaps
    global filterTypeSetting
    global filterFreq1
    global filterFreq2
    global filterTypeNum
    global sampleFreq

    # Reset our filter attribute variables
    set numFilterTaps ""
    set filterFreq1 ""
    set filterFreq2 ""
    set filterStage ""
    set filterTypeSetting ""

    toplevel .addFilterPopup -width 250 -height 300 -background $ams_gray25
    wm title .addFilterPopup "Add Filter Stage"

    frame .addFilterPopup.positionF -bd 3 -relief raised -padx 2 -pady 1
    label .addFilterPopup.positionL -text "Stage: " -justify left
    entry .addFilterPopup.positionE -validate key -width 8 -justify right -relief sunken \
        -vcmd [list doSetFilterStage %P ] -font {system -8 bold}
    pack .addFilterPopup.positionL .addFilterPopup.positionE -in .addFilterPopup.positionF -side left
    place .addFilterPopup.positionF -in .addFilterPopup -x 10 -y 10
    .addFilterPopup.positionE insert end [expr $numFilters + 1]

    frame .addFilterPopup.filterTypeF -bd 3 -relief raised -padx 2 -pady 1
    label .addFilterPopup.filterTypeL -text "Filter Type: " -justify left
    spinbox .addFilterPopup.filterType -validate key -state readonly -width 13 -bd 3 \
        -relief sunken -values {"High Pass FIR" "Band Pass FIR" "Low  Pass FIR"}  \
        -wrap 1 -command [list doSetFilterType %s]
    pack .addFilterPopup.filterTypeL .addFilterPopup.filterType -in .addFilterPopup.filterTypeF -side left
    place .addFilterPopup.filterTypeF  -in .addFilterPopup -x 10 -y 60
    set filterTypeSetting "High Pass FIR"
    set filterTypeNum 1

    frame .addFilterPopup.numTapsF -bd 3 -relief raised -padx 2 -pady 1
    label .addFilterPopup.numTapsL -text "Filter Taps: " -justify left
    entry .addFilterPopup.numTapsE -validate key -width 8 -justify right -relief sunken \
        -vcmd [list doSetFilterTaps %P ] -font {system -8 bold}
    pack .addFilterPopup.numTapsL .addFilterPopup.numTapsE -in .addFilterPopup.numTapsF -side left
    place .addFilterPopup.numTapsF -in .addFilterPopup -x 10 -y 110

    frame .addFilterPopup.freq1F -bd 3 -relief raised -padx 2 -pady 1
    label .addFilterPopup.freq1L -text "Transition Frequency (Hz): " -justify left
    entry .addFilterPopup.freq1E -validate key -width 8 -justify right -relief sunken \
        -vcmd [list doSetFilterFreq %P 1] -font {system -8 bold}
    pack .addFilterPopup.freq1L .addFilterPopup.freq1E -in .addFilterPopup.freq1F -side left
    place .addFilterPopup.freq1F -in .addFilterPopup -x 10 -y 160

    frame .addFilterPopup.freq2F -bd 3 -relief raised -padx 2 -pady 1
    label .addFilterPopup.freq2L -text "Upper Frequency (Hz):       " -justify left
    entry .addFilterPopup.freq2E -validate key -width 8 -justify right -relief sunken \
        -vcmd [list doSetFilterFreq %P 2] -font {system -8 bold} -state disabled
    pack .addFilterPopup.freq2L .addFilterPopup.freq2E -in .addFilterPopup.freq2F -side left
    # Note no place for the freq2 until the user selects "Band Pass FIR"

    button .addFilterPopup.add -text " Add " \
        -command {  doAddFilterStageFinalize } -relief raised -bd 2 -bg $ams_gray25 \
        -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .addFilterPopup.add     -in .addFilterPopup -x 180 -y 260

    set freq [format {%0.4f} $sampleFreq]
    label .addFilterPopup.sampleFreqL -text "Sample Freq: $freq Hz" -bg $ams_gray25 -fg $ams_gray95
    place .addFilterPopup.sampleFreqL -in .addFilterPopup -x 10 -y 260

    focus .addFilterPopup
    raise .addFilterPopup
}

proc doSetDelFilterStage {P} {
    global filterStage

    if { $P == "" } {
        return true
    }
    if { ![string is integer -strict $P] || ($P <= 0) || ($P > 5) } {
        tk_messageBox -icon info -message "Error in filter stage." \
            -detail "The filter stage must be a positive integer in the range \[1..5\]." \
            -title "ams Real-Time Filter Definition Error" -type ok
        focus .delFilterPopup
        raise .delFilterPopup
        return false
    } else {
        set filterStage $P
        return true
    }
}

proc doDelFilterStage {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global numFilters

    global aFilterFreq1
    global aFilterFreq2
    global aFilterTaps
    global aFilterTypes
    global aFilterTypeNums
    global aFilterTextWidgets

    if { $numFilters == 0 } {
        return
    }

    set aFilterFreq1($numFilters) ""
    set aFilterFreq2($numFilters) ""
    set aFilterTaps($numFilters)  ""
    set aFilterTypes($numFilters) ""
    set aFilterTypeNums($numFilters) ""

    $aFilterTextWidgets($numFilters) configure -text "Stage $numFilters: "

    set numFilters [expr $numFilters - 1]
}

proc doPulseRateParams {w s} {
    global pulseRateParams
    #    puts ""
    #    puts "In doPulseRateParams with w $w and s $s"

    switch -- $w {
        SW {
            set pulseRateParams [format "0x%08x" [expr [expr $pulseRateParams & 0xFFFFFF00] | $s]]
            if { [expr $s & 1] ==  0} {
                set maxpd [expr [expr $s - 1] >> 1]
            } else {
                set maxpd [expr $s >> 1]
            }
            #	    puts "maxpd=$maxpd"
            set pdv [.hrFrame.pFrame.pdSpinbox get]
            #	    puts "pdv=$pdv"
            set l {1 2 3 4 5 6 7 8 9 10 11 12}
            set l [lreplace $l $maxpd 11]
            #	    puts "l=$l"
            .hrFrame.pFrame.pdSpinbox configure -values $l
            if { ($pdv > $maxpd) } {
                #		puts "Changing pd to $maxpd"
                .hrFrame.pFrame.pdSpinbox set $maxpd
                set pulseRateParams [format "0x%08x" [expr [expr $pulseRateParams & 0xFFFF00FF] | \
                    [expr $maxpd << 8]]]
            } else {
                .hrFrame.pFrame.pdSpinbox set $pdv
            }
        }
        PD {
            set pulseRateParams [format "0x%08x" [expr [expr $pulseRateParams & 0xFFFF00FF] | \
                [expr $s << 8]]]
        }
        PA {
            set pulseRateParams [format "0x%08x" [expr [expr $pulseRateParams & 0xFF00FFFF] | \
                [expr $s << 16]]]
        }
    }
    #    puts "pulseRateParams = $pulseRateParams"
}

proc doPulseRateMeasure {} {
    global pulseRateParams
    global sampleTarget
    global responseIsError
    global lastnum
    global hrPending
    global vBursting
    global tcsMode

    #    .hrFrame.oFrame.qhrFrame.qhrValue configure -text "    "
    .hrFrame.oFrame.qhrFrame.txt delete 1.0 end
    .hrFrame.oFrame.qhrFrame.txt insert end "Quick Rates:\n"
    .hrFrame.oFrame.hrFrame.hrValue  configure -text "    "

    .hrFrame.oFrame.status configure -text "Processing..."

    # Read the current TCS mode
    doATcommand "ATTCSMD"
    if { $responseIsError == 0 } {
        set oldtcsmd $lastnum
        #	puts "TCS mode was $oldtcsmd"
    }

    doATcommand "ATTCSMD=5"
    set tcsMode 5

    # Set the special function parameters
    doATcommand "ATSF1=$pulseRateParams"

    # Turn on LED1.
    set led1val [.hrFrame.pFrame.led1Spinbox get]
    doLED1 "$led1val"

    # Start the pulse rate measurement
    set sampleTarget [expr [expr $pulseRateParams & 0x00FF0000] >> 16]
    #    puts "sampleTarget=$sampleTarget"
    set vBursting true
    doATcommand "ATBURST=$sampleTarget"
    #    puts "Started..."
    vwait hrPending
    after 3000 set hrPending false
    #    puts "Finished."
    set vBursting false

    # All done. Restore the previous device state.
    #    doATcommand "ATTCSMD=$oldtcsmd"
    doLED1 "OFF"
    doATcommand "ATTCSMD=$oldtcsmd"
    set tcsMode $oldtcsmd
    #    puts "TCS mode restored to $tcsMode"
    .hrFrame.oFrame.status configure -text ""
}

proc DoPulseRateDisplay {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red

    # ------------------------ Pulse Rate Processing
    frame .hrFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 740 -height 380 -background $ams_gray25
    label .hrFrame.label -text "Pulse Rate Computation" -font {system -8 bold} \
        -bg $ams_gray25 -fg $ams_gray95

    place .hrFrame.label             -in .hrFrame -x  4 -y   4
    place .hrFrame    -in .theNoteBook.hrProcessing.rFrame  -x 30  -y 16

    frame .hrFrame.pFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 300 -width 400
    label .hrFrame.pFrame.pLabel -text "Parameters" -bg $ams_gray25 -fg $ams_gray95 -font {system -8 bold}

    label .hrFrame.pFrame.swLabel -text "Sample Smoothing Window: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .hrFrame.pFrame.swSpinbox -values {4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25} \
        -wrap true -borderwidth 3 -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 3 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doPulseRateParams "SW" %s }
    .hrFrame.pFrame.swSpinbox set 20
    label .hrFrame.pFrame.swExplain -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "Moving Average Window (Max=25)"

    label .hrFrame.pFrame.pdLabel -text "R Peak Detection Shoulder:" -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .hrFrame.pFrame.pdSpinbox -values {1 2 3 4 5 6 7 8 9} \
        -wrap true -borderwidth 3 -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 3 -justify center -bg $ams_gray25 -fg $ams_gray95 -command {doPulseRateParams "PD" %s }
    .hrFrame.pFrame.pdSpinbox set 5
    label .hrFrame.pFrame.pdExplain -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "Values per side examined to find peaks (Max=1/2 Window)"

    label .hrFrame.pFrame.paLabel -text "R Peaks for Pulse Rate:" -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .hrFrame.pFrame.paSpinbox -wrap true -borderwidth 3 -font {system -12 bold} -exportselection true \
        -values {5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 \
		     36 37 38 39 40 41 42 43 44 45 46 47 48 49 50} \
        -state readonly 	-relief sunken -width 3 -justify center -bg $ams_gray25 -fg $ams_gray95 \
        -command {doPulseRateParams "PA" %s }
    .hrFrame.pFrame.paSpinbox set 50
    label .hrFrame.pFrame.paExplain -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "R peaks used to compute pulse rate (Max=50)"

    label .hrFrame.pFrame.led1label -text "LED Drive: " -justify left -bg $ams_gray25 -fg $ams_gray95
    spinbox .hrFrame.pFrame.led1Spinbox -values {12.5mA 25mA 50mA 100mA} -wrap true -borderwidth 3 \
        -font {system -12 bold} -exportselection true -state readonly \
        -relief sunken -width 6 -justify center -bg $ams_gray25 -fg $ams_gray95

    place .hrFrame.pFrame.pLabel      -in .hrFrame.pFrame   -x   4 -y  4

    place .hrFrame.pFrame.swLabel     -in .hrFrame.pFrame   -x  40 -y  40
    place .hrFrame.pFrame.swSpinbox   -in .hrFrame.pFrame   -x 200 -y  40
    place .hrFrame.pFrame.swExplain   -in .hrFrame.pFrame   -x  60 -y  65

    place .hrFrame.pFrame.pdLabel     -in .hrFrame.pFrame   -x  40 -y 115
    place .hrFrame.pFrame.pdSpinbox   -in .hrFrame.pFrame   -x 200 -y 115
    place .hrFrame.pFrame.pdExplain   -in .hrFrame.pFrame   -x  60 -y 140

    place .hrFrame.pFrame.paLabel     -in .hrFrame.pFrame   -x  40 -y 190
    place .hrFrame.pFrame.paSpinbox   -in .hrFrame.pFrame   -x 200 -y 190
    place .hrFrame.pFrame.paExplain   -in .hrFrame.pFrame   -x  60 -y 215

    place .hrFrame.pFrame.led1label   -in .hrFrame.pFrame   -x 130 -y 250
    place .hrFrame.pFrame.led1Spinbox -in .hrFrame.pFrame   -x 200 -y 250

    place .hrFrame.pFrame             -in .hrFrame   -x 20 -y 40

    frame .hrFrame.oFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 300 -width 245
    label .hrFrame.oFrame.oLabel -text "Control and Results" -bg $ams_gray25 -fg $ams_gray95 -font {system -8 bold}

    place .hrFrame.oFrame.oLabel      -in .hrFrame.oFrame   -x   4 -y  4
    place .hrFrame.oFrame             -in .hrFrame   -x 460 -y 40

    label .hrFrame.oFrame.s1Explain  -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "1)  Set integration time, "
    label .hrFrame.oFrame.s1Explain2 -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "     and position device."
    label .hrFrame.oFrame.s2Explain -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text "2)"
    button .hrFrame.oFrame.hrStart -text " Begin " \
        -command {  doPulseRateMeasure } -relief raised -bd 2 -bg $ams_gray25 \
        -fg $ams_gray95 -highlightbackground $ams_gray25
    label .hrFrame.oFrame.status -justify left -bg $ams_gray25 -fg $ams_gray95 \
        -text ""

    frame .hrFrame.oFrame.qhrFrame -relief raised -padx 2 -pady 2 -width 200 -height 40
    text  .hrFrame.oFrame.qhrFrame.txt -height 6 -width 15 -font {arial -12} -wrap word \
        -yscrollcommand { .hrFrame.oFrame.qhrFrame.sb set }
    bind .hrFrame.oFrame.qhrFrame.txt <KeyPress> break
    scrollbar .hrFrame.oFrame.qhrFrame.sb -orient vertical -command { .hrFrame.oFrame.qhrFrame.txt yview }
    pack .hrFrame.oFrame.qhrFrame.txt -in .hrFrame.oFrame.qhrFrame -side left -expand 1 -fill both
    pack .hrFrame.oFrame.qhrFrame.sb  -in .hrFrame.oFrame.qhrFrame -side right -expand 0 -fill y

    if { 1 } {
        .hrFrame.oFrame.qhrFrame.txt insert end "Quick Rates:\n"
    } else {
        # Show all available fonts
        set count 0
        set tabwidth 0
        foreach family [lsort -dictionary [font families]] {
            .hrFrame.oFrame.qhrFrame.txt tag configure f[incr count] -font [list $family 10]
            .hrFrame.oFrame.qhrFrame.txt insert end ${family}:\t {} \
                "Hello font\n" f$count
            set w [font measure [.hrFrame.oFrame.qhrFrame.txt cget -font] ${family}:]
            if {$w+5 > $tabwidth} {
                set tabwidth [expr {$w+5}]
                .hrFrame.oFrame.qhrFrame.txt configure -tabs $tabwidth
            }
        }
    }
    frame .hrFrame.oFrame.hrFrame -bd 2 -relief raised -padx 2 -pady 1
    label .hrFrame.oFrame.hrFrame.hrLabel -justify left -text "Pulse Rate:  "
    label .hrFrame.oFrame.hrFrame.hrValue -text "    " -justify right -bg $ams_gray25 -fg $ams_gray95 \
        -relief sunken -bd 3 -font {system -14 bold} -width 6 -anchor e
    pack .hrFrame.oFrame.hrFrame.hrLabel .hrFrame.oFrame.hrFrame.hrValue -in .hrFrame.oFrame.hrFrame -side left

    place .hrFrame.oFrame.s1Explain    -in .hrFrame.oFrame   -x  30 -y  30
    place .hrFrame.oFrame.s1Explain2   -in .hrFrame.oFrame   -x  30 -y  48
    place .hrFrame.oFrame.s2Explain    -in .hrFrame.oFrame   -x  30 -y  75
    place .hrFrame.oFrame.hrStart      -in .hrFrame.oFrame   -x  50 -y  75
    place .hrFrame.oFrame.status       -in .hrFrame.oFrame   -x 110 -y  78
    place .hrFrame.oFrame.hrFrame      -in .hrFrame.oFrame   -x  50 -y 125
    place .hrFrame.oFrame.qhrFrame     -in .hrFrame.oFrame   -x  50 -y 180
}

proc DoRealTimeDisplay {} {
    global vOverwrite
    global vLogging
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global aFilterTextWidgets

    # ------------------------ Real-Time Processing Control
    frame .rtFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 760 -height 390 -background $ams_gray25

    label .rtFrame.label -text "Real-Time Burst Mode Processing " -font {system -8 bold} \
        -bg $ams_gray25 -fg $ams_gray95

    place .rtFrame.label             -in .rtFrame -x  4 -y   4

    place .rtFrame    -in .theNoteBook.rtProcessing.rFrame  -x 30  -y 16

    button .rtAddFilterButton -text "        Add Filter Stage        " \
        -command {  doAddFilterStage } -relief raised -bd 2 -bg $ams_gray25 \
        -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .rtAddFilterButton    -in .rtFrame -x 60 -y 40

    button .rtDelFilterButton -text " Delete Last Filter Stage " \
        -command {  doDelFilterStage } -relief raised -bd 2 -bg $ams_gray25 \
        -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .rtDelFilterButton    -in .rtFrame -x 60 -y 80

    frame .rtFrame.stage1 -bd 3 -relief ridge -padx 2 -pady 2 \
        -width 400 -height 38 -background $ams_gray25
    label .rtFrame.stage1.lstage -text "Stage 1: " -font {system -7 bold} -bg $ams_gray25 -fg $ams_gray95
    place .rtFrame.stage1.lstage -in .rtFrame.stage1 -x 4 -y 2
    set aFilterTextWidgets(1) .rtFrame.stage1.lstage

    frame .rtFrame.stage2 -bd 3 -relief ridge -padx 2 -pady 2 \
        -width 400 -height 38 -background $ams_gray25
    label .rtFrame.stage2.lstage -text "Stage 2: " -font {system -7 bold} -bg $ams_gray25 -fg $ams_gray95
    place .rtFrame.stage2.lstage -in .rtFrame.stage2 -x 4 -y 2
    set aFilterTextWidgets(2) .rtFrame.stage2.lstage

    frame .rtFrame.stage3 -bd 3 -relief ridge -padx 2 -pady 2 \
        -width 400 -height 38 -background $ams_gray25
    label .rtFrame.stage3.lstage -text "Stage 3: " -font {system -7 bold} -bg $ams_gray25 -fg $ams_gray95
    place .rtFrame.stage3.lstage -in .rtFrame.stage3 -x 4 -y 2
    set aFilterTextWidgets(3) .rtFrame.stage3.lstage

    frame .rtFrame.stage4 -bd 3 -relief ridge -padx 2 -pady 2 \
        -width 400 -height 38 -background $ams_gray25
    label .rtFrame.stage4.lstage -text "Stage 4: " -font {system -7 bold} -bg $ams_gray25 -fg $ams_gray95
    place .rtFrame.stage4.lstage -in .rtFrame.stage4 -x 4 -y 2
    set aFilterTextWidgets(4) .rtFrame.stage4.lstage

    frame .rtFrame.stage5 -bd 3 -relief ridge -padx 2 -pady 2 \
        -width 400 -height 38 -background $ams_gray25
    label .rtFrame.stage5.lstage -text "Stage 5: " -font {system -7 bold} -bg $ams_gray25 -fg $ams_gray95
    place .rtFrame.stage5.lstage -in .rtFrame.stage5 -x 4 -y 2
    set aFilterTextWidgets(5) .rtFrame.stage5.lstage

    place .rtFrame.stage1 -in .rtFrame -x 330 -y 60
    place .rtFrame.stage2 -in .rtFrame -x 330 -y 120
    place .rtFrame.stage3 -in .rtFrame -x 330 -y 180
    place .rtFrame.stage4 -in .rtFrame -x 330 -y 240
    place .rtFrame.stage5 -in .rtFrame -x 330 -y 300

    # Provide some explanatory text...
    label .rtFrame.lUsage1 -bg $ams_gray25 -fg $ams_gray95 \
        -text "Real-time processing requires an open log file."
    label .rtFrame.lUsage2 -bg $ams_gray25 -fg $ams_gray95 \
        -text "Raw data is fed into the top of the filter cascade."
    label .rtFrame.lUsage3 -bg $ams_gray25 -fg $ams_gray95 \
        -text "The final filter stage output is then captured"
    label .rtFrame.lUsage4 -bg $ams_gray25 -fg $ams_gray95 \
        -text "to the open log file."

    label .rtFrame.lUsage5 -bg $ams_gray25 -fg $ams_gray95 \
        -text "First define the filters, and then open the log file."
    label .rtFrame.lUsage6 -bg $ams_gray25 -fg $ams_gray95 \
        -text "Finally, start processing on the Spectral Sensor tab."

    place .rtFrame.lUsage1 -in .rtFrame -x 30 -y 160
    place .rtFrame.lUsage2 -in .rtFrame -x 30 -y 180
    place .rtFrame.lUsage3 -in .rtFrame -x 30 -y 200
    place .rtFrame.lUsage4 -in .rtFrame -x 30 -y 220
    place .rtFrame.lUsage5 -in .rtFrame -x 30 -y 260
    place .rtFrame.lUsage6 -in .rtFrame -x 30 -y 280

}

proc errorExeCmdFile { errmsg } {
    global cmdFileName

    tk_messageBox -icon error -message "Unable to execute:\n $cmdFileName" \
        -detail "Execution error:\n$errmsg." \
        -title "ams Cmd File Playback Failure" -type ok
}

proc doExeCmdFile {} {
    global vPlayingback
    global cmdFile
    global cmdFileName
    global autoRunning

    if { $autoRunning } {
        tk_messageBox -icon error  \
            -detail "Please stop continuous sampling prior to launching command file playback." \
            -message "Command file playback error." -title "ams User Error" -type ok
        return
    }

    # Set the global and disable the button until the playback completes
    if { $vPlayingback == false } {
        set vPlayingback true
        .consoleCmdExeButton configure -state disabled

        # check command file type
        set tclCmd ""
        if { ! [string match "*.tcl" $cmdFileName] } {
            # process AT command file
            # Begin reading lines from the cmd file and executing them until done.
            while { [gets $cmdFile cmdLine] >= 0 } {
                if { $cmdLine != "" } {
                    # check for AT command
                    if { [string first "AT" [string toupper [string trimleft $cmdLine]]] == 0 } {
                        # process AT command
                        # check if a tcl script was saved yet
                        if { $tclCmd != "" } {
                            # tcl script was saved - process it
                            if {[catch {eval $tclCmd} errmsg]} {
                                errorExeCmdFile $errmsg
                            }
                            set tclCmd ""
                        }
                        # process AT command
                        doATcommand $cmdLine
                    } else {
                        # process tcl command
                        append tclCmd "$cmdLine\n"
                    }
                    # Add a 5 second wait between commands temporarily...
                    #	    set vw 0
                    #	    after 5000 set vw 1
                    #	    vwait vw
                }
            }
            # check if a tcl script was saved yet
            if { $tclCmd != "" } {
                # tcl script was saved - process it
                if {[catch {eval $tclCmd} errmsg]} {
                    errorExeCmdFile $errmsg
                }
                set tclCmd ""
            }
        } else {
            # process tcl file
            if {[catch {source $cmdFileName} errmsg]} {
                errorExeCmdFile $errmsg
            }
        }
        # Position the file pointer at the beginning again.
        seek $cmdFile 0
        .consoleCmdExeButton configure -state normal
        set vPlayingback false
    }
}

proc doOpenCmdFile {} {
    global cmdCaptureFileTypes
    global cmdPlaybackFileTypes
    global cmdFileName
    global cmdFile
    global vCmdCapture
    global vCmdPlayback
    global hwModel
    global bCmdModeCapture
    global autoRunning

    if { $autoRunning } {
        tk_messageBox -icon error  \
            -detail "Please stop continuous sampling prior to opening a command file." \
            -message "Command file open error." -title "ams User Error" -type ok
        return
    }

    if { ($vCmdCapture == false) && ($vCmdPlayback == false) } {
        if { $bCmdModeCapture } {
            set cmdFileName [tk_getSaveFile -title "Select Cmd Capture File" \
                -filetypes $cmdCaptureFileTypes -parent .]
        } else {
            set cmdFileName [tk_getOpenFile -title "Select Cmd Playback File" \
                -filetypes $cmdPlaybackFileTypes -parent .]
        }
        if { $cmdFileName != ""} {
            # Append the .cmd if it's not already there.
            if { $bCmdModeCapture || ! [string match "*.tcl" $cmdFileName] } {
                if { ! [string match "*.cmd" $cmdFileName] } {
                    set cmdFileName "$cmdFileName.cmd"
                }
            }
            if { $bCmdModeCapture } {
                if { [catch {open $cmdFileName w} cmdFile] } {
                    tk_messageBox -icon error -message "Unable to open $cmdFileName" \
                        -detail "Please check that you may open $cmdFileName for writing." \
                        -title "ams Cmd File Capture Open Failure" -type ok
                    return
                }
                set vCmdCapture true
            } else {
                if { [catch {open $cmdFileName r} cmdFile] } {
                    tk_messageBox -icon error -message "Unable to open $cmdFileName" \
                        -detail "Please check $cmdFileName exists and is readable." \
                        -title "ams Cmd File Execution Open Failure" -type ok
                    return
                }
                fconfigure $cmdFile -buffering line
                set vCmdPlayback true
                .consoleCmdExeButton configure -state normal
            }
            .consoleCmdFileNameL configure -text $cmdFileName
            .consoleCmdFileButton configure -text "Close Cmd File"
        } else {
            set vCmdCapture false
            set vCmdPlayback false
            .consoleCmdFileNameL configure -text "<none>"
            .consoleCmdFileButton configure -text "Open Cmd File "
        }
    } else {
        # Time to close the file.
        set vCmdCapture false
        set vCmdPlayback false
        .consoleCmdFileNameL configure -text "<none>"
        .consoleCmdFileButton configure -text "Open Cmd File "
        if { $bCmdModeCapture } {
            flush $cmdFile
        } else {
            .consoleCmdExeButton configure -state disabled
        }
        close $cmdFile
        set cmdFile ""
        set cmdFileName ""
    }
}

# Open/close command logging file
proc doOpenCmdLogFile {} {
    global cmdLogging
    global cmdLogFileTypes
    global cmdLogFileName
    global cmdLogFile

    if { $cmdLogging == false } {
        set cmdLogFileName [tk_getSaveFile -title "Select Cmd Log File" -filetypes $cmdLogFileTypes -parent .]
        if { $cmdLogFileName != ""} {
            if { ! [string match "*.txt" $cmdLogFileName] } {
                set cmdLogFileName "$cmdLogFileName.txt"
            }
            .consoleCmdLogFileNameL configure -text $cmdLogFileName
            .consoleCmdLogFileButton configure -text "Close Cmd Log"
            set cmdLogFile [open $cmdLogFileName w]
            set cmdLogging true
            puts $cmdLogFile "# Command Log File"
        }
    } else {
        .consoleCmdLogFileNameL configure -text "<none>"
        .consoleCmdLogFileButton configure -text "Open Cmd Log"
        set cmdLogging false
        flush $cmdLogFile
        close $cmdLogFile
        set cmdLogFile ""
    }
}

# Show and log commmand
proc showAndLogCmd { cmd } {
    global quietMode
    global cmdLogging
    global cmdLogFile

    # puts "Log cmd: $cmd"
    
    if { $quietMode == 0 } {
        .consoleTextFrame.txt insert end "$cmd"
        .consoleTextFrame.txt see end
        .consoleTextFrame.txt yview moveto 1
    }
    if { $cmdLogging } {
        puts -nonewline $cmdLogFile "$cmd"
    }

}

proc doClearConsole {} {
    global updateConsole
    
    .consoleTextFrame.txt delete 1.0 end
    set updateConsole false    
}

proc doConsoleBuffer { cmd } {
    global entryNewlines
    global consoleEntryBuffer
    global consoleEntryIndex

    switch -- $cmd {
        Return {
            set newATcommand [string trim [.consoleEntryFrame.txt get 1.0 1.end]]
            if { $newATcommand != "" } {
                set cmdIndex [lsearch -exact $consoleEntryBuffer $newATcommand]
                if { $cmdIndex >= 0 } {
                    set consoleEntryBuffer [lreplace $consoleEntryBuffer $cmdIndex $cmdIndex]                    
                }
                lappend consoleEntryBuffer $newATcommand
                set consoleEntryIndex -1
                # puts "console buffer: $consoleEntryBuffer"
            }
            incr entryNewlines            
        }
        Key-Up {
            if { ($consoleEntryBuffer != "") && ($consoleEntryIndex != 0) } {
                if { $consoleEntryIndex < 0 } {
                    set consoleEntryIndex [llength $consoleEntryBuffer]
                }
                incr consoleEntryIndex -1
                .consoleEntryFrame.txt delete 1.0 end
                .consoleEntryFrame.txt insert end [lindex $consoleEntryBuffer $consoleEntryIndex]
                .consoleEntryFrame.txt see end
            }
        }
        Key-Down {
            if { ($consoleEntryBuffer != "") && ($consoleEntryIndex >= 0) && ($consoleEntryIndex < [llength $consoleEntryBuffer]) } {
                incr consoleEntryIndex
                .consoleEntryFrame.txt delete 1.0 end
                if { $consoleEntryIndex < [llength $consoleEntryBuffer] } {
                    .consoleEntryFrame.txt insert end [lindex $consoleEntryBuffer $consoleEntryIndex]
                }
                .consoleEntryFrame.txt see end
            }
        }
    }
}

proc DoConsoleDisplay {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global newlineChar
    global manualATcommand
    global bCmdModeCapture
    global consoleExists

    # ------------------------ Cmd Log File name/status
    labelframe .consoleCmdLogFileLF -text "Cmd Log File" -font {system -9 bold} -width 500 -height 48 \
        -fg $ams_gray95 -bg $ams_gray10 -relief groove -bd 3
    label .consoleCmdLogFileNameL -text "<none>" -width 81 -justify left \
        -font "-family helvetica -size 10 -slant italic"
    pack  .consoleCmdLogFileNameL -in .consoleCmdLogFileLF -expand 1 -fill x
    place .consoleCmdLogFileLF     -in .theNoteBook.console.cFrame  -x 20  -y  8

    # ------------------------ Cmd File name/status
    labelframe .consoleCmdFileLF -text "Cmd File" -font {system -9 bold} -width 500 -height 48 \
        -fg $ams_gray95 -bg $ams_gray10 -relief groove -bd 3
    label .consoleCmdFileNameL -text "<none>" -width 81 -justify left \
        -font "-family helvetica -size 10 -slant italic"
    pack  .consoleCmdFileNameL -in .consoleCmdFileLF -expand 1 -fill x
    place .consoleCmdFileLF     -in .theNoteBook.console.cFrame  -x 20  -y  56

    # ------------------------ AT Command Entry
    frame .consoleEntryFrame -bd 2 -relief raised -padx 2 -pady 1 -width 660 -height 32
    label .consoleEntryFrame.l -text "AT Command:" -justify left -font {system -10 bold}
    text .consoleEntryFrame.txt -width 76 -height 9 -relief sunken -padx 0 -pady 0 -bd 1
    bind .consoleEntryFrame.txt <Return> { doConsoleBuffer Return; break }
    bind .consoleEntryFrame.txt <Key-Up> { doConsoleBuffer Key-Up; break }
    bind .consoleEntryFrame.txt <Key-Down> { doConsoleBuffer Key-Down; break }

    place .consoleEntryFrame.l   -in .consoleEntryFrame  -x   0 -y  4
    place .consoleEntryFrame.txt -in .consoleEntryFrame  -x 104 -y  0
    place .consoleEntryFrame   -in .theNoteBook.console.cFrame  -x 20 -y 104
    set consoleExists 1

    # ------------------------ Text Output
    frame .consoleTextFrame -relief raised -padx 2 -pady 2 -width 650 -height 310
    text .consoleTextFrame.txt -wrap word -yscrollcommand { .consoleTextFrame.sb set }
    # text .consoleTextFrame.txt -wrap word -yscrollcommand { .consoleTextFrame.sb set } -insertofftime 0
    bind .consoleTextFrame.txt <KeyPress> break
    bind .consoleTextFrame.txt <Control-c> continue
    bind .consoleTextFrame.txt <Key-Left> continue
    bind .consoleTextFrame.txt <Key-Right> continue
    bind .consoleTextFrame.txt <Key-Up> continue
    bind .consoleTextFrame.txt <Key-Down> continue
    bind .consoleTextFrame.txt <Key-Prior> continue
    bind .consoleTextFrame.txt <Key-Next> continue
    bind .consoleTextFrame.txt <Key-Home> continue
    bind .consoleTextFrame.txt <Key-End> continue

    scrollbar .consoleTextFrame.sb -orient vertical -command { .consoleTextFrame.txt yview }
    pack .consoleTextFrame.txt -in .consoleTextFrame -side left -expand 1 -fill both
    pack .consoleTextFrame.sb  -in .consoleTextFrame -side right -expand 0 -fill y

    place .consoleTextFrame    -in .theNoteBook.console.cFrame  -x 20 -y 138 -height 264

    # ------------------------ Right side controls
    # ------------------------ Button Log File
    button .consoleCmdLogFileButton -text "Open Cmd Log" \
        -command { doOpenCmdLogFile } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .consoleCmdLogFileButton      -in .theNoteBook.console.cFrame -x 694 -y 18

    # ------------------------ Button Cmd File
    labelframe .consoleCmdModeLF -text "Cmd Mode" -font {-size 9 -weight bold} -width 90 -height 80 \
        -fg $ams_gray95 -bg $ams_gray10 -relief groove

    radiobutton .consoleCmdCapture   -text "Capture"   -variable bCmdModeCapture -value 1 \
        -bg $ams_gray10 -fg $ams_gray95
    radiobutton .consoleCmdPlayback   -text "Playback"   -variable bCmdModeCapture -value 0 \
        -bg $ams_gray10 -fg $ams_gray95
    place .consoleCmdCapture    -in .consoleCmdModeLF -x 4 -y 4
    place .consoleCmdPlayback   -in .consoleCmdModeLF -x 4 -y 30
    place .consoleCmdModeLF -in .theNoteBook.console.cFrame -x 694 -y 56

    button .consoleCmdFileButton -text "Open Cmd File " \
        -command { doOpenCmdFile } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .consoleCmdFileButton    -in .theNoteBook.console.cFrame -x 694 -y 146

    button .consoleCmdExeButton -text "Playback" \
        -command { doExeCmdFile } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold} -state disabled
    place .consoleCmdExeButton    -in .theNoteBook.console.cFrame -x 710 -y 182

    # ------------------------ Button Clear Output
    set clearCmd ""
    button .consoleClearButton -text "  Clear Output  " \
        -command doClearConsole \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 9 -weight bold}
    place .consoleClearButton    -in .theNoteBook.console.cFrame -x 694 -y 378

}

proc doUpdateStatistics {} {
    global hwModel
    global responseIsError
    global lastline
    global passwordLastSetTime
    global statsLastUpdate
    global autoRunning

    if { $autoRunning } {
        tk_messageBox -icon error  \
            -detail "Please stop continuous sampling prior to updating the statistics display." \
            -message "Time update error." -title "ams User Error" -type ok
        return
    }

    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to read logged statistics data." \
            -message "Error updating statistics." \
            -title "ams Access Error" -type ok
        return
    }
    set statsLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    .statsFrame.updateTimeL configure -text "$statsLastUpdate"

    # Update the hour labels.
    set h [clock format [clock seconds] -format "%k"]
    for {set i 0} {$i <=23} {incr i} {
        if { $h == 0 } {
            set tx "12a"
        } elseif { $h < 10 } {
            set tx ""
            append tx " $h" "a"
        } elseif { $h < 12 } {
            set tx ""
            append tx "$h" "a"
        } elseif { $h == 12 } {
            set tx "12p"
        } elseif { $h < 22 } {
            set ti [expr $h - 12]
            set tx ""
            append tx " $ti" "p"
        } elseif { $h <= 23 } {
            set ti [expr $h - 12]
            set tx ""
            append tx "$ti" "p"
        }
        if { $h == 0 } {
            set h 23
        } else {
            set h [expr $h - 1]
        }
        .statsFrame.hour$i configure -text "$tx"
    }

    # Initialize our local result holders.
    array set dump {}
    set dump(0) ""
    set dump(1) ""
    set dump(2) ""
    set dump(3) ""
    set dump(4) ""
    set dump(5) ""
    set dump(6) ""

    set r 0
    if { $hwModel == 21 } {
        doATcommand "ATDCCT"
        if { $responseIsError == 0 } {
            set dump($r) [string trimright $lastline "OK"]
        }
        incr r
    }
    # Read the LUX target data.
    doATcommand "ATDLUX"
    if { $responseIsError == 0 } {
        set dump($r) [string trimright $lastline "OK"]
    }
    incr r
    doATcommand "ATDLUXC"
    if { $responseIsError == 0 } {
        set dump($r) [string trimright $lastline "OK"]
    }
    incr r
    doATcommand "ATDPWR"
    if { $responseIsError == 0 } {
        set dump($r) [string trimright $lastline "OK"]
    }
    incr r
    doATcommand "ATDTEMP"
    if { $responseIsError == 0 } {
        set dump($r) [string trimright $lastline "OK"]
    }
    incr r
    doATcommand "ATDPRES"
    if { $responseIsError == 0 } {
        set dump($r) [string trimright $lastline "OK"]
    }

    # Update the value labels.
    for {set r 0} {$r <=5} {incr r} {
        if { ($hwModel == 11) && ($r >= 5) } {
            break
        }
        #	puts "dump($r): $dump($r)"
        if { $dump($r) != "" } {
            set values [regexp -all -inline {\S+} $dump($r)]
            #	    puts "values: $values"
            set i 0
            foreach v $values {
                .statsFrame.val$r$i configure -text "$v"
                incr i
                if { $i > 23 } {
                    break ;
                }
            }
        } else {
            # No result.  Clear the values for this row.
            for {set i 0} {$i <=23} {incr i} {
                .statsFrame.val$r$i configure -text ""
            }
        }
    }
    # Scroll the output frame

}

proc DoStatisticsDisplay {} {
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global ams_viola
    global ams_green
    global responseIsError
    global lastnum
    global passwordLastSetTime
    global statsLastUpdate

    # ------------------------ Statistics Output tab
    frame .statsFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 390 -width 760
    place .statsFrame -in .theNoteBook.stats.sFrame -x 20 -y 16

    button .statsFrame.updateButton -text " Update " -command { doUpdateStatistics } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    place .statsFrame.updateButton -in .statsFrame -x 680 -y 18

    label .statsFrame.lastUpdateL  -text "Last Update: " -fg $ams_gray95 -bg $ams_gray25
    #    set statsLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .statsFrame.updateTimeL -text "$statsLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    place .statsFrame.lastUpdateL  -in .statsFrame -x 625 -y 48
    place .statsFrame.updateTimeL  -in .statsFrame -x 695 -y 48

    # Page headers
    label .statsFrame.timeHdrL  -text "Hourly Averages" \
        -font {-family systemfixed -size 12 -weight bold} -fg $ams_gray95 -bg $ams_gray25
    place .statsFrame.timeHdrL     -in .statsFrame -x 320 -y 24
    label .statsFrame.timeSubhdrL  -text "Most Recent" -fg $ams_gray95 -bg $ams_gray25
    place .statsFrame.timeSubhdrL -in .statsFrame -x 90  -y 48

    # Create the hour column labels and the value holders.
    set h [clock format [clock seconds] -format "%k"]
    for {set i 0} {$i <= 23} {incr i} {
        if { $h == 0 } {
            set tx "12a"
        } elseif { $h < 10 } {
            set tx ""
            append tx " $h" "a"
        } elseif { $h < 12 } {
            set tx ""
            append tx "$h" "a"
        } elseif { $h == 12 } {
            set tx "12p"
        } elseif { $h < 22 } {
            set ti [expr $h - 12]
            set tx ""
            append tx " $ti" "p"
        } elseif { $h <= 23 } {
            set ti [expr $h - 12]
            set tx ""
            append tx "$ti" "p"
        }
        if { $h == 0 } {
            set h 23
        } else {
            set h [expr $h - 1]
        }

        label .statsFrame.hour$i -text "$tx" -font {-family systemfixed -size 9 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        place .statsFrame.hour$i  -in .statsFrame -x [expr 90 + [expr $i * 27]] -y 72

        # Do a column's worth of display holders
        for {set r 0} {$r <=6} {incr r} {
            if { ($hwModel == 11) && ($r >= 5) } {
                break ;
            }
            label .statsFrame.val$r$i  -text "" -font {courier -10} \
                -fg $ams_gray95 -bg $ams_gray25
            place .statsFrame.val$r$i -in .statsFrame -x [expr 90 + [expr $i * 27]] \
                -y [expr 115 + [expr $r * 40]]
        }
    }

    # Row titles
    label .statsFrame.luxTargetL  -text "Lux Target" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .statsFrame.luxCalL  -text "Measured Lux" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .statsFrame.pwrL  -text "Power %" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .statsFrame.tempL  -text "Temperature" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .statsFrame.presenceL  -text "Presence" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25

    if { $hwModel == 21 } {
        # Add CCT for the AS7221
        label .statsFrame.cctCalL  -text "Measured CCT" -font {-family systemfixed -size 9 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        place .statsFrame.cctCalL      -in .statsFrame  -x   4 -y 112
        place .statsFrame.luxTargetL   -in .statsFrame  -x   4 -y 152
        place .statsFrame.luxCalL      -in .statsFrame  -x   4 -y 192
        place .statsFrame.pwrL         -in .statsFrame  -x   4 -y 232
        place .statsFrame.tempL        -in .statsFrame  -x   4 -y 272
        place .statsFrame.presenceL    -in .statsFrame  -x   4 -y 312
    } elseif { $hwModel == 11 } {
        # AS7211
        place .statsFrame.luxTargetL   -in .statsFrame  -x   4 -y 112
        place .statsFrame.luxCalL      -in .statsFrame  -x   4 -y 152
        place .statsFrame.pwrL         -in .statsFrame  -x   4 -y 192
        place .statsFrame.tempL        -in .statsFrame  -x   4 -y 232
        place .statsFrame.presenceL    -in .statsFrame  -x   4 -y 272
    }

}

proc doSceneEnableSelect {n} {
    global passwordLastSetTime
    global bSceneEnable

    # Which scene was enabled or disabled?
    #    puts "Scene $n enable is $bSceneEnable($n)"
    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene enable." \
            -title "ams Entry Error" -type ok
    } else {
        # Mark the scene as ready for update.
        .scenesFrame.incUpdateSel$n  configure -state normal
    }
}

proc doSetSceneStartTime {P n} {
    global passwordLastSetTime
    global sceneStartTime
    global sceneStartTimeInt
    global bSceneEnable
    #    puts "doSetSceneStartTime P: $P n: $n"

    if { $passwordLastSetTime > 0 } {
        # Look for one or two numerals leading a ':' and
        # followed by two numerals.  If no trailing am or pm, assume
        # 24-hour style time.
        set hr ""
        set mn ""
        set ampm ""
        if { [string match {[0-9]:[0-5][0-9]} $P] } {
            # Something of the form "8:17" has been entered.
            set hr [string range $P 0 0]
            set mn [string range $P 2 3]
        } elseif { [string match {[0-2][0-9]:[0-5][0-9]} $P] } {
            # Something of the form "22:17" has been entered.
            set hr [string range $P 0 1]
            set mn [string range $P 3 4]
        } elseif { [string match {[0-9]:[0-5][0-9][aApP][mM]} $P] } {
            # Something of the form "8:17am" has been entered.
            set hr [string range $P 0 0]
            set mn [string range $P 2 3]
            set ampm [string range $P 4 4]
        } elseif { [string match {[0-9]:[0-5][0-9] [aApP][mM]} $P] } {
            # Something of the form "8:17 am" has been entered.
            set hr [string range $P 0 0]
            set mn [string range $P 2 3]
            set ampm [string range $P 5 5]
        } elseif { [string match {[0-1][0-9]:[0-5][0-9][aApP][mM]} $P] } {
            # Something of the form "10:17am" has been entered.
            set hr [string range $P 0 1]
            set mn [string range $P 3 4]
            set ampm [string range $P 5 5]
        } elseif { [string match {[0-1][0-9]:[0-5][0-9] [aApP][mM]} $P] } {
            # Something of the form "10:17 am" has been entered.
            set hr [string range $P 0 1]
            set mn [string range $P 3 4]
            set ampm [string range $P 6 6]
        }
        #	puts "N: $n  HR: $hr  MN:  $mn  AMPM: $ampm"
        # Remove leading zeros before doing the arithmetic
        regsub {^[0]} $hr {\1} hr
        regsub {^[0]} $mn {\1} mn
        #	puts "N: $n  HR: $hr  MN:  $mn  AMPM: $ampm"

        if { $hr != "" } {
            # Then we think we have a complete time value ready to set.
            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal
            if { ($ampm == "p") || ($ampm == "P") } {
                if { $hr == 12 } {
                    set sceneStartTimeInt($n) [expr 720 + $mn]
                } else {
                    set sceneStartTimeInt($n) [expr [expr [expr $hr + 12] * 60] + $mn]
                }
            } else {
                if { $ampm == "" } {
                    # Assume 24-hour time format
                    set sceneStartTimeInt($n) [expr [expr $hr * 60] + $mn]
                } else {
                    # We have "am"
                    if { $hr == 12 } {
                        set sceneStartTimeInt($n) $mn
                    } else {
                        set sceneStartTimeInt($n) [expr [expr $hr * 60] + $mn]
                    }
                }
            }
        } else {
            set sceneStartTimeInt($n) ""
        }
        #	puts "Time: $sceneStartTimeInt($n)"
        return true
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene start time." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneDaysSelect {n d} {
    global passwordLastSetTime
    global sceneDays
    global sceneDaysAll

    if { $passwordLastSetTime > 0 } {
        if { $sceneDays($n,$d) == 0 } {
            set sceneDaysAll($n) 0
        }
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene active days." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneDaysSelectAll {n} {
    global passwordLastSetTime
    global sceneDays
    global sceneDaysAll

    if { $passwordLastSetTime > 0 } {
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
        if { $sceneDaysAll($n) } {
            # Set all the days of the week
            for {set j 0} {$j <= 6} {incr j} {
                set sceneDays($n,$j) 1
            }
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene (all) active days." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneIncludeUpdateSelectAll {} {
    global passwordLastSetTime
    global bSceneIncludeUpdateSelectAll
    global bSceneIncludeUpdateSelect

    if { $passwordLastSetTime > 0 } {
        if { $bSceneIncludeUpdateSelectAll } {
            for {set j 0} {$j <= 15} {incr j} {
                if { [.scenesFrame.incUpdateSel$j cget -state] == "normal" } {
                    set bSceneIncludeUpdateSelect($j) 1
                }
            }
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene (all) update flags." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneIncludeUpdateSelect {n} {
    global passwordLastSetTime
    global bSceneIncludeUpdateSelectAll
    global bSceneIncludeUpdateSelect

    if { $passwordLastSetTime > 0 } {
        if { $bSceneIncludeUpdateSelect($n) == 0 } {
            set bSceneIncludeUpdateSelectAll 0
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene update flags." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneIncludeClearSelectAll {} {
    global passwordLastSetTime
    global bSceneIncludeClearSelectAll
    global bSceneIncludeClearSelect

    if { $passwordLastSetTime > 0 } {
        if { $bSceneIncludeClearSelectAll } {
            for {set j 0} {$j <= 15} {incr j} {
                set bSceneIncludeClearSelect($j) 1
            }
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene (all) clear flags." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneIncludeClearSelect {n} {
    global passwordLastSetTime
    global bSceneIncludeClearSelectAll
    global bSceneIncludeClearSelect

    if { $passwordLastSetTime > 0 } {
        if { $bSceneIncludeClearSelect($n) == 0 } {
            set bSceneIncludeClearSelectAll 0
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error selecting scene clear flags." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetSceneLuxTarget {P n e} {
    global passwordLastSetTime
    global scenePercentOutput
    global sceneLuxTarget
    global bSceneDlEnable

    #    puts "doSetSceneLuxTarget P: $P n: $n"
    #    puts -nonewline "sceneLuxTarget($n) validate: "
    #    puts [.scenesFrame.targetLuxE$n cget -validate]

    if { $e == 0 } {
        # Not editing the widget, so force the change in the value.
        .scenesFrame.targetLuxE$n delete 0 end
        .scenesFrame.targetLuxE$n insert 0 $P
    }

    #    puts -nonewline "  sceneLuxTarget($n) validate: "
    #    puts [.scenesFrame.targetLuxE$n cget -validate]

    if { $passwordLastSetTime > 0 } {
        # Do we have a bad value?
        if { $P == "" } {
            # Empty is okay.
            set sceneLuxTarget($n) ""
            return true ;
        }
        if { ![string is integer -strict $P] || ($P < 0) || ($P > 64000) } {
            tk_messageBox -icon error -detail "Target Lux must be in the range from 0 to 64000." \
                -message "Error setting scene lux target." \
                -title "ams Entry Error" -type ok
            return false
        } else {
            # Good value.
            set sceneLuxTarget($n) $P

            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal

            # If we are in DL mode in this scene, we should
            # clear the corresponding percent output.
            if { $bSceneDlEnable($n) != 0 } {
                doSetScenePercentOutput "" $n 0
            }
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene lux target." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetScenePercentOutput {P n e} {
    global passwordLastSetTime
    global scenePercentOutput
    global bSceneDlEnable
    global sceneLuxTarget

    #    puts "doSetScenePercentOutput P: $P  n: $n"

    if { $e == 0 } {
        # Not editing the widget, so force the change in the value.
        .scenesFrame.percentOutE$n delete 0 end
        .scenesFrame.percentOutE$n insert 0 $P
    }

    if { $passwordLastSetTime > 0 } {
        # Do we have a bad value?
        if { $P == "" } {
            # Empty is okay.
            set scenePercentOutput($n) ""
            return true ;
        }
        if { ![string is integer -strict $P] || ($P < 0) || ($P > 100) } {
            tk_messageBox -icon error -detail "Percent output must be in the range from 0 to 100." \
                -message "Error setting scene output percent." \
                -title "ams Entry Error" -type ok
            return false
        } else {
            # We have a good value.
            set scenePercentOutput($n) $P

            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal

            # If we are in DL mode in this scene, we should
            # clear the corresponding lux target.
            if { $bSceneDlEnable($n) != 0 } {
                doSetSceneLuxTarget "" $n 0
            }
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene percent output." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetSceneCCTtarget {P n e} {
    global passwordLastSetTime
    global sceneCCTtarget

    if { $e == 0 } {
        # Not editing the widget, so force the change in the value.
        .scenesFrame.cctTargetE$n delete 0 end
        .scenesFrame.cctTargetE$n insert 0 $P
    }

    if { $passwordLastSetTime > 0 } {
        # Do we have a bad value?
        if { $P == "" } {
            # puts "Set scene CCT with null value"
            # Empty is okay. Clear the box.
            set sceneCCTtarget($n) ""
            return true ;
        }
        if { ![string is integer -strict $P] || ($P < 0) || ($P > 6600) } {
            tk_messageBox -icon error -detail "CCT target must be in the range from 0 to 6600." \
                -message "Error setting scene CCT target." \
                -title "ams Entry Error" -type ok
            return false
        } else {
            # Good value.
            set sceneCCTtarget($n) $P
            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal
            #	    puts "Set CCT target $n to $P"
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene CCT target." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetScenePercentPWM {P pwm n e} {
    global passwordLastSetTime
    global quietMode
    global scenePercentPWM1
    global scenePercentPWM2
    global scenePercentPWM3

    #    puts "doSetScenePercentPWM P: $P pwm: $pwm n: $n"

    if { $quietMode } {
        return false
    }

    if { $e == 0 } {
        # Not editing the widget, so force the change in the value.
        if { $pwm == 1 } {
            .scenesFrame.percentPWM1E$n delete 0 end
            .scenesFrame.percentPWM1E$n insert 0 $P
        } elseif { $pwm == 2} {
            .scenesFrame.percentPWM2E$n delete 0 end
            .scenesFrame.percentPWM2E$n insert 0 $P
        } else {
            .scenesFrame.percentPWM3E$n delete 0 end
            .scenesFrame.percentPWM3E$n insert 0 $P
        }
    }

    if { $passwordLastSetTime > 0 } {
        # Do we have a bad value?
        if { $P == "" } {
            # Empty is okay.
            if { $pwm == 1 } {
                set scenePercentPWM1($n) ""
            } elseif { $pwm == 2} {
                set scenePercentPWM2($n) ""
            } else {
                set scenePercentPWM3($n) ""
            }
            return true ;
        }
        if { ![string is integer -strict $P] || ($P < 0) || ($P > 100) } {
            tk_messageBox -icon error -detail "Percent PWM1 must be in the range from 0 to 100." \
                -message "Error setting scene PWM1 percent." \
                -title "ams Entry Error" -type ok
            return false
        } else {
            # Good value
            if { $pwm == 1 } {
                set scenePercentPWM1($n) $P
            } elseif { $pwm == 2} {
                set scenePercentPWM2($n) $P
            } else {
                set scenePercentPWM3($n) $P
            }
            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene PWM1 percent." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetSceneRampMins {P n} {
    global passwordLastSetTime
    global sceneRampMins
    global quietMode

    if { $quietMode } {
        return false
    }

    if { $passwordLastSetTime > 0 } {
        # Do we have a bad value?
        if { $P == "" } {
            # Empty is okay.  Treat it as "Do not set."
            return true ;
        }
        if { ![string is integer -strict $P] || ($P < 0) || ($P > 240) } {
            tk_messageBox -icon error -detail "Ramp time (minutes) must be in the range from 0 to 240." \
                -message "Error setting scene ramp time." \
                -title "ams Entry Error" -type ok
            return false
        } else {
            # Mark the scene as ready to be updated.
            .scenesFrame.incUpdateSel$n  configure -state normal
        }
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene ramp time." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSetSceneRampStyle {s n} {
    global passwordLastSetTime
    global sceneRampStyle
    global quietMode

    if { $quietMode } {
        return false
    }

    if { $passwordLastSetTime > 0 } {
        if { $s == "lin" } {
            set sceneRampStyle($n) 0
        } else {
            set sceneRampStyle($n) 1
        }
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene ramp style." \
            -title "ams Entry Error" -type ok
        return false
    }
    return true
}

proc doSceneDlEnableSelect {n} {
    global passwordLastSetTime
    global bSceneDlEnable

    # Which scene was enabled or disabled?
    #    puts "Scene $n DL enable is $bSceneDlEnable($n)"
    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene daylighting enable." \
            -title "ams Entry Error" -type ok
    } else {
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
        if { $bSceneDlEnable($n) } {
            # With DL, we can set either (but not both) target lux or dimming percent.
            .scenesFrame.targetLuxE$n configure -state normal
            .scenesFrame.percentOutE$n configure -state normal
        } else {
            # Without DL, we can only set output percent.
            .scenesFrame.targetLuxE$n configure -state disabled
            .scenesFrame.percentOutE$n configure -state normal
        }
    }
}

proc doSceneCtEnableSelect {n} {
    global passwordLastSetTime
    global bSceneCtEnable

    # Which scene was enabled or disabled?
    #    puts "Scene $n CT enable is $bSceneCtEnable($n)"
    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene color-tuning enable." \
            -title "ams Entry Error" -type ok
    } else {
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
    }
}

proc doSceneDimEnableSelect {n} {
    global passwordLastSetTime
    global bSceneDimEnable

    # Which scene was enabled or disabled?
    #    puts "Scene $n dimming enable is $bSceneDimEnable($n)"
    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene dimming enable." \
            -title "ams Entry Error" -type ok
    } else {
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
    }
}

proc doSceneOccEnableSelect {n} {
    global passwordLastSetTime
    global bSceneOccEnable

    # Which scene was enabled or disabled?
    #    puts "Scene $n occupancy enable is $bSceneOccEnable($n)"
    if { $passwordLastSetTime == 0 } {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error setting scene occupancy enable." \
            -title "ams Entry Error" -type ok
    } else {
        # Mark the scene as ready to be updated.
        .scenesFrame.incUpdateSel$n  configure -state normal
    }
}

proc doSceneClearScenes {} {
    global passwordLastSetTime
    global bSceneIncludeUpdateSelect
    global bSceneIncludeUpdateSelectAll
    global bSceneIncludeClearSelect
    global bSceneIncludeClearSelectAll
    global sceneLuxTarget
    global scenePercentOutput
    global sceneRampMins
    global bSceneDlEnable
    global bSceneEnable
    global bSceneCtEnable
    global bSceneDimEnable
    global bSceneOccEnable
    global sceneStartTime
    global sceneStartTimeInt
    global sceneDays
    global sceneDaysAll
    global sceneRampStyle
    global scenePercentPWM1
    global scenePercentPWM2
    global scenePercentPWM3
    global hwModel

    if { $passwordLastSetTime > 0 } {
        .scenesFrame.clearButton configure -state disabled
        # Run through all the scenes setting up the clear mask.
        set bSceneIncludeClearSelectAll 0
        set clearmask 0
        for {set j 0} {$j <= 15} {incr j} {
            # Mark the scene as NOT ready to be updated until it is edited.
            .scenesFrame.incUpdateSel$j  configure -state disabled
            set clearmask [expr $clearmask | [expr $bSceneIncludeClearSelect($j) << $j]]
            if { $bSceneIncludeClearSelect($j) } {
                set bSceneIncludeClearSelect($j) 0
                set bSceneIncludeUpdateSelect($j) 0
                set bSceneIncludeUpdateSelectAll 0

                # Reset defaults in the display.
                #		set sceneLuxTarget($j) ""
                doSetSceneLuxTarget "" $j 0
                #		set scenePercentOutput($j) ""
                doSetScenePercentOutput "" $j 0
                set sceneRampMins($j) 0
                set sceneRampStyle($j) 0
                set bSceneDlEnable($j) 1
                set bSceneCtEnable($j) 1
                doSetSceneCCTtarget "" $j 0
                set bSceneDimEnable($j) 1
                set bSceneOccEnable($j) 1
                set bSceneEnable($j) 0
                set sceneStartTime($j) ""
                set sceneStartTimeInt($j) ""
                set sceneDaysAll($j) 0
                for {set k 0} {$k <= 6} {incr k} {
                    set sceneDays($j,$k) 1
                }
                #		set scenePercentPWM1($j) ""
                #		set scenePercentPWM2($j) ""
                #		set scenePercentPWM3($j) ""
                doSetScenePercentPWM "" 1 $j 0
                doSetScenePercentPWM "" 2 $j 0
                doSetScenePercentPWM "" 3 $j 0
            }
        }
        #	puts "Clearmask=$clearmask"
        doATcommand "ATCCLR=$clearmask"

        .scenesFrame.clearButton configure -state normal
    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error attempting to clear selected scenes." \
            -title "ams Entry Error" -type ok
    }
}

proc doSceneUpdateScenes {} {
    global passwordLastSetTime
    global bSceneIncludeUpdateSelect
    global bSceneIncludeUpdateSelectAll
    global bSceneIncludeClearSelect
    global bSceneIncludeClearSelectAll
    global bSceneEnable
    global sceneStartTime
    global sceneStartTimeInt
    global sceneDays
    global sceneDaysAll
    global sceneLuxTarget
    global scenePercentOutput
    global sceneCCTtarget
    global scenePercentPWM1
    global scenePercentPWM2
    global scenePercentPWM3
    global sceneRampMins
    global sceneRampStyle
    global bSceneDlEnable
    global bSceneCtEnable
    global bSceneDimEnable
    global bSceneOccEnable
    global hwModel

    if { $passwordLastSetTime > 0 } {
        .scenesFrame.updateButton configure -state disabled
        # Run through all the scenes doing the update thang.
        set bSceneIncludeUpdateSelectAll 0
        for {set n 0} {$n <= 15} {incr n} {
            if { ([.scenesFrame.incUpdateSel$n cget -state] == "normal") && \
                    $bSceneIncludeUpdateSelect($n) } {
                # Check to see if the required fields have been set.
                #		puts "Start $sceneStartTime($n)"
                #		puts "Start int $sceneStartTimeInt($n)"
                if { $bSceneEnable($n) && ![string is integer -strict $sceneStartTimeInt($n)] } {
                    tk_messageBox -icon error -detail "No start time specified for enabled scene $n." \
                        -message "Error updating scene." \
                        -title "ams Entry Error" -type ok
                    set bSceneIncludeUpdateSelect($n) 0
                    continue
                }
                # For DL enabled scenes, need either a lux target or dimming %.
                if { $bSceneEnable($n) && $bSceneDlEnable($n) && \
                        !( [string is integer -strict $sceneLuxTarget($n)]  ||
                    [string is integer -strict $scenePercentOutput($n)]) } {
                    tk_messageBox -icon error -detail "No lux target specified for daylighting enabled scene $n." \
                        -message "Error updating scene." \
                        -title "ams Entry Error" -type ok
                    set bSceneIncludeUpdateSelect($n) 0
                    continue
                }

                if { $bSceneEnable($n) && ($bSceneDlEnable($n) == 0) && \
                        ![string is integer -strict $scenePercentOutput($n)] } {
                    tk_messageBox -icon error -detail "No dimming % specified for daylighting disabled scene $n." \
                        -message "Error updating scene." \
                        -title "ams Entry Error" -type ok
                    set bSceneIncludeUpdateSelect($n) 0
                    continue
                }

                # Mark the scene as NOT ready to be updated.
                .scenesFrame.incUpdateSel$n  configure -state disabled

                set h [format %X $n]

                # Set the scene's flags first
                if { $bSceneDlEnable($n) } {
                    set flagsval 1
                } else {
                    set flagsval 0
                }
                if { $hwModel == 21 } {
                    #		    puts "Scene CT enable is $bSceneCtEnable($n)"
                    if { $bSceneCtEnable($n) } {
                        set flagsval [expr $flagsval | 2]
                    }
                }
                if { $bSceneDimEnable($n) } {
                    set flagsval [expr $flagsval | 4]
                }

                if { $bSceneOccEnable($n) } {
                    set flagsval [expr $flagsval | 8]
                }

                if { $sceneRampStyle($n) == 1 } {
                    set flagsval [expr $flagsval | 16]
                }

                doATcommand "ATS${h}FLAGS=$flagsval"

                # Set the scene's days of the week.
                set daysval 0
                for {set j 0} {$j <= 6} {incr j} {
                    #		    puts "sceneDays($n,$j) is $sceneDays($n,$j)"
                    set daysval [expr $daysval | [expr $sceneDays($n,$j) << $j]]
                }
                #		puts "daysval is $daysval for n $n"
                doATcommand "ATS${h}DAY=$daysval"

                # Set the start time for the scene
                doATcommand "ATS${h}TIME=$sceneStartTimeInt($n)"

                # Set lux target if the scene has DL enabled, or dimming %.
                if { $bSceneDlEnable($n) } {
                    if { [string is integer -strict $sceneLuxTarget($n)] } {
                        doATcommand "ATS${h}LUX=$sceneLuxTarget($n)"
                    } else {
                        # Checked for integer on one of these above, so we're safe.
                        doATcommand "ATS${h}DIM=$scenePercentOutput($n)"
                    }
                } else {
                    doATcommand "ATS${h}DIM=$scenePercentOutput($n)"
                }

                if { $hwModel == 21 } {
                    # Set CCT target if the scene has CT enabled, or dimming %.
                    if { $bSceneCtEnable($n) } {
                        if { [string is integer -strict $sceneCCTtarget($n)] } {
                            doATcommand "ATS${h}CCT=$sceneCCTtarget($n)"
                        }
                    }
                }

                # Set the ramp time.
                if { ![string is integer -strict $sceneRampMins($n)] } {
                    set sceneRampMins($n) 0
                }
                doATcommand "ATS${h}RAMP=$sceneRampMins($n)"

                # Do the PWMs that are integers
                if { [string is integer -strict $scenePercentPWM1($n)] } {
                    doATcommand "ATS${h}PWM1=$scenePercentPWM1($n)"
                }
                if { [string is integer -strict $scenePercentPWM2($n)] } {
                    doATcommand "ATS${h}PWM2=$scenePercentPWM2($n)"
                }
                if { [string is integer -strict $scenePercentPWM3($n)] } {
                    doATcommand "ATS${h}PWM3=$scenePercentPWM3($n)"
                }

                # Finally, set the scene enable
                doATcommand "ATS${h}ON=$bSceneEnable($n)"

                set bSceneIncludeUpdateSelect($n) 0
                set bSceneIncludeClearSelect($n) 0
                set bSceneIncludeUpdateSelectAll 0
            }
        }
        .scenesFrame.updateButton configure -state normal

    } else {
        tk_messageBox -icon error -detail "Password must be active to edit scenes." \
            -message "Error attempting to clear selected scenes." \
            -title "ams Entry Error" -type ok
    }
}

proc DoScenesDisplay {} {
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global ams_viola
    global ams_green
    global bSceneEnable
    global sceneStartTime
    global sceneStartTimeInt
    global sceneDays
    global sceneDaysAll
    global sceneLuxTarget
    global scenePercentOutput
    global sceneCCTtarget
    global scenePercentPWM1
    global scenePercentPWM2
    global scenePercentPWM3
    global sceneRampMins
    global sceneRampStyle
    global bSceneDlEnable
    global bSceneCtEnable
    global bSceneDimEnable
    global bSceneOccEnable
    global bSceneIncludeUpdateSelect
    global bSceneIncludeUpdateSelectAll
    global bSceneIncludeClearSelect
    global bSceneIncludeClearSelectAll
    global responseIsError
    global lastnum
    global passwordLastSetTime

    # ------------------------ Scenes definition tab
    frame .scenesFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 390 -width 760
    place .scenesFrame -in .theNoteBook.scenes.sFrame -x 20 -y 16

    # Column titles
    label .scenesFrame.sceneNumLt  -text "Scene" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.sceneNumLt   -in .scenesFrame  -x   4 -y  42

    label .scenesFrame.sceneEnLt  -text "E" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.sceneEnLb  -text "n" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.sceneEnLb    -in .scenesFrame  -x  46 -y  42
    place .scenesFrame.sceneEnLt    -in .scenesFrame  -x  46 -y  26

    label .scenesFrame.startTimeLt  -text "Start" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.startTimeLb  -text "Time" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.startTimeLb   -in .scenesFrame  -x  70 -y  42
    place .scenesFrame.startTimeLt   -in .scenesFrame  -x  70 -y  26

    label .scenesFrame.daysActiveLt  -text " Days Active" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLball -text "All" -font {courier -9} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb0   -text "M" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb1   -text "T" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb2   -text "W" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb3   -text "T" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb4   -text "F" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb5   -text "S" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.daysActiveLb6   -text "S" -font {courier -12} -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.daysActiveLball  -in .scenesFrame  -x 115 -y  45
    place .scenesFrame.daysActiveLb0    -in .scenesFrame  -x 133 -y  42
    place .scenesFrame.daysActiveLb1    -in .scenesFrame  -x 148 -y  42
    place .scenesFrame.daysActiveLb2    -in .scenesFrame  -x 163 -y  42
    place .scenesFrame.daysActiveLb3    -in .scenesFrame  -x 178 -y  42
    place .scenesFrame.daysActiveLb4    -in .scenesFrame  -x 193 -y  42
    place .scenesFrame.daysActiveLb5    -in .scenesFrame  -x 208 -y  42
    place .scenesFrame.daysActiveLb6    -in .scenesFrame  -x 223 -y  42
    place .scenesFrame.daysActiveLt     -in .scenesFrame  -x 144 -y  26

    label .scenesFrame.modeLH  -text "Mode" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.dlEnLt  -text "D" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.dlEnLb  -text "L" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.dlEnLb     -in .scenesFrame  -x 252 -y  42
    place .scenesFrame.dlEnLt     -in .scenesFrame  -x 252 -y  26
    place .scenesFrame.modeLH     -in .scenesFrame  -x 252 -y  12

    if { $hwModel == 21 } {
        label .scenesFrame.ctEnLt  -text "C" -font {-family systemfixed -size 9 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        label .scenesFrame.ctEnLb  -text "T" -font {-family systemfixed -size 9 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        place .scenesFrame.ctEnLb   -in .scenesFrame  -x 268 -y  42
        place .scenesFrame.ctEnLt   -in .scenesFrame  -x 268 -y  26
    }

    label .scenesFrame.targetLuxLt  -text "Target" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.targetLuxLb  -text "  Lux " -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.targetLuxLb   -in .scenesFrame  -x 294 -y  42
    place .scenesFrame.targetLuxLt   -in .scenesFrame  -x 290 -y  26

    label .scenesFrame.percentOutLt  -text "Dim" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.percentOutLb  -text "%" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.percentOutLb   -in .scenesFrame  -x 336 -y  42
    place .scenesFrame.percentOutLt   -in .scenesFrame  -x 330 -y  26

    if { $hwModel == 21 } {
        label .scenesFrame.cctLt  -text "Target" -font {-family systemfixed -size 8 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        label .scenesFrame.cctLb  -text "  CCT" -font {-family systemfixed -size 8 -weight bold} \
            -fg $ams_gray95 -bg $ams_gray25
        place .scenesFrame.cctLb   -in .scenesFrame  -x 356 -y  42
        place .scenesFrame.cctLt   -in .scenesFrame  -x 354 -y  26
    }
    label .scenesFrame.rampLt  -text "Ramp" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.rampLb  -text "Mins" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.rampLb   -in .scenesFrame  -x 396 -y  42
    place .scenesFrame.rampLt   -in .scenesFrame  -x 394 -y  26

    label .scenesFrame.rampStyleLt  -text "Ramp" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.rampStyleLb  -text "Style" -font {-family systemfixed -size 8 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.rampStyleLb   -in .scenesFrame  -x 428 -y  42
    place .scenesFrame.rampStyleLt   -in .scenesFrame  -x 428 -y  26

    label .scenesFrame.enablesLH  -text "Enable" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.dimEnLt  -text "D" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.dimEnLb  -text "m" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.dimEnLb   -in .scenesFrame  -x 476 -y  42
    place .scenesFrame.dimEnLt   -in .scenesFrame  -x 477 -y  26
    place .scenesFrame.enablesLH -in .scenesFrame  -x 474 -y  12
    label .scenesFrame.occEnLt  -text "O" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.occEnLb  -text "c" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.occEnLb   -in .scenesFrame  -x 494 -y  42
    place .scenesFrame.occEnLt   -in .scenesFrame  -x 493 -y  26

    label .scenesFrame.pwm1Lt  -text "PWM1" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.pwm1Lb  -text "%" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.pwm1Lb   -in .scenesFrame  -x 526 -y  42
    place .scenesFrame.pwm1Lt   -in .scenesFrame  -x 520 -y  28

    label .scenesFrame.pwm2Lt  -text "PWM2" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.pwm2Lb  -text "%" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.pwm2Lb   -in .scenesFrame  -x 558 -y  42
    place .scenesFrame.pwm2Lt   -in .scenesFrame  -x 548 -y  28

    label .scenesFrame.pwm3Lt  -text "PWM3" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    label .scenesFrame.pwm3Lb  -text "%" -font {-family systemfixed -size 9 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.pwm3Lb   -in .scenesFrame  -x 588 -y  42
    place .scenesFrame.pwm3Lt   -in .scenesFrame  -x 578 -y  28

    label .scenesFrame.includeClearLb  -text "All" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.includeClearLb   -in .scenesFrame  -x 640 -y  42

    checkbutton .scenesFrame.incClearAll -variable bSceneIncludeClearSelectAll \
        -bg $ams_gray25 -fg $ams_gray95 -command { doSceneIncludeClearSelectAll }
    place .scenesFrame.incClearAll  -in .scenesFrame  -x  656  -y 38

    label .scenesFrame.includeSelLb  -text "All" -font {-family systemfixed -size 7 -weight bold} \
        -fg $ams_gray95 -bg $ams_gray25
    place .scenesFrame.includeSelLb   -in .scenesFrame  -x 700 -y  42

    checkbutton .scenesFrame.incUpdateAll -variable bSceneIncludeUpdateSelectAll \
        -bg $ams_gray25 -fg $ams_gray95 -command { doSceneIncludeUpdateSelectAll }
    place .scenesFrame.incUpdateAll  -in .scenesFrame  -x  716  -y 38

    # --------------------------------------------------------------------------
    # Programmatically generate the many, many, many screen widgets.
    #    puts "About to start creating Scene-level display widgets"
    for {set i 0} {$i <=15} {incr i} {

        # Scene number labels
        label .scenesFrame.sceneNum$i -text [format %2u $i] -fg $ams_gray95 -bg $ams_gray25
        place .scenesFrame.sceneNum$i   -in .scenesFrame  -x  16 -y [expr 58 + [expr 20 * $i]]

        # Scene enables
        set bSceneEnable($i) 0
        checkbutton .scenesFrame.enable$i -variable bSceneEnable($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneEnableSelect $i]
        place .scenesFrame.enable$i     -in .scenesFrame  -x  42 -y [expr 58 + [expr 20 * $i]]

        # Start time
        set sceneStartTime($i) ""
        set sceneStartTimeInt($i) ""
        entry .scenesFrame.startTimeE$i -validate key -width 8 -justify right -relief sunken \
            -vcmd [list doSetSceneStartTime %P $i] -textvariable sceneStartTime($i) \
            -font {-family systemfixed -size 7 }
        place .scenesFrame.startTimeE$i -in .scenesFrame  -x  64 -y [expr 62 + [expr 20 * $i]]

        set sceneDaysAll($i) 0
        checkbutton .scenesFrame.dayAll$i -variable sceneDaysAll($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneDaysSelectAll $i]
        place .scenesFrame.dayAll$i  -in .scenesFrame  \
            -x  115  -y [expr 58 + [expr 20 * $i]]

        # Days of week
        for {set j 0} {$j <= 6} {incr j} {
            set sceneDays($i,$j) 0
            checkbutton .scenesFrame.day$i$j -variable sceneDays($i,$j) \
                -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneDaysSelect $i $j]
            place .scenesFrame.day$i$j  -in .scenesFrame  \
                -x  [expr 130 + [expr 15 * $j]] -y [expr 58 + [expr 20 * $i]]
        }

        # Daylighting Enable
        set bSceneDlEnable($i) 1
        checkbutton .scenesFrame.dlEnable$i -variable bSceneDlEnable($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneDlEnableSelect $i]
        place .scenesFrame.dlEnable$i     -in .scenesFrame  -x  248 -y [expr 58 + [expr 20 * $i]]

        if { $hwModel == 21 } {
            # Color tuning Enable
            set bSceneCtEnable($i) 0
            checkbutton .scenesFrame.ctEnable$i -variable bSceneCtEnable($i) \
                -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneCtEnableSelect $i]
            place .scenesFrame.ctEnable$i     -in .scenesFrame  -x  264 -y [expr 58 + [expr 20 * $i]]
        }

        # Lux target
        set sceneLuxTarget($i) ""
        entry .scenesFrame.targetLuxE$i -validate key -width 5 -justify right -relief sunken \
            -vcmd [list doSetSceneLuxTarget %P $i 1] -state normal \
            -font {-family systemfixed -size 7 }
        place .scenesFrame.targetLuxE$i -in .scenesFrame  -x  298 -y [expr 62 + [expr 20 * $i]]
        #	puts -nonewline ".scenesFrame.targetLuxE$i validate is "
        #	puts [.scenesFrame.targetLuxE$i cget -validate]

        # Dim %
        set scenePercentOutput($i) ""
        entry .scenesFrame.percentOutE$i -validate key -width 3 -justify right -relief sunken \
            -vcmd [list doSetScenePercentOutput %P $i 1] -state normal \
            -font {-family systemfixed -size 7 }
        place .scenesFrame.percentOutE$i -in .scenesFrame  -x  332 -y [expr 62 + [expr 20 * $i]]

        if { $hwModel == 21 } {
            # Target CCT
            set sceneCCTtarget($i) ""
            entry .scenesFrame.cctTargetE$i -validate key -width 4 -justify right -relief sunken \
                -vcmd [list doSetSceneCCTtarget %P $i 1] -textvariable sceneCCTtarget($i) -state normal \
                -font {-family systemfixed -size 7 }
            place .scenesFrame.cctTargetE$i -in .scenesFrame  -x  364 -y [expr 62 + [expr 20 * $i]]
        }

        # Ramp time (minutes)
        set sceneRampMins($i) 0
        entry .scenesFrame.rampMinsE$i -validate key -width 3 -justify right -relief sunken \
            -vcmd [list doSetSceneRampMins %P $i] -textvariable sceneRampMins($i) \
            -font {-family systemfixed -size 7 }
        place .scenesFrame.rampMinsE$i -in .scenesFrame  -x  404 -y [expr 62 + [expr 20 * $i]]

        # Ramp style
        set sceneRampStyle($i) 0
        spinbox .scenesFrame.rampStyle$i -validate key -state readonly -width 3 -relief sunken \
            -values {lin log}  -wrap 1 -command [list doSetSceneRampStyle %s $i]
        place .scenesFrame.rampStyle$i -in .scenesFrame  -x  430 -y [expr 62 + [expr 20 * $i]]

        # Dimming Enable
        set bSceneDimEnable($i) 0
        checkbutton .scenesFrame.dimEnable$i -variable bSceneDimEnable($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneDimEnableSelect $i]
        place .scenesFrame.dimEnable$i     -in .scenesFrame  -x  474 -y [expr 58 + [expr 20 * $i]]

        # Occupancy Enable
        set bSceneOccEnable($i) 0
        checkbutton .scenesFrame.occEnable$i -variable bSceneOccEnable($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneOccEnableSelect $i]
        place .scenesFrame.occEnable$i     -in .scenesFrame  -x  490 -y [expr 58 + [expr 20 * $i]]

        #PWM1 %
        set scenePercentPWM1($i) ""
        entry .scenesFrame.percentPWM1E$i -validate key -width 3 -justify right -relief sunken \
            -vcmd [list doSetScenePercentPWM %P 1 $i 1] -font {-family systemfixed -size 7 }
        place .scenesFrame.percentPWM1E$i -in .scenesFrame  -x  524 -y [expr 62 + [expr 20 * $i]]

        #PWM2 %
        set scenePercentPWM2($i) ""
        entry .scenesFrame.percentPWM2E$i -validate key -width 3 -justify right -relief sunken \
            -vcmd [list doSetScenePercentPWM %P 2 $i 1] -font {-family systemfixed -size 7 }
        place .scenesFrame.percentPWM2E$i -in .scenesFrame  -x  554 -y [expr 62 + [expr 20 * $i]]

        #PWM3 %
        set scenePercentPWM3($i) ""
        entry .scenesFrame.percentPWM3E$i -validate key -width 3 -justify right -relief sunken \
            -vcmd [list doSetScenePercentPWM %P 3 $i 1] -font {-family systemfixed -size 7 }
        place .scenesFrame.percentPWM3E$i -in .scenesFrame  -x  584 -y [expr 62 + [expr 20 * $i]]

        # Clear include select
        set bSceneIncludeClearSelect($i) 0
        checkbutton .scenesFrame.incClearSel$i -variable bSceneIncludeClearSelect($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneIncludeClearSelect $i]
        place .scenesFrame.incClearSel$i   -in .scenesFrame  -x  656 -y [expr 58 + [expr 20 * $i]]

        # Update include select
        set bSceneIncludeUpdateSelect($i) 0
        checkbutton .scenesFrame.incUpdateSel$i -variable bSceneIncludeUpdateSelect($i) \
            -bg $ams_gray25 -fg $ams_gray95 -command [list doSceneIncludeUpdateSelect $i] \
            -state disabled
        place .scenesFrame.incUpdateSel$i   -in .scenesFrame  -x  716 -y [expr 58 + [expr 20 * $i]]
    }
    #    puts "Done creating Scene level display widgets"
    button .scenesFrame.clearButton -text "Clear" -command { doSyncCommand doSceneClearScenes } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 8 -weight bold}
    place .scenesFrame.clearButton  -in  .scenesFrame -x 646 -y 14

    button .scenesFrame.updateButton -text "Update" -command { doSyncCommand doSceneUpdateScenes } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
        -font {-family systemfixed -size 8 -weight bold}
    place .scenesFrame.updateButton  -in  .scenesFrame -x 700 -y 14

    #    puts [array names bSceneEnable]

    # --------------------------------------------------------------------------
    # Now that everything is built, let's read in current settings for the
    # scenes from Scotty.  Fake out the password check for this process.
    set temp $passwordLastSetTime
    set passwordLastSetTime 100

    doATcommand "ATTSON"
    if { $responseIsError == 0 } {
        #	puts "ATTSON returned $lastnum"
        for {set i 0} {$i <=15} {incr i} {
            set bSceneEnable($i) [expr $lastnum & 1]
            set lastnum [expr $lastnum >> 1]
        }
    }
    #    puts "About to read Scene status from device"
    for {set i 0} {$i <=15} {incr i} {
        set h [format %X $i]
        # Read the flags
        set flagsval 0
        set useDim 0
        #	puts "Processing scene flags $i"
        doATcommand "ATS${h}FLAGS"
        if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
            #	    puts "Flags${h}= $lastnum"
            set flagsval $lastnum
            if { ([string first "0x" $lastnum] < 0) } {
                set lastnum [string trimleft $lastnum "0"]
                if { $lastnum == "" } {
                    set lastnum 0
                }
            }
            set bSceneDlEnable($i) [expr $lastnum & 1]
            if { $bSceneDlEnable($i) } {
                set useDim [expr $lastnum & 0x8000]
            }

            set bSceneCtEnable($i) [expr [expr $lastnum >> 1] & 1]

            set bSceneDimEnable($i) [expr [expr $lastnum >> 2] & 1]
            set bSceneOccEnable($i) [expr [expr $lastnum >> 3] & 1]
            if { [expr [expr $lastnum >> 4] & 1] } {
                set sceneRamptStyle($i) log
            } else {
                set sceneRamptStyle($i) lin
            }
        }
        # Start time
        #	puts "Processing scene time "
        doATcommand "ATS${h}TIME"
        if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
            #	    puts "Time${h}=$lastnum"
            set sceneStartTimeInt($i) $lastnum
            set sceneStartTime($i) [format "%02u:%02u" [expr $lastnum / 60] [expr $lastnum % 60]]
            #	    puts "sceneStartTime($i) is $sceneStartTime($i)"
        }
        #	puts "Processing scene DoW"
        # Scene active days of the week
        doATcommand "ATS${h}DAY"
        if { ($responseIsError == 0) && ($lastnum != 0) && ($lastnum != 0xFF) } {
            #	    puts "DaysOfWeek${h}=$lastnum"
            if { ([string first "0x" $lastnum] < 0) } {
                set lastnum [string trimleft $lastnum "0"]
                if { $lastnum == "" } {
                    set lastnum 0
                }
            }
            for {set j 0} {$j <=6} {incr j} {
                set sceneDays($i,$j) [expr $lastnum & 1]
                set lastnum [expr $lastnum >> 1]
            }
        }
        #	puts "Processing scene target LUX "
        # Target lux - relevant only if DL is enabled for this scene
        set lv ""
        if { $bSceneDlEnable($i) } {
            doATcommand "ATS${h}LUX"
            #	    puts "AT${h}LUX error: $responseIsError val: $lastnum"
            if { ($responseIsError == 0) && ($lastnum != 0xFFFF) } {
                #		puts "Lux${h}=$lastnum"
                set lv $lastnum
            }
        }

        # Dimming
        set dv ""
        #	puts "Processing scene dim"
        doATcommand "ATS${h}DIM"
        #	puts "AT${h}DIM error: $responseIsError val: $lastnum"
        if { ($responseIsError == 0) && ($lastnum != 255) } {
            #	    puts "Dim${h}=$lastnum"
            set dv $lastnum
        }

        #	puts "i: $i  useDim=$useDim Dl: $bSceneDlEnable($i)"
        if { $bSceneDlEnable($i) } {
            if { $useDim != 0 } {
                doSetSceneLuxTarget "" $i 0
                doSetScenePercentOutput $dv $i 0
            } else {
                doSetSceneLuxTarget $lv $i 0
                doSetScenePercentOutput "" $i 0
            }
        } else {
            doSetSceneLuxTarget "" $i 0
            doSetScenePercentOutput $dv $i 0
        }
        if { $hwModel == 21} {
            # Color tuning
            if { $bSceneCtEnable($i) } {
                doATcommand "ATS${h}CCT"
                if { ($responseIsError == 0) && ($lastnum != 65535) } {
                    #		    puts "CCT${h}=$lastnum"
                    set cct $lastnum
                    doSetSceneCCTtarget $cct $i 0
                }
            }
        }
        #	puts "Processing scene ramp"
        # Ramp time in minutes
        doATcommand "ATS${h}RAMP"
        if { ($responseIsError == 0) && ($lastnum != 255) } {
            #	    puts "Ramp${h}=$lastnum"
            set sceneRampMins($i) $lastnum
        }
        # PWMs
        if { ([expr $flagsval & 4096] != 0) } {
            # Thenn this PWM is "out of the control loop."
            doATcommand "ATS${h}PWM1"
            if { ($responseIsError == 0) && ($lastnum != 255) } {
                #		puts "PWM1_${h}=$lastnum"
                #		puts "PWM1 read=$lastnum"
                set scenePercentPWM1($i) $lastnum
            }
        }
        if { ([expr $flagsval & 8192] != 0) } {
            doATcommand "ATS${h}PWM2"
            if { ($responseIsError == 0) && ($lastnum != 255) } {
                #		puts "PWM2_${h}=$lastnum"
                #		puts "PWM2 read=$lastnum"
                set scenePercentPWM2($i) $lastnum
            }
        }
        if { ([expr $flagsval & 16384] != 0) } {
            doATcommand "ATS${h}PWM3"
            if { ($responseIsError == 0) && ($lastnum != 255) } {
                #		puts "PWM3_${h}=$lastnum"
                #		puts "PWM3 read=$lastnum"
                set scenePercentPWM3($i) $lastnum
            }
        }
        # Mark the scene as NOT ready to be updated until it is edited.
        .scenesFrame.incUpdateSel$i  configure -state disabled

    }
    set passwordLastSetTime $temp
}

proc DoLoggingDisplay {} {
    global baseportname
    global inttime
    global again
    global againstring
    global vOverwrite
    global vLogging
    global lWidgetHighIndex
    global hwVersion
    global swVersion
    global lightAddress
    global hwModel
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global bPasswordModeAuto
    global passwordValue
    global timeOfDayString
    global dayOfWeekString
    global newPasswordString
    global tcsMode
    global sampleInterval
    global usingI2Cadapter
    global bIncludeDerivedVals
    global scModel
    global bEnableEeprom
    global updateCmds
    global passwordIsValid

    # ------------------------ Device Panel (COPY from Daylighting panel)
    frame .deviceFrameL -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 64 -width 660
    label .deviceFrameL.dlabel -text "Device" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    labelframe .deviceFrameL.fwlf -text "Firmware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrameL.fwlf.l -text "$swVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrameL.fwlf.l -in .deviceFrameL.fwlf -x 12 -y 0
    labelframe .deviceFrameL.hwlf -text "Hardware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrameL.hwlf.l -text "$hwVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrameL.hwlf.l -in .deviceFrameL.hwlf -x 12 -y 0
    labelframe .deviceFrameL.port -text "Port" -font {-size 9 -weight bold}  -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrameL.port.l -text "$baseportname" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrameL.port.l -in .deviceFrameL.port -x 12 -y 0
    labelframe .deviceFrameL.lightID -text "LightID" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrameL.lightID.l -text "$lightAddress" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrameL.lightID.l -in .deviceFrameL.lightID -x 12 -y 0

    place .deviceFrameL.dlabel -in .deviceFrameL   -x   4 -y  2
    place .deviceFrameL.lightID -in .deviceFrameL  -x  70 -y  8
    place .deviceFrameL.fwlf -in .deviceFrameL     -x 225 -y  8
    place .deviceFrameL.hwlf -in .deviceFrameL     -x 380 -y  8
    place .deviceFrameL.port -in .deviceFrameL     -x 535 -y  8

    place .deviceFrameL -in .theNoteBook.logging.lFrame -x 70 -y 16

    # ------------------------ Password Panel
    # N.B. The AS7261, AS7200, etc. have the password disabled.
    if { ($hwModel != 61) && ($hwModel != 62) && ($hwModel != 63) && ($hwModel != 65) && \
         ($hwModel != 25) && ($hwModel != 0) && \
         ([checkForNewFwVersion { 21 }] == false) } {
        frame .pwFrame -bd 3 -relief raised -padx 2 -pady 2 \
            -width 200 -height 170 -background $ams_gray25

        label .pwFrame.pwActiveTimer -text "0:00" -justify center \
            -bg $ams_gray25 -fg $ams_gray95 -relief groove -bd 3 -width 5 -anchor e

        label .pwFrame.pwLabel -text "Password: " -justify center -font {system -12 bold} \
            -bg $ams_gray25 -fg $ams_gray95
        entry .pwFrame.pwEntry -font {system -12 bold} -validate all -width 4 -relief sunken -bd 3 -show "*" \
            -vcmd [list doSetPasswordEntry %P] -textvariable passwordValue \
            -invalidcommand {tk_messageBox -icon error -detail "Password must be a 4-digit integer." \
				 -message "Password entry error." \
				 -title "ams Entry Error" -type ok}
        label .pwFrame.pwModeLabel -text "Mode: " -justify left -bg $ams_gray25 -fg $ams_gray95
        radiobutton .pwFrame.pwModeAuto   -text "Auto"   -variable bPasswordModeAuto -value 1 \
            -bg $ams_gray25 -fg $ams_gray95 -command doPasswordModeSelect
        radiobutton .pwFrame.pwModeManual -text "Manual" -variable bPasswordModeAuto -value 0 \
            -bg $ams_gray25 -fg $ams_gray95 -command doPasswordModeSelect
        label .pwFrame.pwActiveLabel -text "Timer:" -justify left \
            -bg $ams_gray25 -fg $ams_gray95
        button .pwFrame.pwSendButton -text " Send " -command { doSendPassword  $passwordValue } \
            -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25

        labelframe .pwFrame.pwNote -text "Note" -font {system -8 bold} -fg $ams_gray95 -bd 3 -relief groove \
            -padx 20 -pady 0 -bg $ams_gray25 -height 62 -width 180
        label .pwFrame.pwNote.line1 -text "The password is required to" \
            -justify left -bg $ams_gray25 -fg $ams_gray95
        label .pwFrame.pwNote.line2 -text "access advanced controls." \
            -justify left -bg $ams_gray25 -fg $ams_gray95
        place .pwFrame.pwNote.line1 -in .pwFrame.pwNote -x 0  -y 0
        place .pwFrame.pwNote.line2 -in .pwFrame.pwNote -x 2 -y 18

        place .pwFrame.pwLabel       -in .pwFrame -x 4   -y 8
        place .pwFrame.pwEntry       -in .pwFrame -x 80  -y 8
        place .pwFrame.pwModeLabel   -in .pwFrame -x 22  -y 36
        place .pwFrame.pwModeAuto    -in .pwFrame -x 60  -y 36
        place .pwFrame.pwModeManual  -in .pwFrame -x 120 -y 36
        place .pwFrame.pwActiveLabel -in .pwFrame -x 22  -y 64
        place .pwFrame.pwActiveTimer -in .pwFrame -x 80  -y 64
        place .pwFrame.pwSendButton  -in .pwFrame -x 136 -y 8
        place .pwFrame.pwNote        -in .pwFrame -x 4  -y 90
        place .pwFrame -in .theNoteBook.logging.lFrame -x 70 -y 90
    } elseif { ([checkForNewFwVersion { 21 }] == true) } {
        set passwordIsValid 1
    }

    # ------------------------ Logging Panel
    frame .logFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 440 -height 170 -background $ams_gray25
    label .logFrame.logLabel -text "Logging" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25

    button .logFrame.logSelect -text " Open Data Log " -command { doOpenDataLogFile } \
        -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    labelframe .logFrame.logFileFrame -text "Data Log File" -font {-size 9 -weight bold} -width 90 -height 48 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove -bd 3
    if { $platform == "win32" } {
        label .logFrame.logFileFrame.logName -text "<none>              " -justify right -bg $ams_gray25 \
            -fg $ams_gray95 -font "-family helvetica -size 10 -slant italic" -width 48
    } else {
        label .logFrame.logFileFrame.logName -text "<none>              " -justify right -bg $ams_gray25 \
            -fg $ams_gray95 -font "-family helvetica -size 11 -slant italic" -width 48
    }
    pack  .logFrame.logFileFrame.logName -in .logFrame.logFileFrame -expand 1 -fill x

    labelframe .logFrame.logNote -text "Note" -font {system -8 bold} -fg $ams_gray95 -bd 3 -relief groove \
        -padx 30 -pady 0 -bg $ams_gray25 -height 62 -width 230
    label .logFrame.logNote.line1 -text "Opening or closing the log file" \
        -justify left -bg $ams_gray25 -fg $ams_gray95
    label .logFrame.logNote.line2 -text "will reset the sample counter." \
        -justify left -bg $ams_gray25 -fg $ams_gray95
    place .logFrame.logNote.line1 -in .logFrame.logNote -x 0  -y 0
    place .logFrame.logNote.line2 -in .logFrame.logNote -x 2 -y 18

    place .logFrame.logLabel     -in .logFrame  -x 4   -y 2
    if { $hwModel != 61 } {
        place .logFrame.logSelect    -in .logFrame  -x 32  -y 40
        place .logFrame.logNote      -in .logFrame  -x 160 -y 16
    } else {
        place .logFrame.logSelect    -in .logFrame  -x 42  -y 30
        checkbutton .logFrame.includeDVs -text "Include Derived Values" -variable bIncludeDerivedVals \
            -bg $ams_gray25 -fg $ams_gray95
        place .logFrame.includeDVs  -in .logFrame   -x 16  -y 65
        place .logFrame.logNote      -in .logFrame  -x 180 -y 16
    }
    place .logFrame.logFileFrame -in .logFrame  -x 16  -y 96
    place .logFrame -in .theNoteBook.logging.lFrame -x 290 -y 90

    # ------------------------ Sensor Control Panel
    frame .sCntrlFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 660 -height 130 -background $ams_gray25
    label .sCntrlFrame.label -text "Sensor Control" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    frame .sCntrlFrame.int_timeFrame -bd 2 -relief raised -padx 2 -pady 1
    label .sCntrlFrame.int_timeLabel -text "Integration (ms): " -justify left
    if { $platform == "win32" } {
        spinbox .sCntrlFrame.int_time -from 2.8 -to 714.0 -increment 2.8 -borderwidth 3 -font {system -14 bold} \
            -exportselection true -state normal \
            -relief sunken -width 6 -justify center -repeatdelay 350 -repeatinterval 100 -format %5.1f \
            -bg #ffffff -command {doSyncCommand doSetIntTime %s} -textvariable inttime
    } else {
        spinbox .sCntrlFrame.int_time -from 2.8 -to 714.0 -increment 2.8 -borderwidth 3 -font {system -14 bold} \
            -exportselection true -state normal \
            -relief sunken -width 5 -justify center -repeatdelay 350 -repeatinterval 100 -format %5.1f \
            -bg #ffffff -command {doSyncCommand doSetIntTime %s} -textvariable inttime
    }
    bind .sCntrlFrame.int_time <Return> { doSetIntTime ""; break }
    bind .sCntrlFrame.int_time <FocusOut> { doSetIntTime ""; break }
    .sCntrlFrame.int_time set $inttime
    pack .sCntrlFrame.int_timeLabel .sCntrlFrame.int_time -in .sCntrlFrame.int_timeFrame -side left

    lappend updateCmds $hwModel .theNoteBook.logging "ATINTTIME" { .sCntrlFrame.int_time set [format "%.1f" [expr 2.8 * $lastnum]] }

    frame .sCntrlFrame.gainFrame -bd 2 -relief raised -padx 2 -pady 1
    label .sCntrlFrame.gainLabel -text "Gain: " -justify left
    if { $platform == "win32" } {
        spinbox .sCntrlFrame.gain -values {1x 3.7x 16x 64x} -wrap true -borderwidth 3 -font {system -14 bold} \
            -exportselection true -state readonly \
            -relief sunken -width 5 -justify center -bg #ffffff -command {doSyncCommand doSetGain %s}
    } else {
        spinbox .sCntrlFrame.gain -values {1x 3.7x 16x 64x} -wrap true -borderwidth 3 -font {system -14 bold} \
            -exportselection true -state readonly \
            -relief sunken -width 4 -justify center -bg #ffffff -command {doSyncCommand doSetGain %s}
    }
    .sCntrlFrame.gain set $againstring
    pack .sCntrlFrame.gainLabel .sCntrlFrame.gain -in .sCntrlFrame.gainFrame -side left

    lappend updateCmds $hwModel .theNoteBook.logging "ATGAIN" { .sCntrlFrame.gain set [lindex {1x 3.7x 16x 64x} $lastnum] }

    if { $hwModel == 61 } {
        # TCS mode select
        frame .sCntrlFrame.tcsModeFrame -bd 3 -relief groove \
            -padx 0 -pady 0 -bg $ams_gray25 -height 100 -width 240
        label .sCntrlFrame.tcsModeLabel -text "True Color Sensor Mode: " -justify left \
            -bg $ams_gray25 -fg $ams_gray95 -font {-family systemfixed -size 9 -weight bold}
        if { $scModel == 1 } {
            # Removed tcsMode 0 (disabled) and replaced with new nIR-only mode 3
            radiobutton .sCntrlFrame.tcsModeDisabled -text "nIR" -variable tcsMode -value 3 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            radiobutton .sCntrlFrame.tcsModeXYZDk -text "X, Y, Z, Dk" -variable tcsMode -value 0 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            radiobutton .sCntrlFrame.tcsModeXYZDkIR -text "X, Y, Z, Dk, nIR" -variable tcsMode -value 1 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            radiobutton .sCntrlFrame.tcsModeXYZDkIRCl -text "X, Y, Z, Dk, nIR, Cl" -variable tcsMode -value 2 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            place .sCntrlFrame.tcsModeFrame            -in .sCntrlFrame -x 400 -y  12
            place .sCntrlFrame.tcsModeLabel            -in .sCntrlFrame -x 408 -y  16
            place .sCntrlFrame.tcsModeDisabled         -in .sCntrlFrame -x 416 -y  44
            place .sCntrlFrame.tcsModeXYZDk            -in .sCntrlFrame -x 416 -y  80
            place .sCntrlFrame.tcsModeXYZDkIR          -in .sCntrlFrame -x 516 -y  44
            place .sCntrlFrame.tcsModeXYZDkIRCl        -in .sCntrlFrame -x 516 -y  80
        } elseif { $scModel == 2 } {
            radiobutton .sCntrlFrame.tcsMode0 -text "X, Y, Z, nIR" -variable tcsMode -value 0 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            radiobutton .sCntrlFrame.tcsMode1 -text "X, Y, Dk, Cl" -variable tcsMode -value 1 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            radiobutton .sCntrlFrame.tcsMode2 -text "X, Y, Z, nIR, Dk, Cl" -variable tcsMode -value 2 \
                -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect61
            place .sCntrlFrame.tcsModeFrame            -in .sCntrlFrame -x 400 -y  12
            place .sCntrlFrame.tcsModeLabel            -in .sCntrlFrame -x 408 -y  16
            place .sCntrlFrame.tcsMode0                -in .sCntrlFrame -x 416 -y  44
            place .sCntrlFrame.tcsMode1                -in .sCntrlFrame -x 416 -y  80
            place .sCntrlFrame.tcsMode2                -in .sCntrlFrame -x 516 -y  44
        }
        if { $scModel == 1 } {
            # Sampling interval control
            frame .sCntrlFrame.sampleIntervalFrame -bd 2 -relief raised -padx 2 -pady 1
            label .sCntrlFrame.sampleIntervalLabel -text "Sample Period (ms): " -justify left
            if { $platform == "win32" } {
                spinbox .sCntrlFrame.sampleInterval -from 2.8 -to 714.0 -increment 2.8 -borderwidth 3 \
                    -font {system -14 bold} -exportselection true -state readonly \
                    -relief sunken -width 6 -justify center -repeatdelay 350 -repeatinterval 100 -format %5.1f \
                    -bg #ffffff -command {doSetSampleInterval %s}
            } else {
                spinbox .sCntrlFrame.sampleInterval -from 2.8 -to 714.0 -increment 2.8 -borderwidth 3 \
                    -font {system -14 bold} -exportselection true -state readonly \
                    -relief sunken -width 5 -justify center -repeatdelay 350 -repeatinterval 100 -format %5.1f \
                    -bg #ffffff -command {doSetSampleInterval %s}
            }
            .sCntrlFrame.sampleInterval set $sampleInterval
            pack .sCntrlFrame.sampleIntervalLabel .sCntrlFrame.sampleInterval \
                -in .sCntrlFrame.sampleIntervalFrame -side left
            label .sCntrlFrame.sampleIntervalNote1 -text "Range set by integration" \
                -bg $ams_gray25 -fg $ams_gray95
            label .sCntrlFrame.sampleIntervalNote2 -text "time and TCS Mode" \
                -bg $ams_gray25 -fg $ams_gray95

            place .sCntrlFrame.sampleIntervalFrame     -in .sCntrlFrame -x 200 -y  36
            place .sCntrlFrame.sampleIntervalNote1     -in .sCntrlFrame -x 220 -y  66
            place .sCntrlFrame.sampleIntervalNote2     -in .sCntrlFrame -x 230 -y  86
        }
        # Customize the sample interval settings based on the tcsMode
        doTCSmodeSelect61
    }
    if { 0 } {
        # Scotty 2 AS7262 devices
        radiobutton .sCntrlFrame.tcsMode0 -text "V, B, G, Y" -variable tcsMode -value 0 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        radiobutton .sCntrlFrame.tcsMode1 -text "G, Y, O, R" -variable tcsMode -value 1 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        radiobutton .sCntrlFrame.tcsMode2 -text "V, B, G, Y, O, R" -variable tcsMode -value 2 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        place .sCntrlFrame.tcsModeFrame            -in .sCntrlFrame -x 400 -y  12
        place .sCntrlFrame.tcsModeLabel            -in .sCntrlFrame -x 408 -y  16
        place .sCntrlFrame.tcsMode0                -in .sCntrlFrame -x 416 -y  44
        place .sCntrlFrame.tcsMode1                -in .sCntrlFrame -x 416 -y  80
        place .sCntrlFrame.tcsMode2                -in .sCntrlFrame -x 516 -y  44
    }
    if { 0 } {
        # Scotty 2 AS7263 devices
        radiobutton .sCntrlFrame.tcsMode0 -text "S, T, U, V" -variable tcsMode -value 0 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        radiobutton .sCntrlFrame.tcsMode1 -text "R, T, U, W" -variable tcsMode -value 1 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        radiobutton .sCntrlFrame.tcsMode2 -text "R, S, T, U, V, W" -variable tcsMode -value 2 \
            -bg $ams_gray25 -fg $ams_gray95 -command doTCSmodeSelect62n3
        place .sCntrlFrame.tcsModeFrame            -in .sCntrlFrame -x 400 -y  12
        place .sCntrlFrame.tcsModeLabel            -in .sCntrlFrame -x 408 -y  16
        place .sCntrlFrame.tcsMode0                -in .sCntrlFrame -x 416 -y  44
        place .sCntrlFrame.tcsMode1                -in .sCntrlFrame -x 416 -y  80
        place .sCntrlFrame.tcsMode2                -in .sCntrlFrame -x 516 -y  44
    }
    
    set updateTimeDayControlX 260
    set newPasswordControlX 450
    set newFirmwareControlX 470
    if { ($hwModel == 21) || ($hwModel == 65) } {
        if { ([checkForNewFwVersion { 21 65 }] == true) } {
            button .sCntrlFrame.resetFactory -text " Factory Reset " -command { doSyncCommand doFactoryReset .theNoteBook.logging } \
                -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 -width 12
            place .sCntrlFrame.resetFactory     -in .sCntrlFrame -x [expr $newFirmwareControlX + 72] -y 80
        }
    }

    if { ($hwModel != 61) && ($hwModel != 62) && ($hwModel != 63) && ($hwModel != 65) && \
         ($hwModel != 25) && ($hwModel != 0) } {
        button .sCntrlFrame.setTimeButton -text " Update Time/Day " -command { doSyncCommand doUpdateTime } \
            -relief raised -bd 2 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25 \
            -state disabled
        label .sCntrlFrame.currentSlikTime -text "" -bg $ams_gray25 -fg $ams_gray95
        label .sCntrlFrame.lastTimeSet -text "" -bg $ams_gray25 -fg $ams_gray95

        place .sCntrlFrame.currentSlikTime   -in .sCntrlFrame -x [expr $updateTimeDayControlX + 0] -y 12
        place .sCntrlFrame.setTimeButton     -in .sCntrlFrame -x [expr $updateTimeDayControlX + 0] -y 36
        place .sCntrlFrame.lastTimeSet       -in .sCntrlFrame -x [expr $updateTimeDayControlX + 0] -y 68
        lappend updateCmds $hwModel .theNoteBook.logging "" { doUpdateDateTime }

        if { ([checkForNewFwVersion { 21 }] == true) } {
            .sCntrlFrame.setTimeButton configure -state normal
            checkbutton .sCntrlFrame.enableEeprom -text "Enable persistent memory" -variable bEnableEeprom \
                -bg $ams_gray25 -fg $ams_gray95 -command { doSyncCommand doSetEnableEeprom }
            place .sCntrlFrame.enableEeprom     -in .sCntrlFrame -x [expr $newFirmwareControlX + 2] -y 12
            doGetEnableEeprom            
            lappend updateCmds $hwModel .theNoteBook.logging "" { doGetEnableEeprom }
        } else {
            frame .sCntrlFrame.setNewPasswordFrame -bd 2 -relief raised -padx 2 -pady 1
            label .sCntrlFrame.setNewPasswordFrame.l -text "New Password: " -justify left
            entry .sCntrlFrame.setNewPasswordFrame.e -font {system -12 bold} -validate key -width 4 -show "*" \
                -relief sunken -bd 3 -vcmd [list doSetNewPassword %P] -textvariable newPasswordString \
                -invalidcommand {tk_messageBox -icon error \
                -detail "Password must be active and value must be 4 digits to set new password." \
                -message "Error setting new password." \
                -title "ams Entry Error" -type ok}
            pack  .sCntrlFrame.setNewPasswordFrame.l .sCntrlFrame.setNewPasswordFrame.e \
            -in .sCntrlFrame.setNewPasswordFrame -side left
            label .sCntrlFrame.setPasswordLabel -text "Must be 4 Digits" -bg $ams_gray25 -fg $ams_gray95
            
            place .sCntrlFrame.setNewPasswordFrame   -in .sCntrlFrame -x [expr $newPasswordControlX +  0]  -y   36
            place .sCntrlFrame.setPasswordLabel      -in .sCntrlFrame -x [expr $newPasswordControlX + 20]  -y   68
        }
    }

    place .sCntrlFrame.label              -in .sCntrlFrame  -x   4 -y   8
    place .sCntrlFrame.int_timeFrame      -in .sCntrlFrame  -x  16 -y  36
    place .sCntrlFrame.gainFrame          -in .sCntrlFrame  -x  16 -y  78

    place .sCntrlFrame -in .theNoteBook.logging.lFrame  -x  70 -y 270

    if { ($hwModel != 61) && ($hwModel != 62) && ($hwModel != 63) && ($hwModel != 65) && ($hwModel != 0) } {
        doSetPassword $passwordValue
        if { $bPasswordModeAuto } {
            doPasswordModeSelect
            .sCntrlFrame.setTimeButton configure -state normal
        }
    }
}

proc doFactoryReset { currentTab } {
    global atCommandTimeout
    global sampleCount
    global sampleCountWidget

    .sCntrlFrame.resetFactory configure -state disabled
    .sCntrlFrame.resetFactory configure -text " Please wait... "    

    set tmp $atCommandTimeout
    set atCommandTimeout 10000
    
    doATcommand "ATFRST"
    
    set atCommandTimeout $tmp
    
    set vwaitVar 0
    after 5000 set vwaitVar 1
    vwait vwaitVar

    doUpdateCommands $currentTab
    
    set sampleCount 0
    $sampleCountWidget configure -text $sampleCount

    .sCntrlFrame.resetFactory configure -text " Factory Reset "    
    .sCntrlFrame.resetFactory configure -state normal
}

proc doGetEnableEeprom {} {
    global responseIsError
    global lastnum
    global bEnableEeprom
    
    doATcommand "ATPERSMEM"
    if { $responseIsError == 0 } {
        set bEnableEeprom $lastnum
    }
}

proc doSetEnableEeprom {} {
    global bEnableEeprom
    
    doATcommand "ATPERSMEM=$bEnableEeprom"
}

proc doUpdateDateTime {} {
    global responseIsError
    global lastnum

    doATcommand "ATTIMENOW"
    if { $responseIsError == 0 } {
        updateTimeOfDay .statusFrame.timeFrame.v $lastnum
    }
    
    doATcommand "ATDOW"
    if { $responseIsError == 0 } {
        updateDayOfWeek .statusFrame.dayFrame.v $lastnum
    }
}

proc doSetLightOutputPercent { value } {
    global lightState
    global percentLightOutput
    global scaleWaitNow
    global statusLastEvent
    global statusLastEventString
    global lastEventWidget
    global lastDLsliderChange

    set statusLastEvent 0x10000
    set statusLastEventString "Dashboard"
    $lastEventWidget configure -text "$statusLastEventString"

    doLightCheck

    # Only send the ATDIM command if the light is ON.
    if { $lightState == 1 } {
        set lastDLsliderChange [clock seconds]
        if { $scaleWaitNow == 0 } {
            set scaleWaitNow 1
            doATcommand "ATDIM=$percentLightOutput"
            set scaleWaitNow 0
            # Show most recently written data at bottom.

        }
    }
}

proc doSetTargetLux { value } {
    global targetLuxVal
    global scaleWaitNow
    global statusLastEvent
    global statusLastEventString
    global lastEventWidget
    global lastDLsliderChange

    set statusLastEvent 0x10000
    set statusLastEventString "Dashboard"
    $lastEventWidget configure -text "$statusLastEventString"

    set lastDLsliderChange [clock seconds]
    if { $scaleWaitNow == 0 } {
        set scaleWaitNow 1
        doATcommand "ATLUXT=$targetLuxVal"
        set scaleWaitNow 0
        # Show most recently written data at bottom.

    }
}

proc Do7211DaylightingDisplay {} {
    global baseportname
    global vOverwrite
    global vLogging
    global lWidgetHighIndex
    global lUpdateProcs
    global amslogo
    global hwModel
    global swVersion
    global hwVersion
    global lightAddress
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global lightState
    global daylightingState
    global bUpdateModeAuto
    global percentLightOutput
    global targetLuxVal
    global statusLastUpdate
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global statusLastUpdate
    global sampleWidgetNames
    global lWidgets
    global lWidgetHighIndex
    global responseIsError
    global lastnum
    global passwordLastSetTime
    global statusLastEvent
    global lastEventWidget

    # ------------------------ Device Panel
    frame .deviceFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 64 -width 660
    label .deviceFrame.dlabel -text "Device" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    labelframe .deviceFrame.fwlf -text "Firmware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.fwlf.l -text "$swVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.fwlf.l -in .deviceFrame.fwlf -x 12 -y 0
    labelframe .deviceFrame.hwlf -text "Hardware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.hwlf.l -text "$hwVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.hwlf.l -in .deviceFrame.hwlf -x 12 -y 0
    labelframe .deviceFrame.port -text "Port" -font {-size 9 -weight bold}  -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.port.l -text "$baseportname" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.port.l -in .deviceFrame.port -x 12 -y 0
    labelframe .deviceFrame.lightID -text "LightID" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.lightID.l -text "$lightAddress" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.lightID.l -in .deviceFrame.lightID -x 12 -y 0

    place .deviceFrame.dlabel -in .deviceFrame   -x   4 -y   2
    place .deviceFrame.lightID -in .deviceFrame  -x  70 -y   8
    place .deviceFrame.fwlf -in .deviceFrame     -x 225 -y   8
    place .deviceFrame.hwlf -in .deviceFrame     -x 380 -y   8
    place .deviceFrame.port -in .deviceFrame     -x 535 -y   8

    place .deviceFrame -in .theNoteBook.daylighting.dFrame -x 70 -y 16

    # ------------------------ Light Output Control Panel
    frame .lightCtrlFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 660 -height 170 -background $ams_gray25
    set lightState 0
    label .lightCtrlFrame.label -text "Control" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    button .lightCtrlFrame.lightButton -text " Turn Light On  " -font {system -12 bold} \
        -command { doLightButton } -state normal \
        -relief raised -bd 3 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    # Find out if the light is already ON.
    doATcommand "ATLIGHT"
    if { $responseIsError == 0 } {
        #	puts "Light state is $lastnum"
        set lightState $lastnum
        #	puts "Starting lightState=$lightState"
        if { $lightState } {
            .lightCtrlFrame.lightButton configure -text " Turn Light Off "
        }
    }

    doATcommand "ATDL"
    if { $responseIsError == 0 } {
        #	puts "ATDL returned $lastnum"
        set daylightingState $lastnum
        if { $daylightingState } {
            #	    puts "Daylighting is ENABLED"
            set dlt " Disable Daylighting "
        } else {
            #	    puts "Daylighting is DISABLED"
            set dlt " Enable Daylighting  "
        }
    } else {
        #	puts "Daylighting state read failed"
        set dlt " Enable Daylighting  "
    }

    if { $passwordLastSetTime > 0 } {
        set dls normal
    } else {
        set dls disabled
    }

    doATcommand "ATDIM"
    if { $responseIsError == 0 } {
        set percentLightOutput $lastnum
    } else {
        set percentLightOutput 50
    }

    doATcommand "ATLUXT"
    if { $responseIsError == 0 } {
        set targetLuxVal $lastnum
    } else {
        set targetLuxVal 150
    }

    button .lightCtrlFrame.daylightingButton -text $dlt -font {system -12 bold} \
        -command { doDaylightingButton } -state $dls \
        -relief raised -bd 3 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    label .lightCtrlFrame.pwNotice -text "Enter password (Logging) to enable" -font {-size 8} \
        -fg $ams_gray95 -bg $ams_gray25
    scale .lightCtrlFrame.lightOutputPercent -orient hor -from 0 -to 100 -variable percentLightOutput \
        -width 16 -length 400 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "% Light Output (Dimming)" -tickinterval 25 -command { doSetLightOutputPercent }
    scale .lightCtrlFrame.targetLux -orient hor -from 0 -to 4000 -variable targetLuxVal \
        -width 16 -length 400 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "Target Lux" -tickinterval 1000 -command { doSetTargetLux }

    frame .lightCtrlFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .lightCtrlFrame.sampleModeLabel -text "Metric Update Mode:" -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .lightCtrlFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect
    button .lightCtrlFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .lightCtrlFrame.sampleUpdate
    frame .lightCtrlFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .lightCtrlFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .lightCtrlFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .lightCtrlFrame.sampleStopAfter.v
    pack .lightCtrlFrame.sampleStopAfter.l .lightCtrlFrame.sampleStopAfter.v \
        -in .lightCtrlFrame.sampleStopAfter -side left

    place .lightCtrlFrame.sampleModeLabel   -in .lightCtrlFrame.sampleMode -x 4   -y 4
    #   place .lightCtrlFrame.sampleModeAuto    -in .lightCtrlFrame.sampleMode -x 16  -y 24
    #   place .lightCtrlFrame.sampleModeManual  -in .lightCtrlFrame.sampleMode -x 16  -y 44
    place .lightCtrlFrame.continuousMode    -in .lightCtrlFrame.sampleMode -x 16  -y 32
    place .lightCtrlFrame.sampleUpdate      -in .lightCtrlFrame.sampleMode -x 120 -y 32
    place .lightCtrlFrame.sampleStopAfter   -in .lightCtrlFrame.sampleMode -x 40  -y 76

    place .lightCtrlFrame.label               -in .lightCtrlFrame -x 4   -y 2
    place .lightCtrlFrame.sampleMode          -in .lightCtrlFrame -x 12  -y 32
    place .lightCtrlFrame.lightButton         -in .lightCtrlFrame -x 252 -y 8
    place .lightCtrlFrame.daylightingButton   -in .lightCtrlFrame -x 470 -y 8
    place .lightCtrlFrame.pwNotice            -in .lightCtrlFrame -x 455 -y 40
    if { $daylightingState == 0 } {
        place .lightCtrlFrame.lightOutputPercent  -in .lightCtrlFrame -x 232 -y 60
    } else {
        place .lightCtrlFrame.targetLux           -in .lightCtrlFrame -x 232 -y 60
    }
    place .lightCtrlFrame    -in .theNoteBook.daylighting.dFrame  -x 70  -y 90

    # ------------------------ Status Panel
    frame .statusFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 130 -width 660
    label .statusFrame.slabel -text "Managed Metrics" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25

    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .statusFrame.updateLabel -text "Last Sample:" -fg $ams_gray95 -bg $ams_gray25
    label .statusFrame.updateTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .statusFrame.updateTimeL
    label .statusFrame.loggingStatusLabel -text "" -fg $ams_gray95 -bg $ams_gray25
    frame .statusFrame.pcOutputFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.pcOutputFrame.l -text "   Dim %    " -justify left
    label .statusFrame.pcOutputFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.pcOutputFrame.l .statusFrame.pcOutputFrame.v -in .statusFrame.pcOutputFrame -side left

    frame .statusFrame.luxFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.luxFrame.l -text "Current Lux" -justify left
    label .statusFrame.luxFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.luxFrame.l .statusFrame.luxFrame.v -in .statusFrame.luxFrame -side left

    frame .statusFrame.luxTFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.luxTFrame.l -text "Lux Target" -justify left
    label .statusFrame.luxTFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.luxTFrame.l .statusFrame.luxTFrame.v -in .statusFrame.luxTFrame -side left

    frame .statusFrame.timeFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.timeFrame.l -text "Time" -justify left
    label .statusFrame.timeFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 7 -anchor e
    pack .statusFrame.timeFrame.l .statusFrame.timeFrame.v -in .statusFrame.timeFrame -side left

    frame .statusFrame.dayFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.dayFrame.l -text "Day  " -justify left
    label .statusFrame.dayFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 5 -anchor e
    pack .statusFrame.dayFrame.l .statusFrame.dayFrame.v -in .statusFrame.dayFrame -side left

    frame .statusFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.sampleCount.l -text " Samples  " -justify left
    label .statusFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    set sampleCountWidget .statusFrame.sampleCount.v
    pack .statusFrame.sampleCount.l .statusFrame.sampleCount.v -in .statusFrame.sampleCount -side left

    set statusLastEvent 0
    label .statusFrame.eventL -text "Last Event:" -fg $ams_gray95 -bg $ams_gray25
    label .statusFrame.eventV -text "" -fg $ams_gray95 -bg $ams_gray25
    set lastEventWidget .statusFrame.eventV

    place .statusFrame.slabel -in .statusFrame              -x 4   -y 0
    place .statusFrame.updateLabel -in .statusFrame         -x 255 -y 0
    place .statusFrame.updateTimeL -in .statusFrame         -x 325 -y 0
    place .statusFrame.loggingStatusLabel -in .statusFrame  -x 270 -y 18
    place .statusFrame.pcOutputFrame -in .statusFrame       -x 20  -y 80
    place .statusFrame.luxFrame -in .statusFrame            -x  20 -y 36
    place .statusFrame.timeFrame -in .statusFrame           -x 540 -y 36
    place .statusFrame.dayFrame -in .statusFrame            -x 540 -y 80
    if { $daylightingState } {
        place .statusFrame.luxTFrame -in .statusFrame       -x 260 -y 36
    }
    place .statusFrame.sampleCount -in .statusFrame         -x 260 -y 80
    place .statusFrame.eventL      -in .statusFrame         -x 450 -y 0
    place .statusFrame.eventV      -in .statusFrame         -x 514 -y 0

    place .statusFrame -in .theNoteBook.daylighting.dFrame -x 70 -y 270

    set sampleWidgetNames "Sample, Output %, Lux Reading, Device Time, Device Day, Timestamp"

    set lWidgets [list .statusFrame.pcOutputFrame.v \
        .statusFrame.luxFrame.v \
        .statusFrame.timeFrame.v \
        .statusFrame.dayFrame.v]
    set lWidgetHighIndex [expr [llength $lWidgets] - 1]

    set lUpdateProcs [list updateTextDimmingPercent  \
        updateText \
        updateTimeOfDay \
        updateDayOfWeek]
}

proc doSetTargetCCT { value } {
    global targetCCTVal
    global scaleWaitNow
    global statusLastEvent
    global statusLastEventString
    global lastEventWidget
    global lastCTsliderChange

    # puts "doSetTargetCCT: $value"
    
    set statusLastEvent 0x10000
    set statusLastEventString "Dashboard"
    $lastEventWidget configure -text "$statusLastEventString"

    set lastCTsliderChange [clock seconds]
    if { $scaleWaitNow == 0 } {
        set scaleWaitNow 1
        doATcommand "ATCCTT=$targetCCTVal"
        set scaleWaitNow 0
        # Show most recently written data at bottom.

    }
}

proc doSetTargetPWMmix { value } {
    global targetPWMmixVal
    global scaleWaitNow
    global statusLastEvent
    global statusLastEventString
    global lastEventWidget
    global lastCTsliderChange
    global colorTuneSliderWidget

    set statusLastEvent 0x10000
    set statusLastEventString "Dashboard"
    $lastEventWidget configure -text "$statusLastEventString"

    set lastCTsliderChange [clock seconds]
    if { $scaleWaitNow == 0 } {
        set scaleWaitNow 1
        doATcommand "ATLED23M=$targetPWMmixVal"
        set scaleWaitNow 0
        # Show most recently written data at bottom.

        $colorTuneSliderWidget configure -text "$targetPWMmixVal%"
    }
}

proc Do7221ColorTuningDisplay {} {
    global baseportname
    global vOverwrite
    global vLogging
    global lWidgetHighIndex
    global lUpdateProcs
    global amslogo
    global hwModel
    global swVersion
    global hwVersion
    global lightAddress
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global platform
    global lightState
    global daylightingState
    global colorTuningState
    global bUpdateModeAuto
    global percentLightOutput
    global targetLuxVal
    global targetCCTVal
    global targetPWMmixVal
    global manualButtonWidget
    global sampleCountWidget
    global sampleTargetWidget
    global lastUpdateTimeWidget
    global colorTuneSliderWidget    
    global statusLastUpdate
    global sampleWidgetNames
    global lWidgets
    global lWidgetHighIndex
    global responseIsError
    global lastnum
    global passwordLastSetTime
    global statusLastEvent
    global lastEventWidget
    global haveTempX
    global tempXval
    global haveRhX
    global rhXval
    global updateCmds
    global colorControlY1
    global colorControlY2

    # ------------------------ Device Panel
    frame .deviceFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 64 -width 760
    label .deviceFrame.dlabel -text "Device" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    labelframe .deviceFrame.fwlf -text "Firmware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.fwlf.l -text "$swVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.fwlf.l -in .deviceFrame.fwlf -x 12 -y 0
    labelframe .deviceFrame.hwlf -text "Hardware" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.hwlf.l -text "$hwVersion" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.hwlf.l -in .deviceFrame.hwlf -x 12 -y 0
    labelframe .deviceFrame.port -text "Port" -font {-size 9 -weight bold}  -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.port.l -text "$baseportname" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.port.l -in .deviceFrame.port -x 12 -y 0
    labelframe .deviceFrame.lightID -text "LightID" -font {-size 9 -weight bold} -width 90 -height 40 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove
    label .deviceFrame.lightID.l -text "$lightAddress" -font {-size 8} -fg $ams_gray95 -bg $ams_gray25
    place .deviceFrame.lightID.l -in .deviceFrame.lightID -x 12 -y 0

    place .deviceFrame.dlabel -in .deviceFrame   -x   4 -y   2
    place .deviceFrame.lightID -in .deviceFrame  -x  80 -y   8
    place .deviceFrame.fwlf -in .deviceFrame     -x 255 -y   8
    place .deviceFrame.hwlf -in .deviceFrame     -x 440 -y   8
    place .deviceFrame.port -in .deviceFrame     -x 625 -y   8

    # place .deviceFrame -in .theNoteBook.colortuning.dFrame -x 20 -y 16

    # ------------------------ Light Output Control Panel
    frame .lightCtrlFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 760 -height 264 -background $ams_gray25
    set lightState 0
    label .lightCtrlFrame.label -text "Control" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25
    button .lightCtrlFrame.lightButton -text " Turn Light On  " -font {system -12 bold} \
        -command { doSyncCommand doLightButton } -state normal \
        -relief raised -bd 3 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    # Find out if the light is already ON.
    doATcommand "ATLIGHT"
    if { $responseIsError == 0 } {
        #	puts "Light state is $lastnum"
        set lightState $lastnum
        #	puts "Starting lightState=$lightState"
        if { $lightState } {
            .lightCtrlFrame.lightButton configure -text " Turn Light Off "
        }
    }

    doATcommand "ATCT"
    if { $responseIsError == 0 } {
        #	puts "ATCT returned $lastnum"
        set colorTuningState $lastnum
        if { $colorTuningState } {
            #	    puts "Color Tuning is ENABLED"
            set cctt " Disable Color Tuning "
        } else {
            #	    puts "Color Tuning is DISABLED"
            set cctt " Enable Color Tuning "
        }
    } else {
        #	puts "Color Tuning state read failed"
        set cctt " Enable Color Tuning "
    }

    doATcommand "ATDL"
    if { $responseIsError == 0 } {
        #	puts "ATDL returned $lastnum"
        set daylightingState $lastnum
        if { $daylightingState } {
            #	    puts "Daylighting is ENABLED"
            set dlt " Disable Daylighting "
        } else {
            #	    puts "Daylighting is DISABLED"
            set dlt " Enable Daylighting  "
        }
    } else {
        #	puts "Daylighting state read failed"
        set dlt " Enable Daylighting  "
    }

    #    puts "passwordLastSetTime is $passwordLastSetTime"
    if { $passwordLastSetTime > 0 } {
        set dls normal
        set ccts normal
    } else {
        set dls disabled
        set ccts disabled
    }

    doATcommand "ATDIM"
    if { $responseIsError == 0 } {
        set percentLightOutput $lastnum
    } else {
        set percentLightOutput 50
    }

    doATcommand "ATCCTT"
    if { $responseIsError == 0 } {
        set targetCCTVal $lastnum
    } else {
        set targetCCTVal 4250
    }

    doATcommand "ATLUXT"
    if { $responseIsError == 0 } {
        set targetLuxVal $lastnum
    } else {
        set targetLuxVal 150
    }

    doATcommand "ATLED23M"
    if { $responseIsError == 0 } {
        set targetPWMmixVal $lastnum
    } else {
        set targetPWMmixVal 50
    }

    doATcommand "ATTEMPX"
    if { $responseIsError == 0 } {
        set haveTempX true
        set tempXval  $lastnum
    } else {
        set haveTempX false
    }
    # set haveTempX true

    doATcommand "ATRHX"
    if { $responseIsError == 0 } {
        set haveRhX true
        set rhXval  $lastnum
    } else {
        set haveRhX false
    }
    # set haveRhX true

    #    puts "Color tuning button initialized to $ccts"
    #    puts "Daylighting  button initialized to $dls"
    button .lightCtrlFrame.colorTuningButton -text $cctt -font {system -12 bold} \
        -command { doSyncCommand doColorTuningButton } -state $ccts \
        -relief raised -bd 3 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    button .lightCtrlFrame.daylightingButton -text $dlt -font {system -12 bold} \
        -command { doSyncCommand doDaylightingButton } -state $dls \
        -relief raised -bd 3 -bg $ams_gray25 -fg $ams_gray95 -highlightbackground $ams_gray25
    label .lightCtrlFrame.pwNotice -text "Enter password (Logging) to enable" \
        -fg $ams_gray95 -bg $ams_gray25
    scale .lightCtrlFrame.lightOutputPercent -orient hor -from 0 -to 100 -variable percentLightOutput \
        -width 8 -length 330 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "Dimming (%)" -tickinterval 10 -command { doSyncCommand doSetLightOutputPercent }
    scale .lightCtrlFrame.targetLux -orient hor -from 0 -to 4000 -variable targetLuxVal \
        -width 8 -length 330 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "Target Lux" -tickinterval 500 -command { doSyncCommand doSetTargetLux }
    scale .lightCtrlFrame.targetCCT -orient hor -from 2500 -to 6500 -variable targetCCTVal \
        -width 8 -length 330 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "Target CCT" -tickinterval 500 -command { doSyncCommand doSetTargetCCT }
    scale .lightCtrlFrame.targetPWMmix -orient hor -from 0 -to 100 -variable targetPWMmixVal \
        -width 8 -length 330 -relief sunken -bg $ams_gray25 -fg $ams_gray95 \
        -label "Color Tune (%)" -tickinterval 10 -command { doSyncCommand doSetTargetPWMmix }

    lappend updateCmds $hwModel .theNoteBook.colortuning "ATLED23M" { set targetPWMmixVal $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATCCTT" { set targetCCTVal $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATDIM" { set percentLightOutput $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATLUXT" { set targetLuxVal $lastnum }
    # these update commands have to be after the above commands 
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATCT" { doColorTuningState $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATDL" { doDaylightingState $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "ATLIGHT" { doLightState $lastnum }
    lappend updateCmds $hwModel .theNoteBook.colortuning "" { doGetSample }

    frame .lightCtrlFrame.sampleMode -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 120 -width 200
    label .lightCtrlFrame.sampleModeLabel -text "Metric Update Mode:" \
        -justify left -bg $ams_gray25 -fg $ams_gray95
    checkbutton .lightCtrlFrame.continuousMode -text "Continuous" -variable bUpdateModeAuto \
        -bg $ams_gray25 -fg $ams_gray95 -command doUpdateModeSelect

    button .lightCtrlFrame.sampleUpdate -text " Sample " -command { doUpdateButton } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    set manualButtonWidget .lightCtrlFrame.sampleUpdate
    frame .lightCtrlFrame.sampleStopAfter -bd 2 -relief raised -padx 2 -pady 1
    label .lightCtrlFrame.sampleStopAfter.l -text "Stop After:" -justify left
    entry .lightCtrlFrame.sampleStopAfter.v -font {system -12 bold} -justify right \
        -validate key -width 6 -relief sunken -bd 3 -vcmd [list doSetStopAfter %P] \
        -invalidcommand {tk_messageBox -icon error -detail "Entry must be a positive integer." \
			     -message "Error entering sampling termination count." \
			     -title "ams Entry Error" -type ok}
    set sampleTargetWidget .lightCtrlFrame.sampleStopAfter.v
    pack .lightCtrlFrame.sampleStopAfter.l .lightCtrlFrame.sampleStopAfter.v \
        -in .lightCtrlFrame.sampleStopAfter -side left

    place .lightCtrlFrame.sampleModeLabel   -in .lightCtrlFrame.sampleMode -x 4   -y 4
    place .lightCtrlFrame.continuousMode    -in .lightCtrlFrame.sampleMode -x 16  -y 32
    place .lightCtrlFrame.sampleUpdate      -in .lightCtrlFrame.sampleMode -x 120 -y 32
    place .lightCtrlFrame.sampleStopAfter   -in .lightCtrlFrame.sampleMode -x 40  -y 76

    place .lightCtrlFrame.label               -in .lightCtrlFrame -x 4   -y 2
    place .lightCtrlFrame.sampleMode          -in .lightCtrlFrame -x 12  -y 32
    place .lightCtrlFrame.lightButton         -in .lightCtrlFrame -x 608 -y 64
    place .lightCtrlFrame.colorTuningButton   -in .lightCtrlFrame -x 580 -y 8
    place .lightCtrlFrame.daylightingButton   -in .lightCtrlFrame -x 586 -y 122
    if { ([checkForNewFwVersion { 21 }] == false) } {
        place .lightCtrlFrame.pwNotice            -in .lightCtrlFrame -x 550 -y 165
    }
    if { $colorTuningState == 1 } {
        place .lightCtrlFrame.targetCCT           -in .lightCtrlFrame -x 227 -y 8
    } else {
        place .lightCtrlFrame.targetPWMmix        -in .lightCtrlFrame -x 227 -y 8
    }
    if { $daylightingState == 0 } {
        place .lightCtrlFrame.lightOutputPercent  -in .lightCtrlFrame -x 227 -y 82
    } else {
        place .lightCtrlFrame.targetLux           -in .lightCtrlFrame -x 227 -y 82
    }

    frame .lightCtrlFrame.statusFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 90 -width 200
    set statusLastUpdate [clock format [clock seconds] -format "%I:%M %P"]
    label .lightCtrlFrame.l       -text "Status"        -fg $ams_gray95  -bg $ams_gray25
    label .lightCtrlFrame.luLabel -text "Last Sample:"  -fg $ams_gray95  -bg $ams_gray25
    label .lightCtrlFrame.luTimeL -text "$statusLastUpdate" -fg $ams_gray95 -bg $ams_gray25
    set lastUpdateTimeWidget .lightCtrlFrame.luTimeL
    
    frame .lightCtrlFrame.sampleCount -bd 2 -relief raised -padx 2 -pady 1
    label .lightCtrlFrame.sampleCount.l -text "Samples" -justify left
    label .lightCtrlFrame.sampleCount.v -text "0" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack  .lightCtrlFrame.sampleCount.l .lightCtrlFrame.sampleCount.v -in .lightCtrlFrame.sampleCount -side left
    set sampleCountWidget .lightCtrlFrame.sampleCount.v
    
    place .lightCtrlFrame.l           -in .lightCtrlFrame.statusFrame  -x   4 -y   4
    place .lightCtrlFrame.luLabel     -in .lightCtrlFrame.statusFrame  -x  24 -y  22
    place .lightCtrlFrame.luTimeL     -in .lightCtrlFrame.statusFrame  -x  94 -y  22
    place .lightCtrlFrame.sampleCount -in .lightCtrlFrame.statusFrame  -x  24 -y  46
    
    place .lightCtrlFrame.statusFrame       -in .lightCtrlFrame -x 12 -y  160

    frame .lightCtrlFrame.pwmOvrFrame -bd 3 -relief groove \
        -padx 0 -pady 0 -bg $ams_gray25 -height 90 -width 150

    label .lightCtrlFrame.pwmOvrLabel  -text "PWM Override" -fg $ams_gray95  -bg $ams_gray25
    label .lightCtrlFrame.pwmOvrStatus -text "Status:"      -fg $ams_gray95  -bg $ams_gray25
    label .lightCtrlFrame.pwmOvrValue  -text "Not active"   -fg $ams_gray95  -bg $ams_gray25
    button .lightCtrlFrame.pwmOvrReset -text " Reset " -command { doSyncCommand doPwmOvrReset } -state normal \
        -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95

    place .lightCtrlFrame.pwmOvrLabel   -in .lightCtrlFrame.pwmOvrFrame  -x   4 -y   4
    place .lightCtrlFrame.pwmOvrStatus  -in .lightCtrlFrame.pwmOvrFrame  -x  24 -y  22
    place .lightCtrlFrame.pwmOvrValue   -in .lightCtrlFrame.pwmOvrFrame  -x  65 -y  22
    place .lightCtrlFrame.pwmOvrReset   -in .lightCtrlFrame.pwmOvrFrame  -x  50 -y  49
    
    if { ([checkForNewFwVersion { 21 }] == true) } {
        doShowPwmOvrStatus        
        place .lightCtrlFrame.pwmOvrFrame       -in .lightCtrlFrame -x 586 -y  160
    }
    
    place .lightCtrlFrame    -in .theNoteBook.colortuning.dFrame  -x 20  -y 16

    # ------------------------ Status Panel
    frame .statusFrame -bd 3 -relief raised \
        -padx 0 -pady 0 -bg $ams_gray25 -height 112 -width 760
    label .statusFrame.slabel -text "Managed Metrics" -font {system -8 bold} -fg $ams_gray95 -bg $ams_gray25

    label .statusFrame.loggingStatusLabel -text "" -fg $ams_gray95 -bg $ams_gray25
    
    set statusLastEvent 0
    label .statusFrame.eventL -text "Last Event:" -fg $ams_gray95 -bg $ams_gray25
    label .statusFrame.eventV -text "" -fg $ams_gray95 -bg $ams_gray25
    set lastEventWidget .statusFrame.eventV
    
    place .statusFrame.slabel             -in .statusFrame  -x   4 -y 0
    place .statusFrame.loggingStatusLabel -in .statusFrame  -x 400 -y 0
    place .statusFrame.eventL             -in .statusFrame  -x 175 -y 0
    place .statusFrame.eventV             -in .statusFrame  -x 245 -y 0

    frame .statusFrame.pwmMixFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.pwmMixFrame.l -text "Color Tune" -justify left -width 9
    label .statusFrame.pwmMixFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.pwmMixFrame.l .statusFrame.pwmMixFrame.v -in .statusFrame.pwmMixFrame -side left
    set colorTuneSliderWidget .statusFrame.pwmMixFrame.v
    set colorTuneATLED23MWidget .statusFrame.pwmMixFrame.v
    
    frame .statusFrame.cctFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.cctFrame.l -text "Current CCT" -justify left -width 10
    label .statusFrame.cctFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.cctFrame.l .statusFrame.cctFrame.v -in .statusFrame.cctFrame -side left
    
    frame .statusFrame.cctTFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.cctTFrame.l -text "Target CCT" -justify left -width 9
    label .statusFrame.cctTFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.cctTFrame.l .statusFrame.cctTFrame.v -in .statusFrame.cctTFrame -side left
    
    frame .statusFrame.pwmTFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.pwmTFrame.l -text "Color Tune" -justify left -width 9
    label .statusFrame.pwmTFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.pwmTFrame.l .statusFrame.pwmTFrame.v -in .statusFrame.pwmTFrame -side left
    # set colorTuneSliderWidget .statusFrame.pwmTFrame.v
    # set colorTuneATLED23MWidget .statusFrame.pwmTFrame.v
    
    frame .statusFrame.pcOutputFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.pcOutputFrame.l -text "Dimming" -justify left -width 9
    label .statusFrame.pcOutputFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.pcOutputFrame.l .statusFrame.pcOutputFrame.v -in .statusFrame.pcOutputFrame -side left

    frame .statusFrame.luxFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.luxFrame.l -text "Current Lux" -justify left -width 10
    label .statusFrame.luxFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.luxFrame.l .statusFrame.luxFrame.v -in .statusFrame.luxFrame -side left

    frame .statusFrame.luxTFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.luxTFrame.l -text "Target Lux" -justify left -width 9
    label .statusFrame.luxTFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 6 -anchor e
    pack .statusFrame.luxTFrame.l .statusFrame.luxTFrame.v -in .statusFrame.luxTFrame -side left

    frame .statusFrame.timeFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.timeFrame.l -text "Time" -justify left -width 4
    label .statusFrame.timeFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 7 -anchor e
    pack .statusFrame.timeFrame.l .statusFrame.timeFrame.v -in .statusFrame.timeFrame -side left

    frame .statusFrame.dayFrame -bd 2 -relief raised -padx 2 -pady 1
    label .statusFrame.dayFrame.l -text "Day" -justify left -width 4
    label .statusFrame.dayFrame.v -text "" -justify center \
        -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
        -font {system -12 bold} -width 7 -anchor e
    pack .statusFrame.dayFrame.l .statusFrame.dayFrame.v -in .statusFrame.dayFrame -side left

    if { $haveTempX } {
        frame .statusFrame.tempxFrame -bd 2 -relief raised -padx 2 -pady 1
        label .statusFrame.tempxFrame.l -text "Amb Temp" -justify left -width 9
        label .statusFrame.tempxFrame.v -text "" -justify center \
            -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
            -font {system -12 bold} -width 6 -anchor e
        pack .statusFrame.tempxFrame.l .statusFrame.tempxFrame.v -in .statusFrame.tempxFrame -side left
    }

    if { $haveRhX } {
        frame .statusFrame.rhxFrame -bd 2 -relief raised -padx 2 -pady 1
        label .statusFrame.rhxFrame.l -text "Rel Humid" -justify left -width 9
        label .statusFrame.rhxFrame.v -text "" -justify center \
            -bg $ams_gray10 -fg $ams_gray95 -relief sunken -bd 3 \
            -font {system -12 bold} -width 6 -anchor e
        pack .statusFrame.rhxFrame.l .statusFrame.rhxFrame.v -in .statusFrame.rhxFrame -side left
    }
    
    if { $haveTempX || $haveRhX } {
        place .statusFrame.pwmMixFrame -in .statusFrame         -x 16  -y $colorControlY1

        place .statusFrame.cctFrame  -in .statusFrame           -x 166 -y $colorControlY1

        if { $colorTuningState } {
            place .statusFrame.cctTFrame  -in .statusFrame      -x 328 -y $colorControlY1
        } else {
            # place .statusFrame.pwmTFrame  -in .statusFrame      -x 328 -y $colorControlY1
        }

        place .statusFrame.pcOutputFrame -in .statusFrame       -x 16  -y $colorControlY2

        place .statusFrame.luxFrame -in .statusFrame            -x 166 -y $colorControlY2

        if { $daylightingState } {
            place .statusFrame.luxTFrame -in .statusFrame       -x 328 -y $colorControlY2
        }

        place .statusFrame.timeFrame -in .statusFrame           -x 484 -y $colorControlY1
        place .statusFrame.dayFrame -in .statusFrame            -x 484 -y $colorControlY2

        if { $haveTempX } {
            place .statusFrame.tempxFrame -in .statusFrame      -x 614 -y $colorControlY1
        }
        if { $haveRhX } {
            place .statusFrame.rhxFrame -in .statusFrame        -x 614 -y $colorControlY2
        }
    } else {
        place .statusFrame.pwmMixFrame -in .statusFrame         -x 20  -y $colorControlY1

        place .statusFrame.cctFrame  -in .statusFrame           -x 200 -y $colorControlY1

        if { $colorTuningState } {
            place .statusFrame.cctTFrame  -in .statusFrame      -x 410 -y $colorControlY1
        } else {
            # place .statusFrame.pwmTFrame  -in .statusFrame      -x 410 -y $colorControlY1
        }

        place .statusFrame.pcOutputFrame -in .statusFrame       -x 20  -y $colorControlY2

        place .statusFrame.luxFrame -in .statusFrame            -x 200 -y $colorControlY2

        if { $daylightingState } {
            place .statusFrame.luxTFrame -in .statusFrame       -x 410 -y $colorControlY2
        }

        place .statusFrame.timeFrame -in .statusFrame           -x 620 -y $colorControlY1
        place .statusFrame.dayFrame -in .statusFrame            -x 620 -y $colorControlY2
    }
    place .statusFrame -in .theNoteBook.colortuning.dFrame -x 20 -y 288

    set sampleWidgetNames "Sample, Color Tune (%), Current CCT, Dimming (%), Current Lux, Device Time, Device Day"

    set lWidgets [list $colorTuneATLED23MWidget \
                       .statusFrame.cctFrame.v \
                       .statusFrame.pcOutputFrame.v \
                       .statusFrame.luxFrame.v \
                       .statusFrame.timeFrame.v \
                       .statusFrame.dayFrame.v]
    set lUpdateProcs [list updateColorTunePercent \
                           updateText \
                           updateTextDimmingPercent  \
                           updateText \
                           updateTimeOfDay \
                           updateDayOfWeek]

    if { $haveTempX } {
        append sampleWidgetNames ", Amb Temp"
        lappend lWidgets .statusFrame.tempxFrame.v
        lappend lUpdateProcs updateTempC
    }
    if { $haveRhX } {
        append sampleWidgetNames ", Rel Humid"
        lappend lWidgets .statusFrame.rhxFrame.v
        lappend lUpdateProcs updateRhXPercent
    }
    append sampleWidgetNames ", Int Time, Gain, Temp, Timestamp"

    set lWidgetHighIndex [expr [llength $lWidgets] - 1]
}

proc doShowPwmOvrStatus {} {
    global responseIsError
    global lastnum

    set pwmOvrStatus ""
    doATcommand "ATPWMOVR"
    if { $responseIsError == 0 } {
        if { ($lastnum == 0) } {
            set pwmOvrStatus "Not Active"
        } else {
            set pwmOvrStatus [format " Active (0x%02X)" $lastnum]
        }
    }
    .lightCtrlFrame.pwmOvrValue configure -text $pwmOvrStatus   
}

proc doPwmOvrReset {} {
    global responseIsError
    global lastnum
    
    set resetAll true
    doATcommand "ATPWMOVR"
    if { $responseIsError == 0 } {
        set resetAll false
    }
    if { $resetAll == true } {
        doATcommand "ATXPWM1=102"
        doATcommand "ATXPWM2=102"
        doATcommand "ATXPWM3=102"
        doATcommand "ATPWM1=102"
        doATcommand "ATPWM2=102"
        doATcommand "ATPWM3=102"
    } elseif { [expr $lastnum & 0x01] != 0 } {
        doATcommand "ATXPWM1=102"
    } elseif { [expr $lastnum & 0x02] != 0 } {
        doATcommand "ATXPWM2=102"
    } elseif { [expr $lastnum & 0x04] != 0 } {
        doATcommand "ATXPWM3=102"
    } elseif { [expr $lastnum & 0x10] != 0 } {
        doATcommand "ATPWM1=102"
    } elseif { [expr $lastnum & 0x20] != 0 } {
        doATcommand "ATPWM2=102"
    } elseif { [expr $lastnum & 0x40] != 0 } {
        doATcommand "ATPWM3=102"
    }
    
    doShowPwmOvrStatus    
}

proc doUpdateCheckWeb {} {
    puts "doUpdateCheckWeb Not yet implemented..."
}

proc doUpdateVersion {} {
    global isFwDownloadTool
    global responseIsError
    global lastnum
    global hwModel
    global burnInput
    global swVersion

    # Ignore the header output
    # set burnInput 1
    # Wait a few seconds
    set vwaitVar 0
    after 3000 set vwaitVar 1
    vwait vwaitVar
    set burnInput 0
    doATcommand "ATVERSW"
    #    puts "ATVERSW response $lastnum"
    if { $responseIsError == 0 } {
        #	puts "lastnum=$lastnum"
        set swVersion $lastnum
        set noDots [string map {"." ""} $swVersion]
        if { [string length $swVersion] == [string length $noDots] } {
            puts "### Bad SW version found: $swVersion"
        }
        .fwFrame.fwVLF.fwVersion configure -text "$swVersion"
        
        # check for FW download tool
        if { $isFwDownloadTool == 0 } {
            if { ($hwModel == 0) || ($hwModel == 61) || ($hwModel == 11) || ($hwModel == 21) } {
                .deviceFrameL.fwlf.l configure -text "$swVersion"
            }
            if { ($hwModel == 11) || ($hwModel == 21) } {
                .deviceFrame.fwlf.l configure -text "$swVersion"
            }
        }
    }
}

proc doUpdateFirmware {} {
    global isFwDownloadTool
    global autoRunning
    global hwModel
    global passwordIsValid
    global bPasswordModeAuto
    global firmwarefiletypes
    global firmwareFileName
    global firmwareFile
    global responseIsError
    global quietMode
    global atCommandTimeout

    if { $autoRunning } {
        tk_messageBox -icon error  \
            -detail "Please stop continuous sampling prior to updating the firmware." \
            -message "Firmware update error." -title "ams User Error" -type ok
        return
    }
    if { ($hwModel == 21) && ([checkForNewFwVersion { 21 }] == false) && (($passwordIsValid == 0) || ($bPasswordModeAuto == 0)) } {
        # check for FW download tool
        if { $isFwDownloadTool == 1 } {
            tk_messageBox -icon error  \
                -detail "Password is required to update the firmware.\nPlease enter valid password using the Console tab\nor use the Dashboard software for firmware update." \
                -message "Firmware update error." -title "ams User Error" -type ok
            return
        } else {
            tk_messageBox -icon error  \
                -detail "Password is required to update the firmware.\nPlease go to Logging & Control tab,\nenter a valid Password and\nset Mode to Auto\nprior to updating the firmware." \
                -message "Firmware update error." -title "ams User Error" -type ok
            return
        }
    }
    if { ($hwModel == 65) && ([checkForNewFwVersion { 65 }] == false) } {
        set answer [tk_messageBox -icon warning  \
            -detail "Update to firmware versions >= 11 is not useful because of pinning changes." \
            -message "Firmware update warning." -title "ams User Warning" -type okcancel]
        if { $answer != "ok" } {
            return
        }
    }
    
    .fwFrame.updateFWB configure -state disabled
    .fwFrame.revertFWB configure -state disabled

    # The file is already open.  Get the CRC16 value first.
    seek $firmwareFile -2 end
    set crc16bin [read $firmwareFile 2]
    binary scan $crc16bin H* crc16
    #    puts "CRC16 is $crc16"
    # Bump up the timeout value to account for flash erase time.
    set toTmp $atCommandTimeout
    set atCommandTimeout 10000
    # Start the update by sending the CRC16
    doATcommand "ATFWU=0x$crc16"
    if { $responseIsError } {
        .fwFrame.statusL configure -text "Update Failed (ATFWU)"
        close $firmwareFile
        set firmwareFileName ""
        .fwFrame.fwLF.fwFileL configure -text $firmwareFileName
        .fwFrame.revertFWB configure -state normal
        return
    }

    seek $firmwareFile 0 start
    set bytesSent 0
    set responseIsError 0
    # Don't show the binary image
    #set quietMode 1
    set loopcount 0
    set percentdone 0
    set retries 0
    .fwFrame.statusL configure -text "Working... ($percentdone%)"

    while { $bytesSent < 57344 } {
        if { $responseIsError == 0 } {
            # Read next bytes if last succeeded
            set bytesbin [read $firmwareFile 7]
            binary scan $bytesbin H* byteshex
        }
        #	puts "ATFW=$byteshex"
        doATcommand "ATFW=$byteshex"
        if { $responseIsError == 0 } {
            # Advance only if no error
            set bytesSent [expr $bytesSent + 7]
            set retries 0
            incr loopcount
            # Advance to the next address to write more bytes.
            #	    puts "ATFWA"
            doATcommand "ATFWA"

            if { [expr $loopcount & 31] == 0 } {
                set percentdone [format %d [expr [expr $loopcount * 700] / 57344]]
                .fwFrame.statusL configure -text "Working... ($percentdone%)"
            }
            if { (($hwModel == 11) || ($hwModel == 21)) && ([expr $loopcount & 255] == 0) } {
                doUpdatePasswordTimer
            }
        } else {
            incr retries
            if { $retries > 20 } {
                .fwFrame.statusL configure -text "Error... ($percentdone%)"
                set vwaitVar 0
                after 5000 set vwaitVar 1
                vwait vwaitVar
                break
            }
        }
    }
    #set quietMode 0

    if { $retries != 0 } {
        puts "Failed on loop $loopcount"
        .fwFrame.statusL configure -text "Update Failed (loop)"
    } else {
        # Finally, change to the newly loaded image
        set vwaitVar 0
        after 1000 set vwaitVar 1
        vwait vwaitVar
        doATcommand "ATFWS"
        if { $responseIsError != 0 } {
            puts "Failed on ATFWS"
            .fwFrame.statusL configure -text "Update Failed (ATFWS)"
        } else {
            # get new firmware version
            doUpdateVersion
            if { $responseIsError != 0 } {
                puts "Failed on ATVERSW"
                .fwFrame.statusL configure -text "Update Failed (ATVERSW)"
            } else {
                if { ([checkForNewFwVersion { 21 61 62 63 65 }] == true) } {
                    doATcommand "ATFWL"
                    if { $responseIsError != 0 } {
                        puts "Failed on ATFWL"
                        .fwFrame.statusL configure -text "Update Failed (ATFWL)"
                    }
                }
                if { $responseIsError == 0 } {
                    .fwFrame.statusL configure -text "Update Succeeded"
                    set vwaitVar 0
                    after 3000 set vwaitVar 1
                    vwait vwaitVar
                    .fwFrame.statusL configure -text "Restarting..."
                    set vwaitVar 0
                    after 3000 set vwaitVar 1
                    vwait vwaitVar
                    exec [info nameofexecutable] [info script] &
                    exit
                }
            }
        }
    }
    # Restore the previous timeout.
    set atCommandTimeout $toTmp

    close $firmwareFile
    set firmwareFileName ""
    .fwFrame.fwLF.fwFileL configure -text $firmwareFileName
    .fwFrame.updateFWB configure -state disabled
    .fwFrame.revertFWB configure -state normal
}

proc doRevertFW {} {
    global isFwDownloadTool
    global autoRunning
    global hwModel
    global passwordIsValid
    global responseIsError
    global atCommandTimeout

    if { $autoRunning } {
        tk_messageBox -icon error  \
            -detail "Please stop continuous sampling prior to reverting the firmware." \
            -message "Firmware revert error." -title "ams User Error" -type ok
        return
    }
    if { ($hwModel == 21) && ([checkForNewFwVersion { 21 }] == false) && ($passwordIsValid == 0) } {
        # check for FW download tool
        if { $isFwDownloadTool == 1 } {
            tk_messageBox -icon error  \
                -detail "Password is required to revert the firmware.\nPlease enter valid password using the Console tab\nor use the Dashboard software for firmware revert." \
                -message "Firmware revert error." -title "ams User Error" -type ok
            return
        } else {
            tk_messageBox -icon error  \
                -detail "Password is required to revert the firmware.\nPlease enter valid password prior to reverting the firmware." \
                -message "Firmware revert error." -title "ams User Error" -type ok
            return
        }
    }
    
    .fwFrame.revertFWB configure -state disabled
    set upState [.fwFrame.updateFWB cget -state ]

    # Bump up the timeout value.
    set toTmp $atCommandTimeout
    set atCommandTimeout 10000

    .fwFrame.statusL configure -text "Reverting Version..."
    doATcommand "ATFWS"
    if { $responseIsError != 0 } {
        puts "Failed on ATFWS"
        .fwFrame.statusL configure -text "Revert Failed (ATFWS)"
    } else {
        # get new firmware version
        doUpdateVersion
        if { $responseIsError != 0 } {
            puts "Failed on ATVERSW"
            .fwFrame.statusL configure -text "Revert Failed (ATVERSW)"
        } else {
            if { ([checkForNewFwVersion { 21 61 62 63 65 }] == true) } {
                doATcommand "ATFWL"
                if { $responseIsError != 0 } {
                    puts "Failed on ATFWL"
                    .fwFrame.statusL configure -text "Revert Failed (ATFWL)"
                }
            }
            if { $responseIsError == 0 } {
                .fwFrame.statusL configure -text "Revert Succeeded"
                set vwaitVar 0
                after 3000 set vwaitVar 1
                vwait vwaitVar
                .fwFrame.statusL configure -text "Restarting..."
                set vwaitVar 0
                after 3000 set vwaitVar 1
                vwait vwaitVar
                exec [info nameofexecutable] [info script] &
                exit
            }
        }
    }
    # Restore the previous timeout.
    set atCommandTimeout $toTmp

    .fwFrame.revertFWB configure -state normal
    .fwFrame.updateFWB configure -state $upState
}

proc doSelectLocalFW {} {
    global firmwarefiletypes
    global firmwareFileName
    global firmwareFile

    set firmwareFileName [tk_getOpenFile -title "Select Firmware Image File" -filetypes $firmwarefiletypes -parent .]
    #    puts "File name is $firmwareFileName"
    if { ($firmwareFileName != "") && ($firmwareFileName != "1")} {
        if { ! [string match "*.bin" $firmwareFileName] } {
            set firmwareFileName "$firmwareFileName.bin"
        }
        .fwFrame.fwLF.fwFileL configure -text $firmwareFileName
        .fwFrame.updateFWB configure -state normal
        set firmwareFile [open $firmwareFileName r]
        fconfigure $firmwareFile -translation binary
    } else {
        .fwFrame.fwLF.fwFileL configure -text "<none>                            "
        .fwFrame.updateFWB configure -state disabled
    }
    .fwFrame.statusL configure -text ""
}

proc DoFirmwareUpdateDisplay {} {
    global ams_gray10
    global ams_gray25
    global ams_gray95
    global ams_blue
    global ams_green
    global ams_red
    global swVersion
    global firmwareFileName
    global firmwareFile

    # ------------------------ Firmware Update Control
    frame .fwFrame -bd 3 -relief raised -padx 2 -pady 2 \
        -width 550 -height 280 -background $ams_gray25

    label .fwFrame.label -text "Firmware Update" -font {system -8 bold} \
        -bg $ams_gray25 -fg $ams_gray95

    button .fwFrame.checkWebB -text    "     Check Web for Updates      " -command { doSyncCommand doUpdateCheckWeb } \
        -state disabled -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    button .fwFrame.selectLocalB -text " Select Local Firmware Image " -command { doSyncCommand doSelectLocalFW } \
        -state normal -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    button .fwFrame.updateFWB -text    "           Update Firmware          " -command { doUpdateFirmware } \
        -state disabled -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95
    button .fwFrame.revertFWB -text    " Revert to Previous Firmware " -command { doRevertFW } \
        -state normal -relief raised -bd 2 -highlightbackground $ams_gray25 -bg $ams_gray25 -fg $ams_gray95

    labelframe .fwFrame.fwVLF -text "Current Firmware Version" -font {-size 9 -weight bold} -width 20 -height 60 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove -bd 3
    label .fwFrame.fwVLF.fwVersion -text " $swVersion    " -justify right \
        -font "-family helvetica -size 10 -slant italic" -width 24 -bg $ams_gray25 -fg $ams_gray95
    pack .fwFrame.fwVLF.fwVersion -in .fwFrame.fwVLF -expand 1 -fill x

    labelframe .fwFrame.fwLF -text "Firmware Image Selection" -font {-size 9 -weight bold} -width 90 -height 60 \
        -fg $ams_gray95 -bg $ams_gray25 -relief groove -bd 3
    label .fwFrame.fwLF.fwFileL -text "<none>                            " -justify right \
        -font "-family helvetica -size 10 -slant italic" -width 56 -bg $ams_gray25 -fg $ams_gray95
    pack .fwFrame.fwLF.fwFileL -in .fwFrame.fwLF -expand 1 -fill x

    label .fwFrame.statusL -text "" -fg $ams_gray95 -bg $ams_gray25

    place .fwFrame.label             -in .fwFrame -x  4   -y   4
    # place .fwFrame.checkWebB         -in .fwFrame -x  40  -y   50
    place .fwFrame.selectLocalB      -in .fwFrame -x  40  -y   100
    place .fwFrame.updateFWB         -in .fwFrame -x  336 -y   50
    place .fwFrame.revertFWB         -in .fwFrame -x  336 -y   100
    place .fwFrame.fwVLF             -in .fwFrame -x  160 -y   150
    place .fwFrame.fwLF              -in .fwFrame -x  40  -y   200
    place .fwFrame.statusL           -in .fwFrame -x  224 -y   78
    place .fwFrame    -in .theNoteBook.fwUpdate.rFrame  -x 120  -y 40

}

# this is a tricky workaround to update the console window
# if it was set in an other then the console tabulator
proc doUpdateConsole {} {
    global updateConsole    

    if { $updateConsole == false } {
        .consoleTextFrame.txt insert 1.0 "\n"
        set updateConsole true
    } else {
        .consoleTextFrame.txt delete 1.0
        set updateConsole false
    }
    .consoleTextFrame.txt see end
    .consoleTextFrame.txt yview moveto 1    
}

proc DoTabChange {} {
    global currentTab
    global hwModel
    global responseIsError
    global lastnum

    # get current tab
    set currentTab [.theNoteBook select]
    
    # change tab changed callback function to prevent tab changing during update processing
    bind .theNoteBook <<NotebookTabChanged>> DoTabChangeDisable

    # run all update commands
    doUpdateCommands $currentTab
    
    # check for console tab
    set consoleTab .theNoteBook.console
    if { $currentTab == $consoleTab } {
        after 10 doUpdateConsole
    }

    if { 0 } {
        if { ($hwModel >= 61) && ($hwModel <= 63) } {
            doATcommand "ATTCSMD"
            if { $responseIsError == 0 } {
                set tcsMode $lastnum
            }
            if { $hwModel == 61 } {
                doTCSmodeSelect61
            }
            if { 0 } {
                if { ($hwModel == 62) || ($hwModel == 63) } {
                    doTCSmodeSelect62n3
                }
            }
        }
    }

    # restore tab changed callback function
    bind .theNoteBook <<NotebookTabChanged>> { doSyncCommand DoTabChange }
}

proc DoTabChangeDisable {} {
    global currentTab
    
    .theNoteBook select $currentTab    
}

proc doUpdateCommands { currentTab } {
    global updateCmds
    global hwModel
    global responseIsError
    global lastnum
    # these variables are required by update commands
    global targetPWMmixVal    
    global targetCCTVal    
    global targetLuxVal    
    global updateButtonState
    global tcsMode
    
    # puts "+"
    # loop for all update commands
    set lastCmdNum 0
    foreach { hwVersion notebookPage atCmd tclCmd } $updateCmds {
        # check for update
        if { ($hwModel == $hwVersion) && ($currentTab == $notebookPage) } {
            if { $atCmd != "" } {
                # puts "Update AT command: $atCmd"
                doATcommand $atCmd
            } else {
                set responseIsError 0
            }
            if { ($tclCmd != "") && ($responseIsError == 0) } {
                # puts "Update AT command: $atCmd, lastnum: $lastnum"
                # puts "lastnum: $lastnum, lastCmdNum: $lastCmdNum"
                
                eval $tclCmd
                
                # if { [string first "ATLED23M" $atCmd] != -1 } {
                    #     puts "update cmd: $atCmd, lastnum: $lastnum, targetPWMmixVal: $targetPWMmixVal"
                    # }
            }
        }
    }
    # puts "-"
}

proc DoMainDisplay {} {
    global isFwDownloadTool
    global portname
    global again
    global againstring
    global vOverwrite
    global vLogging
    global lWidgetHighIndex
    global guiTitle
    global guiVersion
    global amslogo
    global amslogofile
    global hwVersion
    global hwModel
    global ams_gray25
    global ams_gray10
    global ams_gray95
    global ams_blue
    global platform
    global showFilterTab
    global showPulseRateTab
    global showSKtab
    global passwordLastSetTime

    wm title . "$guiTitle  $guiVersion"
    if { $platform == "win32" } {
        wm geometry . 800x500
    } else {
        wm geometry . 900x500
    }
    # Fixed window dimensions, so disable resizing.
    wm resizable . 0 0

    # Create a small banner area at the top to display the ams logo.
    #    set amslogo [image create photo -file ./ams_logo_xparent_h80.gif -format gif ]
    canvas .bannerCanvas -relief raised -bd 3 -height 50 -background $ams_gray25
    pack .bannerCanvas -side top -fill x
    if { [ file exists $amslogofile ] } {
        set amslogo [image create photo]
        $amslogo read  "./ams_logo_xparent_h30.gif"
        .bannerCanvas create image 730 32 -image $amslogo
    }

    # show status line
    label .mainStatusLine -justify left -bg $ams_gray25 -fg $ams_gray95
    pack .mainStatusLine -side left -expand 1 -fill x
    .mainStatusLine configure -text "Read device data..."

    # Create a tabbed notebook.
    ttk::notebook .theNoteBook
    set muChar [format %c 181]
    
    # check for FW download tool
    if { $isFwDownloadTool == 1 } {
        switch -- $hwModel {
            62 {
                append devname "AS7262 Firmware Update"
            }
            63 {
                append devname "AS7263 Firmware Update"
            }
            61 {
                append devname "AS7261 Firmware Update"
            }
            65 {
                append devname "AS72651/AS72652/AS72653 Firmware Update"
            }
            25 {
                append devname "AS7225 Firmware Update"
            }
            11 {
                append devname "AS7211 Firmware Update"
            }
            21 {
                append devname "AS7221 Firmware Update"
            }
            default {
                append devname "AS72xx Firmware Update"
            }
        }
        label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
            -background $ams_gray25 -foreground $ams_blue
    
        ttk::frame .theNoteBook.console
        frame .theNoteBook.console.cFrame -bg $ams_gray10
        pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
        
        ttk::frame .theNoteBook.fwUpdate
        frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
        pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
        
        .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
        .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"

        DoConsoleDisplay
        DoFirmwareUpdateDisplay
        
        .theNoteBook select .theNoteBook.fwUpdate
    } else {
        # Fill in the tabs based on the device type (already set on entry to this proc).
        switch -- $hwModel {
            62 {
                append devname "AS7262 Spectral Radiometer"
                #       puts "device $devname"
                label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
                -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.s62Sensor
                frame .theNoteBook.s62Sensor.sFrame -bg $ams_gray10
                pack .theNoteBook.s62Sensor.sFrame -in .theNoteBook.s62Sensor -fill both -expand 1
                
                if { $showSKtab } {
                    ttk::frame .theNoteBook.skProcessing
                    frame .theNoteBook.skProcessing.skFrame -bg $ams_gray10
                    pack .theNoteBook.skProcessing.skFrame -in .theNoteBook.skProcessing -fill both -expand 1
                }
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                if { ([checkForNewFwVersion { 62 }] == false) } {
                    .theNoteBook add .theNoteBook.s62Sensor -text "Spectral Sensor" -sticky "news"
                    if { $showSKtab } {
                        .theNoteBook add .theNoteBook.skProcessing -text "Authentication" -sticky "news"
                    }
                    .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                }
                
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                Do7262SensorDisplay
                if { $showSKtab } {
                    DoskProcessingDisplay
                }
                DoLoggingDisplay
                DoConsoleDisplay
                DoFirmwareUpdateDisplay
                
                if { ([checkForNewFwVersion { 62 }] == false) } {
                    .theNoteBook select .theNoteBook.s62Sensor
                } else {
                    .theNoteBook select .theNoteBook.fwUpdate
                }
            }
            63 {
                append devname "AS7263 nIR Spectral Radiometer"
                #       puts "device $devname"
                label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
                -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.nIRSensor
                frame .theNoteBook.nIRSensor.sFrame -bg $ams_gray10
                pack .theNoteBook.nIRSensor.sFrame -in .theNoteBook.nIRSensor -fill both -expand 1
                
                if { $showSKtab } {
                    ttk::frame .theNoteBook.skProcessing
                    frame .theNoteBook.skProcessing.skFrame -bg $ams_gray10
                    pack .theNoteBook.skProcessing.skFrame -in .theNoteBook.skProcessing -fill both -expand 1
                }
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                if { ([checkForNewFwVersion { 63 }] == false) } {
                    .theNoteBook add .theNoteBook.nIRSensor -text "nIR Sensor" -sticky "news"
                    if { $showSKtab } {
                        .theNoteBook add .theNoteBook.skProcessing -text "Authentication" -sticky "news"
                    }
                    .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                }
                
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                Do7263nIRSensorDisplay
                if { $showSKtab } {
                    DoskProcessingDisplay
                }
                DoLoggingDisplay
                DoConsoleDisplay
                DoFirmwareUpdateDisplay
                
                if { ([checkForNewFwVersion { 63 }] == false) } {
                    .theNoteBook select .theNoteBook.nIRSensor
                } else {
                    .theNoteBook select .theNoteBook.fwUpdate
                }
            }
            61 {
                append devname "AS7261 XYZ Spectral Radiometer"
                #       puts "device $devname"
                label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
                -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.spectralSensor
                frame .theNoteBook.spectralSensor.sFrame -bg $ams_gray10
                pack .theNoteBook.spectralSensor.sFrame -in .theNoteBook.spectralSensor -fill both -expand 1
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                if { $showFilterTab } {
                    ttk::frame .theNoteBook.rtProcessing
                    frame .theNoteBook.rtProcessing.rFrame -bg $ams_gray10
                    pack .theNoteBook.rtProcessing.rFrame -in .theNoteBook.rtProcessing -fill both -expand 1
                }
                
                if { $showPulseRateTab } {
                    ttk::frame .theNoteBook.hrProcessing
                    frame .theNoteBook.hrProcessing.rFrame -bg $ams_gray10
                    pack .theNoteBook.hrProcessing.rFrame -in .theNoteBook.hrProcessing -fill both -expand 1
                }
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                if { ([checkForNewFwVersion { 61 }] == false) } {
                    .theNoteBook add .theNoteBook.spectralSensor -text "Spectral Sensor" -sticky "news"
                    .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                    if { $showFilterTab } {
                        .theNoteBook add .theNoteBook.rtProcessing -text "Real-Time Processing" -sticky "news"
                    }
                    if { $showPulseRateTab } {
                        .theNoteBook add .theNoteBook.hrProcessing -text "Pulse Rate" -sticky "news"
                    }
                }
                
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                Do7261SpectralSensorDisplay
                DoLoggingDisplay
                if { $showFilterTab } {
                    DoRealTimeDisplay
                }
                if { $showPulseRateTab } {
                    DoPulseRateDisplay
                }
                DoConsoleDisplay
                DoFirmwareUpdateDisplay
                
                if { ([checkForNewFwVersion { 61 }] == false) } {
                    .theNoteBook select .theNoteBook.spectralSensor
                } else {
                    .theNoteBook select .theNoteBook.fwUpdate
                }
            }
            65 {
                append devname "AS72651/AS72652/AS72653 18 Channel Spectral Radiometer"
                #       puts "device $devname"
                label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
                -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.moonlightSensor
                frame .theNoteBook.moonlightSensor.sFrame -bg $ams_gray10
                pack .theNoteBook.moonlightSensor.sFrame -in .theNoteBook.moonlightSensor -fill both -expand 1
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                .theNoteBook add .theNoteBook.moonlightSensor -text "18 Channel Sensor" -sticky "news"
                .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                .theNoteBook select .theNoteBook.moonlightSensor
                
                Do7265SensorDisplay
                DoLoggingDisplay
                DoConsoleDisplay
                DoFirmwareUpdateDisplay
                if { $showSKtab } {
                    DoskProcessingDisplay
                }
            }
            25 {
                append devname "AS7225 Chromatic White Sensor"
                label .bannerCanvas.hwModelLabel -text "$devname" -font {system -22 bold} \
                -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.trueColorSensor
                frame .theNoteBook.trueColorSensor.sFrame -bg $ams_gray10
                pack .theNoteBook.trueColorSensor.sFrame -in .theNoteBook.trueColorSensor -fill both -expand 1
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                .theNoteBook add .theNoteBook.trueColorSensor -text "Chromatic White Sensor" -sticky "news"
                .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                .theNoteBook select .theNoteBook.trueColorSensor
                
                DoConsoleDisplay
                Do7225Display
                DoLoggingDisplay
                DoFirmwareUpdateDisplay
            }
            11 {
                puts "Setting up AS7211 GUI elements"
                label .bannerCanvas.hwModelLabel -text "AS7211 Smart Lighting Manager with Daylighting" \
                -font {system -22 bold} -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.daylighting
                frame .theNoteBook.daylighting.dFrame -bg $ams_gray10
                pack .theNoteBook.daylighting.dFrame -in .theNoteBook.daylighting -fill both -expand 1
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.scenes
                frame .theNoteBook.scenes.sFrame -bg $ams_gray10
                pack .theNoteBook.scenes.sFrame -in .theNoteBook.scenes -fill both -expand 1
                
                ttk::frame .theNoteBook.stats
                frame .theNoteBook.stats.sFrame -bg $ams_gray10
                pack .theNoteBook.stats.sFrame -in .theNoteBook.stats -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                .theNoteBook add .theNoteBook.daylighting -text "Daylighting" -sticky "news"
                .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                .theNoteBook add .theNoteBook.scenes  -text "Scenes"  -sticky "news"
                .theNoteBook add .theNoteBook.stats   -text "Statistics" -sticky "news"
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                .theNoteBook select .theNoteBook.daylighting
                puts "Done setting up AS7211 GUI elements"
                
                DoConsoleDisplay
                puts "Done creating Console tab"
                Do7211DaylightingDisplay
                puts "Done creating Console Daylighting tab"
                DoLoggingDisplay
                puts "Done creating Logging display"
                DoStatisticsDisplay
                puts "Done creating Statistics display"
                DoScenesDisplay
                puts "Done creating Scenes display"
                DoFirmwareUpdateDisplay
                puts "Done creating FW Update display"
            }
            21 {
                label .bannerCanvas.hwModelLabel \
                -text "AS7221 Smart Lighting Manager with Color Tuning and Daylighting" \
                -font {system -22 bold} -background $ams_gray25 -foreground $ams_blue
                
                ttk::frame .theNoteBook.colortuning
                frame .theNoteBook.colortuning.dFrame -bg $ams_gray10
                pack .theNoteBook.colortuning.dFrame -in .theNoteBook.colortuning -fill both -expand 1
                
                ttk::frame .theNoteBook.logging
                frame .theNoteBook.logging.lFrame -bg $ams_gray10
                pack .theNoteBook.logging.lFrame -in .theNoteBook.logging -fill both -expand 1
                
                ttk::frame .theNoteBook.scenes
                frame .theNoteBook.scenes.sFrame -bg $ams_gray10
                pack .theNoteBook.scenes.sFrame -in .theNoteBook.scenes -fill both -expand 1
                
                ttk::frame .theNoteBook.stats
                frame .theNoteBook.stats.sFrame -bg $ams_gray10
                pack .theNoteBook.stats.sFrame -in .theNoteBook.stats -fill both -expand 1
                
                ttk::frame .theNoteBook.console
                frame .theNoteBook.console.cFrame -bg $ams_gray10
                pack .theNoteBook.console.cFrame -in .theNoteBook.console -fill both -expand 1
                
                ttk::frame .theNoteBook.fwUpdate
                frame .theNoteBook.fwUpdate.rFrame -bg $ams_gray10
                pack .theNoteBook.fwUpdate.rFrame -in .theNoteBook.fwUpdate -fill both -expand 1
                
                .theNoteBook add .theNoteBook.colortuning -text "Color Tuning" -sticky "news"
                .theNoteBook add .theNoteBook.logging -text "Logging & Control" -sticky "news"
                .theNoteBook add .theNoteBook.scenes  -text "Scenes"  -sticky "news"
                
                if { ([checkForNewFwVersion { 21 }] == false) } {
                    .theNoteBook add .theNoteBook.stats   -text "Statistics" -sticky "news"
                    
                    DoStatisticsDisplay
                }
                
                .theNoteBook add .theNoteBook.console -text "Console" -sticky "news"
                .theNoteBook add .theNoteBook.fwUpdate -text "Update" -sticky "news"
                
                .theNoteBook select .theNoteBook.colortuning
                
                if { ([checkForNewFwVersion { 21 }] == true) } {
                    # set password before configuration
                    set passwordLastSetTime 100
                }
                
                Do7221ColorTuningDisplay
                DoLoggingDisplay
                DoScenesDisplay
                DoConsoleDisplay
                DoFirmwareUpdateDisplay
            }
            default {
                tk_messageBox -icon error -message "Unrecognized hardware model: $hwModel, Version: $hwVersion." \
                -title "ams Detect HW Model Failure" -type ok
                # puts "Unrecognized hardware model:  $hwModel version $hwVersion"
                exit
            }
        }
    }

    # delete status line
    pack forget .mainStatusLine
    destroy .mainStatusLine
    
    # show notebook
    .bannerCanvas create window 10 18 -window .bannerCanvas.hwModelLabel -anchor nw
    pack .theNoteBook -expand 1 -side top -fill both

    # Enable ctrl-tab and ctrl-shift-tab to move right and left in tabs
    ttk::notebook::enableTraversal  .theNoteBook

    # Use a virtual event to get notified when the current tab changes.
    bind .theNoteBook <<NotebookTabChanged>> { doSyncCommand DoTabChange }

    if { 0 } {
        set vw 0
        after 240000 set vw 1
        vwait vw
        exit
    }
}

#proc tracer args { puts $args }

#trace add execution doUpdateButton { enter  leave } tracer
#trace add execution doAutoMode { enter  leave } tracer

DoPortSelect

wm protocol . WM_DELETE_WINDOW {
 #   DoSaveSettings
    exit
}

# Wait for quietMode to go to zero and get an initial sample
vwait quietMode

# check for FW download tool
if { $isFwDownloadTool == 1 } {
    while { true } {
        # Process events while we wait on the update button
        #    vwait updateButtonState
        set vwaitVar 0
        after 200 set vwaitVar 1
        vwait vwaitVar

        # Do any manually entered AT commands that may be pending
        doManualATcommands
    }
} else {
    doGetSampleSync
    
    while { true } {
        # Process events while we wait on the update button
        #    vwait updateButtonState
        set vwaitVar 0
        after 200 set vwaitVar 1
        vwait vwaitVar
        
        # Refresh the password timer.
        doUpdatePasswordTimer
        
        if { ($updateButtonState == 0) } {
            # For the '11 and '21, see if a slider has changed.
            if { $monitorSliders } {
                if { $hwModel == 11} {
                    doCheckSlider11
                } elseif { $hwModel == 21 } {
                    doCheckSlider21
                }
            }
            # Do any manually entered AT commands that may be pending
            doManualATcommands
        } elseif { ($updateButtonState == 1) } {
            # We're in manual mode.  Get a sample.
            set updateButtonState 0
            doGetSampleSync
        } elseif { $updateButtonState == 2 } {
            doAutoMode
        } elseif { $updateButtonState == 4 } {
            doBurstMode
        } elseif { $updateButtonState == 3 } {
            # Do any manually entered AT commands that may be pending
            doManualATcommands
        }
    }
}


#listports

