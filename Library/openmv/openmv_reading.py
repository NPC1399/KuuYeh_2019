# AprilTags Reading 
# 06/08/2019
# This example shows the power of the OpenMV Cam to detect April Tags
# on the OpenMV Cam M7. The M4 versions cannot detect April Tags.

import sensor, image, time, math, pyb,lcd
from pyb import UART

# Main Grobal Variable
tag_id = 0
past_tag_id = -1
last_tag_id = -1
led_state = 0
count_detect = 0
count_tag = 0
time_tag = 0

# Setting UART for send Data to other devices
uart = UART(3, 9600)
uart.init(9600, bits=8, parity=None, stop=1)

# Sensor setting
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QQVGA) # we run out of memory if the resolution is much bigger...
sensor.skip_frames(time = 2000)
sensor.set_auto_gain(False)  # must turn this off to prevent image washout...
sensor.set_auto_whitebal(False)  # must turn this off to prevent image washout...
lcd.init()

# Setting Clock
clock = time.clock()

# Variable for tag reading
tag_families = 0
tag_families |= image.TAG36H11 

# Define Function
def family_name(tag):
    if(tag.family() == image.TAG16H5):
        return "TAG16H5"
    if(tag.family() == image.TAG25H7):
        return "TAG25H7"
    if(tag.family() == image.TAG25H9):
        return "TAG25H9"
    if(tag.family() == image.TAG36H10):
        return "TAG36H10"
    if(tag.family() == image.TAG36H11):
        return "TAG36H11"
    if(tag.family() == image.ARTOOLKIT):
        return "ARTOOLKIT"



# Start Running Program!
while(True):
    clock.tick()

    # Snap Image from sensor and Rotate 90 degree
    img = sensor.snapshot()
    img.rotation_corr(0,0,90)

    # If can Detect April_tag
    for tag in img.find_apriltags(families=tag_families): 
        img.draw_rectangle(tag.rect(), color = (255, 0, 0))     # Draw Rectangle on April_tag that we can detect
        img.draw_cross(tag.cx(), tag.cy(), color = (0, 255, 0))     # Draw + symbol on a center

        tag_id = tag.id()       # Read tag_id

        # Check for prevent read the same tag!
        if(tag_id == past_tag_id):
            count_tag = count_tag+1
        else:
            count_tag = 0
        past_tag_id = tag_id


    lcd.display(img)


    # Create some Detail for use OpenMV to read April_tag
    count_detect = count_detect+1

    if(count_detect > count_tag):
        count_detect = 0
        count_tag = 0
        led_state = 0
        last_tag_id = -1

    if(count_tag >= 4):
        count_detect = 0
        count_tag = 0
        if(tag_id == last_tag_id):
            led_state = 2
        else:
            led_state = 1

            # Send data with UART to other devices
            txSend = str(int((tag_id/10)%10)) + str(int(tag_id%10)) + "\r\n"        
            print(txSend)
            uart.write(txSend)
            
        last_tag_id = tag_id

    if(led_state == 1):
        pyb.LED(1).off()
        pyb.LED(2).on()
        led_state = 2
    elif(led_state == 2):
        pyb.LED(1).on()
        pyb.LED(2).on()
    else:
        pyb.LED(1).on()
        pyb.LED(2).off()
