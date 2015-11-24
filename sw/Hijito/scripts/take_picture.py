import os
import sys
import time
import picamera

folderPath='/home/pi/forest-pictures';
filename = str(sys.argv[1]) + '_NIR.jpg'

with picamera.PiCamera() as camera:
    camera.resolution = (2592, 1944)
    camera.rotation = 180
    camera.start_preview()
    time.sleep(2)
    #filename= time.strftime("%Y_%m_%d-%H_%M") + '_NIR.jpg'
    picsPath=folderPath+'/'+filename
    print filename
    camera.capture(picsPath)
