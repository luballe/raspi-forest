import os
import time
import serial
import datetime

ser = serial.Serial('/dev/ttyAMA0',9600,timeout=1)

try:
  ser.open()
  line = ""
  #print len(line)
  arduino_answer_OK = False
  while not arduino_answer_OK:
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d_%H:%M:%S')
    os.system("echo '[" + st+ "] Reporting arduino that we are taking pictures...' >> /home/pi/scripts/log.txt")
    time.sleep(1)
    ser.write("2")
    line = str(ser.readline())
    #print len(line)
    if line == "2" :
      arduino_answer_OK = True
      ts = time.time()
      st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d_%H:%M:%S')
      os.system("echo '[" + st+ "] Taking pictures reported OK to Arduino!' >> /home/pi/scripts/log.txt")
    else:
      arduino_answer_OK = False
      os.system("echo '[" + st+ "] Taking pictures reporting failed. Trying again...' >> /home/pi/scripts/log.txt")
    

  ser.close()
except serial.serialutil.SerialException:
  pass
