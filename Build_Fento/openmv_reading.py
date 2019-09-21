# AprilTags Reading 
# Last Modify : 12/08/2019
# Last Edit by : Yoolaibeef K.
# Note : Data from OpenMV will recieved by vairable 'data_raw'
# Status : DONE

import sensor, image, time, math, pyb

class FATAG:
    
    def __init__(self):

        # Variable for tag reading
        self.tag_families = 0
        self.tag_families |= image.TAG36H11 

        # Main Grobal Variable
        self.tag_id = 0
        self.past_tag_id = -1
        self.last_tag_id = -1
        self.led_state = 0
        self.count_detect = 0
        self.count_tag = 0
        self.time_tag = 0

        sensor.reset()
        sensor.set_pixformat(sensor.RGB565)
        sensor.set_framesize(sensor.QQVGA) # we run out of memory if the resolution is much bigger...
        sensor.skip_frames(time = 2000)
        sensor.set_auto_gain(False)  # must turn this off to prevent image washout...
        sensor.set_auto_whitebal(False)  # must turn this off to prevent image washout...
        self.clock = time.clock()


    def ATAG(self):

        self.clock.tick()
        img = sensor.snapshot()
        img = img.rotation_corr(0,0,90)
        for tag in img.find_apriltags(families=self.tag_families): 

            self.tag_id = tag.id()       # Read tag_id

            # Check for prevent read the same tag!
            if(self.tag_id == self.past_tag_id):
                self.count_tag = self.count_tag+1
            else:
                self.count_tag = 0
            self.past_tag_id = self.tag_id

        # Create some Detail for use OpenMV to read April_tag
        self.count_detect = self.count_detect+1

        if(self.count_detect > self.count_tag):
            self.count_detect = 0
            self.count_tag = 0
            self.led_state = 0
            self.last_tag_id = -1

        if(self.count_tag >= 4):
            self.count_detect = 0
            self.count_tag = 0
            if(self.tag_id == self.last_tag_id):
                self.led_state = 2
            else:
                self.led_state = 1

                # Send data
                # self.data_raw = str(int((self.tag_id/10)%10)) + str(int(self.tag_id%10)) + "\r\n"   
                pyb.LED(1).off()    
                pyb.LED(2).on()
                return self.tag_id
                
            self.last_tag_id = self.tag_id

        if(self.led_state == 1):
            pyb.LED(1).off()
            pyb.LED(2).on()
            self.led_state = 2
        elif(self.led_state == 2):
            pyb.LED(1).on()
            pyb.LED(2).on()
        else:
            pyb.LED(1).on()
            pyb.LED(2).off()

        return -1    



    # def family_name(tag):
    # if(tag.family() == image.TAG16H5):
    #     return "TAG16H5"
    # if(tag.family() == image.TAG25H7):
    #     return "TAG25H7"
    # if(tag.family() == image.TAG25H9):
    #     return "TAG25H9"
    # if(tag.family() == image.TAG36H10):
    #     return "TAG36H10"
    # if(tag.family() == image.TAG36H11):
    #     return "TAG36H11"
    # if(tag.family() == image.ARTOOLKIT):
    #     return "ARTOOLKIT"          
