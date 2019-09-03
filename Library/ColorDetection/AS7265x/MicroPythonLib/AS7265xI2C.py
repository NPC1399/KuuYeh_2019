from micropython import const
import time
import struct
from Device import Device
AS7265X_ADDR = 0x49 #7-bit unshifted default I2C Address

AS7265X_SLAVE_STATUS_REG = 0x00
AS7265X_SLAVE_WRITE_REG  = 0X01
AS7265X_SLAVE_READ_REG   = 0x02

AS7265X_SLAVE_TX_VALID   = 0x02
AS7265X_SLAVE_RX_VALID   = 0x01

#Register addresses
AS7265X_HW_VERSION_HIGH  = 0x00
AS7265X_HW_VERSION_LOW   = 0x01

AS7265X_FW_VERSION_HIGH = 0x02
AS7265X_FW_VERSION_LOW  = 0x03

AS7265X_CONFIG            = 0x04
AS7265X_INTERGRATION_TIME = 0x05
AS7265X_DEVICE_TEMP       = 0x06
AS7265X_LED_CONFIG        = 0x07

#Raw channel registers
AS7265X_R_G_A    = 0x08
AS7265X_S_H_B    = 0x0A
AS7265X_T_I_C    = 0x0C
AS7265X_U_J_D    = 0x0E
AS7265X_V_K_E    = 0x10
AS7265X_W_L_F    = 0x12

#Calibrated channel registers
AS7265X_R_G_A_CAL =  0x14
AS7265X_S_H_B_CAL =  0x18
AS7265X_T_I_C_CAL =  0x1C
AS7265X_U_J_D_CAL =  0x20
AS7265X_V_K_E_CAL =  0x24
AS7265X_W_L_F_CAL =  0x28

AS7265X_DEV_SELECT_CONTROL = 0x4F

AS7265X_COEF_DATA_0      = 0x50
AS7265X_COEF_DATA_1      = 0x51
AS7265X_COEF_DATA_2      = 0x52
AS7265X_COEF_DATA_3      = 0x53
AS7265X_COEF_DATA_READ   = 0x54
AS7265X_COEF_DATA_WRITE  = 0x55

#Settings 

AS7265X_POLLING_DELAY = 5 #Amount of ms to wait between checking for virtual register changes

AS72651_NIR      =  0x00
AS72652_VISIBLE  =  0x01
AS72653_UV       =  0x02

AS7265x_LED_WHITE =	0x00 #White LED is connected to x51
AS7265x_LED_IR =	0x01 #IR LED is connected to x52
AS7265x_LED_UV =	0x02 #UV LED is connected to x53

AS7265X_LED_CURRENT_LIMIT_12_5MA  = 0b00
AS7265X_LED_CURRENT_LIMIT_25MA    = 0b01
AS7265X_LED_CURRENT_LIMIT_50MA    = 0b10
AS7265X_LED_CURRENT_LIMIT_100MA   = 0b11

AS7265X_INDICATOR_CURRENT_LIMIT_1MA   = 0b00
AS7265X_INDICATOR_CURRENT_LIMIT_2MA   = 0b01
AS7265X_INDICATOR_CURRENT_LIMIT_4MA   = 0b10
AS7265X_INDICATOR_CURRENT_LIMIT_8MA   = 0b11

AS7265X_GAIN_1X    = 0b00
AS7265X_GAIN_37X   = 0b01
AS7265X_GAIN_16X   = 0b10
AS7265X_GAIN_64X   = 0b11

AS7265X_MEASUREMENT_MODE_4CHAN             = 0b00
AS7265X_MEASUREMENT_MODE_4CHAN_2           = 0b01
AS7265X_MEASUREMENT_MODE_6CHAN_CONTINUOUS  = 0b10
AS7265X_MEASUREMENT_MODE_6CHAN_ONE_SHOT    = 0b11

