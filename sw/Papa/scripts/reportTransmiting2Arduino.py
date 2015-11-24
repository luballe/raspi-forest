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
    os.system("echo '[" + st+ "] Reporting arduino that we are transmiting...' >> /home/pi/scripts/log.txt")
    time.sleep(1)
    ser.write("3")
    line = str(ser.readline())
    #print len(line)
    if line == "3" :
      arduino_answer_OK = True
      os.system("echo '[" + st+ "] Transmiting reported OK to Arduino!' >> /home/pi/scripts/log.txt")
    else:
      arduino_answer_OK = False
      os.system("echo '[" + st+ "] Transmiting reported failed. Trying again...' >> /home/pi/scripts/log.txt")
    

  ser.close()
except serial.serialutil.SerialException:
  pass
