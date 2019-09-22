#Defines parameters for S1V30120

#Commands
#Boot mode
ISC_VERSION_REQ = 0x0005
ISC_BOOT_LOAD_REQ = 0x1000
ISC_BOOT_RUN_REQ = 0x1002
ISC_TEST_REQ = 0x0003

#Normal (run) mode

ISC_AUDIO_CONFIG_REQ = 0x0008
ISC_AUDIO_VOLUME_REQ = 0x000A
ISC_AUDIO_MUTE_REQ = 0x000C

ISC_TTS_CONFIG_REQ = 0x0012
#11 kHz
ISC_TTS_SAMPLE_RATE = 0x01 # Can't Change  
ISC_TTS_VOICE = 0x00
ISC_TTS_EPSON_PARSE = 0x01
ISC_TTS_LANGUAGE = 0x00
#200 words/min
ISC_TTS_SPEAK_RATE_LSB = 0x64 #0xC8
ISC_TTS_SPEAK_RATE_MSB = 0x00
ISC_TTS_DATASOURCE = 0x00

ISC_TTS_SPEAK_REQ = 0x0014

#Response messages
#Boot mode
ISC_VERSION_RESP = 0x0006
ISC_BOOT_LOAD_RESP = 0x1001
ISC_BOOT_RUN_RESP = 0x1003
ISC_TEST_RESP = 0x0004

#Normal (run) mode

ISC_AUDIO_CONFIG_RESP = 0x0009
ISC_AUDIO_VOLUME_RESP = 0x000B
ISC_AUDIO_MUTE_RESP = 0x000D

ISC_TTS_CONFIG_RESP = 0x0013


ISC_TTS_SPEAK_RESP = 0x0015

#Fatal error indication
ISC_ERROR_IND = 0x0000

#Request blocked
ISC_MSG_BLOCKED_RESP = 0x0007

ISC_TTS_FINISHED_IND = 0x0021



#Parameters

#Audio config
#See page 42 in S1V30120 Message Protocol Specification

#MONO = 0x00, all other values = reserved
TTS_AUDIO_CONF_AS = 0x00

#Audio gain = +18 db
TTS_AUDIO_CONF_AG = 0x43

#Audio amp not selected
TTS_AUDIO_CONF_AMP = 0x00

#Sample rate 11kHz
TTS_AUDIO_CONF_ASR = 0x01

#Audio routing: application to DAC
TTS_AUDIO_CONF_AR = 0x00

#Audio tone control: depreciated, set to 0
TTS_AUDIO_CONF_ATC = 0x00

#Audio click source: internal, set to 0
TTS_AUDIO_CONF_ACS = 0x00

#DAC is on only while speech decoder 
#or TTS synthesis is outputting audio
TTS_AUDIO_CONF_DC = 0x00

#TTS Config