class AS7265x:
    def __init__(self,i2c,AS7265X_ADDR=AS7265X_ADDR,
                integration_time=50,**kwargs):
        self._mode = AS7265X_MEASUREMENT_MODE_6CHAN_CONTINUOUS #Mode 2
        # TODO: Sanitize gain and integration time values
        self._gain = AS7265X_GAIN_64X # 64x
        self._integration_time = integration_time
        self._sensor_version = 0
        #Create I2C device
        if i2c is None:
            raise ValueError('An I2C object is required.')
        self._device = Device(address, i2c)
        self._i2c = i2c
        #Check and initialize device
        self.init_device()


    #Read a virtual register from the AS7265x
    def virtual_read_register(self,virtual_address):
        # Do a prelim check of the read register
        status = self._device.readU8(AS7265X_SLAVE_STATUS_REG);
        if((status & AS7265X_SLAVE_RX_VALID) != 0): # There is data to be read
            _ = self._device.readU8(AS7265X_SLAVE_READ_REG) # Read the byte but do nothing with it
        
        # Wait for WRITE register to be empty
        while True:
            status = self._device.readU8(AS7265X_SLAVE_STATUS_REG)
            if (status & AS7265X_SLAVE_TX_VALID) == 0:
                break # No inbound TX pending at slave. Okay to write now.
            time.sleep_ms(AS7265X_POLLING_DELAY)
        
        # Send the virtual register address (bit 7 should be 0 to indicate we are reading a register)
        self._device.write8(AS7265X_SLAVE_WRITE_REG , virtual_address)
        
        # Wait for READ flag to be set
        while True:
            status = self._device.readU8(AS7265X_SLAVE_STATUS_REG)
            if((status & AS7265X_SLAVE_RX_VALID) != 0): # Data is ready
                break # No inbound TX pending at slave. Okay to write now.
            time.sleep_ms(AS7265X_POLLING_DELAY)
        
        result = self._device.readU8(AS7265X_SLAVE_READ_REG)
        return result

    
    #Write to a virtual register in the AS7265x
    def virtual_write_register(self,virtual_address,value):
        #Wait for WRITE register to be empty
        while True:
            status = self._device.readU8(AS7265X_SLAVE_STATUS_REG)
            if((status & AS7265X_SLAVE_TX_VALID) == 0):
                break #No inbound TX pending at slave. Okay to write now.
            time.sleep_ms(AS7265X_POLLING_DELAY)
        
        #Send the virtual register address (setting bit 7 to indicate we are writing to a register).
        self._device.write8(AS7265X_SLAVE_WRITE_REG , (virtual_address | 0x80))

        # Wait for Write register to be empty
        while True:
            status = self._device.readU8(AS7265X_SLAVE_STATUS_REG)
            if((status & AS7265X_SLAVE_TX_VALID) == 0):
                break # No inbound TX pending at slave. Okay to write now.
            time.sleep_ms(AS7265X_POLLING_DELAY)
        
        # Sendthe data to complete the operation.
        self._device.write8(AS7265X_SLAVE_WRITE_REG , value)

    
    #Sets the measurement mode
    #Mode available in 0,1,2,3
    #       • Mode 0 : AS72651 data will be in S , T , U , V
    #                  AS72652 data will be in G , H , K , I
    #                  AS72653 data will be in A , B , E , C
    #       • Mode 1 : AS72651 data will be in R , T , U , W
    #                  AS72652 data will be in G , H , J , L
    #                  AS72653 data will be in F , A , B , D
    #       • Mode 2 : AS72651 data will be in S , T , U , V , R , W
    #                  AS72652 data will be in G , H , K , I , J , L
    #                  AS72653 data will be in A , B , C , D , E , F
    #       • Mode 3 : Mode 2 in one shot.
    def set_measurement_mode(self,mode):
        if(mode > 0b11):
            mode  = 0b11
        
        # Read , masl/set , write
        value = self.virtual_read_register(AS7265X_CONFIG)
        value = value & 0b11110011
        value = value | (mode << 2) #Set BANK bits with user's choice
        self.virtual_write_register(AS7265X_CONFIG,value)
        self._mode = mode
    

    #Sets the gain value
    #   Gain available in 0,1,2,3
    #       • Gain 0 : 1x
    #       • Gain 1 : 3.7x
    #       • Gain 2 : 16x
    #       • Gain 3 : 64x
    def set_gain(self,gain):
        if gain > 0b11:
            gain = 0b11
        
        #Read , mask/set ,write
        value = self.virtual_read_register(AS7265X_CONFIG)
        value = value & 0b11001111
        value = value | (gain << 4) #Set GAIN bits with user's choice
        self.virtual_write_register(AS7265X_CONFIG,value)
        self._gain = gain
    

    #Sets the integration value
    #Give this function a byte from 0 to 255.
    #Time will be 2.8ms * [integration value]
    def set_integration_time(self,integration_time):
        if integration_time > 255:
            integration_time = 255
        self.virtual_write_register(AS7265X_INTERGRATION_TIME,integration_time)
        self._integration_time = integration_time
    

    #As we read various registers we have to point at the master or first/second slave
    def selectDevice(self,device):
        #Set the bits 0:1. Just overwrite whatever is there because making in the correct value doesn't work.
        self.virtual_write_register(AS7265X_DEV_SELECT_CONTROL,device)


    #Set the current limit of bulb/LED
    #Current 0 : 12.5 mA
    #Current 1 : 25   mA
    #Current 2 : 50   mA
    #Current 3 : 100  mA
    def set_bulb_current(self,current_level,device):
        if current_level > 0b11:
            current_level = 0b11
        selectDevice(device) #Select LED
        #Read , mask/set, write
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value & 0b11001111
        value = value | (current_level << 4)
        self.virtual_write_register(AS7265X_LED_CONFIG,value)

    def enable_bulb(self,device):
        selectDevice(device)
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value | (1 << 3 )
        self.virtual_write_register(AS7265X_LED_CONFIG,value)
    
    def disable_bulb(self,device):
        selectDevice(device)
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value & ~(1 << 3)
        self.virtual_write_register(AS7265X_LED_CONFIG)

    #Enable the onboard indicator LED
    def enable_indicator_led(self)
        selectDevice(AS72651_NIR)
        #Read , mask/set ,write
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value | (1 << 0)
        virtual_write_register(AS7265X_LED_CONFIG,value)
    
    #Disable the onboard indicator LED
    def disable_indicator_led(self)
        selectDevice(AS72651_NIR)
        #Read , mask/set , write
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value & ~(1 << 0) #Clear the bit
        virtual_write_register(AS7265X_LED_CONFIG,value)

    #Set the limit of onboard LED. Default is max 8 mA = 0b11.    
    #Current 0 : 1 mA
    #Current 1 : 2 mA
    #Current 2 : 4 mA
    #Current 3 : 8 mA
    def set_indicator_current(self,current):
        selectDevice(AS72651_NIR)
        if current > 0b11:
            current = 0b11
        #Read, mask/set , write
        value = self.virtual_read_register(AS7265X_LED_CONFIG)
        value = value & 0b11111001
        value = value | (current << 1)
        virtual_write_register(AS7265X_LED_CONFIG,value)
    
    