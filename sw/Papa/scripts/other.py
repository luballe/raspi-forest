import os
import time
import serial

ser = serial.Serial('/dev/ttyAMA0',9600,timeout=1)

try:
  #os.system("echo ' ' >> /home/pi/scripts/log.txt")
  os.system("echo 'Tell arduino we are taking pictures...' >> /home/pi/scripts/log.txt")
  ser.open()
  time.sleep(1)
  ser.write("2")
  line = str(ser.readline())
  os.system("echo 'Arduino response: " + line + "' >> /home/pi/scripts/log.txt")
  ser.close()
except serial.serialutil.SerialException:
  pass
