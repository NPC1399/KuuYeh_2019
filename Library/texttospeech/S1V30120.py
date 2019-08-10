from text_to_speech_img import *
from S1V30120_defines import *
from pyb import Pin
import pyb
import ustruct

class S1V30120:
    #Variables
    #Most received messages are 6 bytes
    rcvd_msg = []
    rcvd_msg = [0]*20

    send_msg = []
    send_msg = [0]*200


    msg_len = 0
    txt_len = 0

    tmp = 0
    idx = 0
    success = False

    #Used to download image data. This is changed by the 
    #This is why is declares as static volatile.
    #Note: unsigned short is max 32767, while our image data is 31208 in length
    #one must change this to unsigned long if future image data becomes larger
    TTS_DATA_IDX = 0
    
    ## Private methods
    def __init__(self,SPI):

        #Pin settings
        # -----------------------------
        # SCK|MOSI|NC  |5V|GND|NC  |RDY |NC
        # PI1|PI3 |PH14|5V|GND|PD13|PB15|PB13
        # -----------------------------
        # CS  |MISO|NC  |GND|E3V3|NC  |RST |MUTE
        # PD11|PI2 |PH13|GND|3V3 |PD12|PB14|PB12
        # -----------------------------
        #define MICROPY_HW_SPI2_SCK  (pin_I1)
        #define MICROPY_HW_SPI2_MISO (pin_I2)
        #define MICROPY_HW_SPI2_MOSI (pin_I3)
        self.S1V30120_RST = Pin('PB14', Pin.OUT_PP)
        #self.S1V30120_RDY = Pin('G9', Pin.IN, Pin.PULL_UP)  #For Green Board
        self.S1V30120_RDY = Pin('PB15',Pin.IN)
        self.S1V30120_CS = Pin('PD11', Pin.OUT_PP)
        self.S1V30120_MUTE = Pin('PB12', Pin.OUT_PP)

        #Unmute
        self.S1V30120_MUTE.low()

        #for SPI
        self._SPI = SPI


    def __del__(self):
        try:
            super(S1V30120, self).__del__()
        except:
            pass

    ## Public methods
    def enableS1V(self):
        self.S1V30120_reset()

        self.tmp = self.S1V30120_get_version()
        if (self.tmp == 0x0402):
            print("S1V30120 found. Downloading boot image!")

        self.success = self.S1V30120_download()
        print("Boot image download: ")
        self.show_response(self.success)

        self.success = self.S1V30120_boot_run()
        print("Boot image run: ")
        self.show_response(self.success)

        pyb.delay(150) #Wait for the boot image to execute

        self.success = self.S1V30120_registration()
        print("Registering: ")
        self.show_response(self.success)

        #Once again print version information 
        self.S1V30120_get_version()
        self.success = self.S1V30120_configure_audio()
        print("Configuring audio: ")
        self.show_response(self.success)

        self.success = self.S1V30120_set_volume()
        print("Setting volume: ")
        self.show_response(self.success)

        self.success = self.S1V30120_configure_tts()
        print("Configure TTS: ")
        self.show_response(self.success)

        self.S1V30120_speech("my name is matenat i come from sisaket and i love you so much",0)

    def S1V30120_reset(self):

        self.S1V30120_CS.high() #S1V30120 not selected
        self.S1V30120_RST.low()
        pyb.delay(150)

        #send one dummy byte, this will leave the clock line high
        self._SPI.send(0x00)

        pyb.delay(5)
        self.S1V30120_RST.high()
        pyb.delay(150)


    def S1V30120_get_version(self):

        #Querry version
        S1V30120_version = 0
        tmp_disp = 0
        msg_ver = [0x04, 0x00, 0x05, 0x00]
        self.S1V30120_send_message(msg_ver, 0x04)
    
        #wait for ready signal
        while(self.S1V30120_RDY.value() == False):
            print("wait for ready signal")
    
        #receive 20 bytes
        self.S1V30120_CS.low()
        
        #wait for message start
        while(self._SPI.send_recv(0x00) != b'\xaa'):
            print("wait for message start")

        for i in range(0,20):
            self.rcvd_msg[i] = self._SPI.send_recv(0x00)

        #Send 16 bytes padding
        self.S1V30120_send_padding(16) 

        self.S1V30120_CS.high()

        a = ustruct.unpack('<B', self.rcvd_msg[4])[0]
        b = ustruct.unpack('<B', self.rcvd_msg[5])[0]

        S1V30120_version = (a << 8) | b
        print("HW version "+str(self.rcvd_msg[4]+"."+str(self.rcvd_msg[5])))
        print("Firmware version "+str(self.rcvd_msg[6])+"."+str(self.rcvd_msg[7])+"."+str(self.rcvd_msg[16]))

        a = ustruct.unpack('<B', self.rcvd_msg[11])[0]
        b = ustruct.unpack('<B', self.rcvd_msg[10])[0]
        c = ustruct.unpack('<B', self.rcvd_msg[9])[0]
        d = ustruct.unpack('<B', self.rcvd_msg[8])[0]
        features = a << 24 | (b << 16) | (c << 8) | d
        print("Firmware features "+str(features))

        a = ustruct.unpack('<B', self.rcvd_msg[15])[0]
        b = ustruct.unpack('<B', self.rcvd_msg[14])[0]
        c = ustruct.unpack('<B', self.rcvd_msg[13])[0]
        d = ustruct.unpack('<B', self.rcvd_msg[12])[0]
        extended = a << 24 | (b << 16) | (c << 8) | d
        print("Firmware extended features "+str(extended))
        return S1V30120_version

    def S1V30120_download(self):

        #TTS_INIT_DATA is of unsigned char type (one byte)
        data_len = len(TTS_INIT_DATA)
        fullchunks = 0
        remaining = 0
        chunk_result = False
        data_index = 0

        print("TTS_INIT_DATA length is "+str(data_len))


        #We are loading chunks of data
        #Each chunk, including header must be of maximum 2048 bytes
        #as the header is 4 bytes, this leaves 2044 bytes to load each time
        #Computing number of chunks

        #data_len = 31208

        fullchunks = data_len / 2044
        fullchunks = int(fullchunks)

        remaining = data_len - fullchunks * 2044
        remaining = int(remaining)


        print("Full chunks to load: "+str(fullchunks))
        print("Remaining bytes: "+str(remaining))

        #Load a chunk of data
        for num_chunks in range(0,fullchunks):

            chunk_result = self.S1V30120_load_chunk(2044)

            if (chunk_result):
                print("Success")
            else:
                print("Failed at chunk "+str(num_chunks))
                return 0

        #Now load the last chunk of data
        chunk_result = self.S1V30120_load_chunk(remaining)

        if (chunk_result):
            print("Success")
        else:
            print("Failed at last chunk ")
            return 0

        #All was OK, returning 1
        return True


    def S1V30120_load_chunk(self,chunk_len):

        #Load a chunk of data
        len_msb = ((chunk_len + 4) & 0xFF00) >> 8
        len_lsb = (chunk_len + 4) & 0xFF

        self.S1V30120_CS.low()

        self._SPI.send(0xAA)    #Start Message Command
        self._SPI.send(len_lsb) #Message length is 2048 bytes = 0x0800
        self._SPI.send(len_msb) #LSB first
        self._SPI.send(0x00)    #Send SC_BOOT_LOAD_REQ (0x1000)
        self._SPI.send(0x10)

        for chunk_idx in range(0,chunk_len):
            #do something#
            #print(str(TTS_INIT_DATA[self.TTS_DATA_IDX])+" = "+str(self.TTS_DATA_IDX))
            self._SPI.send(TTS_INIT_DATA[self.TTS_DATA_IDX])
            self.TTS_DATA_IDX = self.TTS_DATA_IDX+1
        self.S1V30120_CS.high()

        return self.S1V30120_parse_response(ISC_BOOT_LOAD_RESP, 0x0001, 16)

    def S1V30120_boot_run(self):

        boot_run_msg = [0x04, 0x00, 0x02, 0x10]
        self.S1V30120_send_message(boot_run_msg, 0x04)
        return self.S1V30120_parse_response(ISC_BOOT_RUN_RESP, 0x0001, 8)


    def show_response(self,response):
        if (response):
            print("OK!")
        else:
            print("Failed. System halted!")
            while(1):
                pass

    def S1V30120_registration(self):
        reg_code = [0x0C, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
        self.S1V30120_send_message(reg_code, 0x0C)
        return self.S1V30120_parse_response(ISC_TEST_RESP, 0x0000, 16)

    #Message parser
    #This function receives as parameter the expected response code and result
    #And returns 1 if the expected result is received, 0 otherwise
    #As an observation, most messages are 6 bytes in length 
    #(2 bytes length + 2 bytes response code + 2 bytes response)
    def S1V30120_parse_response(self,expected_message,expected_result,padding_bytes):
        
        rcvd_tmp = 0
        #wait for ready signal
        while(self.S1V30120_RDY.value() == False):
            #print("wait for ready signal")
            pass

        #receive 6 bytes
        self.S1V30120_CS.low()

        #wait for message start
        while (self._SPI.send_recv(0x00) != b'\xaa'):
            #print("wait for message start")
            pass

        for i in range(0,6):
            self.rcvd_msg[i] = self._SPI.send_recv(0x00)

        #padding bytes
        self.S1V30120_send_padding(padding_bytes)

        self.S1V30120_CS.high()

        #Are we successfull? We shall check

        a = ustruct.unpack('<B', self.rcvd_msg[3])[0]
        b = ustruct.unpack('<B', self.rcvd_msg[2])[0]
        rcvd_tmp = a << 8 | b


        if (rcvd_tmp == expected_message):      #Have we received ISC_BOOT_RUN_RESP?
            #We check the response
            a = ustruct.unpack('<B', self.rcvd_msg[5])[0]
            b = ustruct.unpack('<B', self.rcvd_msg[4])[0]
            rcvd_tmp = a << 8 | b

            if (rcvd_tmp == expected_result): #success, return 1
                return 1
            else:
                return 0
        else:                                 #We received something else
            return 0

    #Padding function
    #Sends a num_padding_bytes over the SPI bus
    def S1V30120_send_padding(self,num_padding_bytes):
        for i in range(0,num_padding_bytes):
            self._SPI.send(0x00)


    #Functions that run in normal mode
    def S1V30120_send_message(self,message,message_length):
        #Check to see if there's an incoming response or indication
        while (self.S1V30120_RDY.value() == True):   #blocking
            print('RDY=True')
        #OK, we can proceed

        self.S1V30120_CS.low()
        pyb.delay(10)
        send_lock = True

        for i in range(0,message_length):
            if send_lock:
                self._SPI.send(0xAA)
                send_lock = False
            self._SPI.send(message[i])


    def S1V30120_configure_audio(self):
        msg_len = 0x0C
        self.send_msg[0] = msg_len & 0xFF               #LSB of msg len
        self.send_msg[1] = (msg_len & 0xFF00) >> 8      #MSB of msg len
        self.send_msg[2] = ISC_AUDIO_CONFIG_REQ & 0xFF
        self.send_msg[3] = (ISC_AUDIO_CONFIG_REQ & 0xFF00) >> 8
        self.send_msg[4] = TTS_AUDIO_CONF_AS
        self.send_msg[5] = TTS_AUDIO_CONF_AG
        self.send_msg[6] = TTS_AUDIO_CONF_AMP
        self.send_msg[7] = TTS_AUDIO_CONF_ASR
        self.send_msg[8] = TTS_AUDIO_CONF_AR
        self.send_msg[9] = TTS_AUDIO_CONF_ATC
        self.send_msg[10] = TTS_AUDIO_CONF_ACS
        self.send_msg[11] = TTS_AUDIO_CONF_DC
        self.S1V30120_send_message(self.send_msg, msg_len)
        return self.S1V30120_parse_response(ISC_AUDIO_CONFIG_RESP, 0x0000, 16)

    #set gain to 0 db
    def S1V30120_set_volume(self):
        setvol_code = [0x06, 0x00, 0x0A, 0x00, 0x00, 0x00]
        self.S1V30120_send_message(setvol_code, 0x06)
        return self.S1V30120_parse_response(ISC_AUDIO_VOLUME_RESP, 0x0000, 16)


    def S1V30120_configure_tts(self):
        msg_len = 0x0C
        self.send_msg[0] = msg_len & 0xFF                       #LSB of msg len
        self.send_msg[1] = (msg_len & 0xFF00) >> 8              #MSB of msg len
        self.send_msg[2] = ISC_TTS_CONFIG_REQ & 0xFF
        self.send_msg[3] = (ISC_TTS_CONFIG_REQ & 0xFF00) >> 8
        self.send_msg[4] = ISC_TTS_SAMPLE_RATE
        self.send_msg[5] = ISC_TTS_VOICE
        self.send_msg[6] = ISC_TTS_EPSON_PARSE
        self.send_msg[7] = ISC_TTS_LANGUAGE
        self.send_msg[8] = ISC_TTS_SPEAK_RATE_LSB
        self.send_msg[9] = ISC_TTS_SPEAK_RATE_MSB
        self.send_msg[10] = ISC_TTS_DATASOURCE
        self.send_msg[11] = 0x00
        self.S1V30120_send_message(self.send_msg, msg_len)
        return self.S1V30120_parse_response(ISC_TTS_CONFIG_RESP, 0x0000, 16)


    def S1V30120_speech(self,text_to_speech,flush_enable):
        response = False
        txt_len = len(text_to_speech)
        msg_len = txt_len + 6
        self.send_msg[0] = msg_len & 0xFF                       #LSB of msg len
        self.send_msg[1] = (msg_len & 0xFF00) >> 8              #MSB of msg len
        self.send_msg[2] = ISC_TTS_SPEAK_REQ & 0xFF
        self.send_msg[3] = (ISC_TTS_SPEAK_REQ & 0xFF00) >> 8
        self.send_msg[4] = flush_enable                         #flush control

        for i in range(0,txt_len):
            self.send_msg[i+5] = text_to_speech[i]

        self.send_msg[msg_len-1] = '\0'                              #null character

        #print(self.send_msg)
        self.S1V30120_send_message(self.send_msg, msg_len)

        response = self.S1V30120_parse_response(ISC_TTS_SPEAK_RESP, 0x0000, 16)

        while (self.S1V30120_parse_response(ISC_TTS_FINISHED_IND, 0x0000, 16) == 0):
            #print(self.S1V30120_parse_response(ISC_TTS_FINISHED_IND, 0x0000, 16))
            pass
        return response