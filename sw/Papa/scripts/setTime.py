import os
import re
import time
import serial

ser = serial.Serial('/dev/ttyAMA0',9600,timeout=1)
date_time_regex = re.compile('(\d{4})-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})')

try:
  response = -1
  #os.system("echo ' ' >> /home/pi/scripts/log.txt") 
  #os.system("echo '**** Starting ****' >> /home/pi/scripts/log.txt")
  while response != 0:
    ser.open()
    line = ""
    #print len(line)
    regex_OK = False
    while not regex_OK:
      os.system("echo 'Asking arduino for time...' >> /home/pi/scripts/log.txt")
      time.sleep(1)
      ser.write("1")
      line = str(ser.readline())
      #print len(line)
      if date_time_regex.match(line):
        regex_OK = True
        os.system("echo 'Regex Matched!' >> /home/pi/scripts/log.txt")
      else:
        regex_OK = False
        os.system("echo 'Regex NOT Matched, trying again...' >> /home/pi/scripts/log.txt")
      
    os.system("echo 'Arduino response: " + str(line[:-1]) + "' >> /home/pi/scripts/log.txt")
    os.system("echo 'Date-time string OK, building command...' >> /home/pi/scripts/log.txt")
    date_time_strs = line.split()
    date_time_cmd = date_time_strs[0] + " " + date_time_strs[1]
    date_time_cmd = "'" + date_time_cmd + "'"
    command = "sudo date -s %s > /dev/null" % (date_time_cmd)
    os.system("echo 'Setting forest1 system time...' >> /home/pi/scripts/log.txt")
    response = os.system(command)
    os.system("echo 'Forest1 system response: " + str(response) + "' >> /home/pi/scripts/log.txt")
    command = "ssh pi@192.168.100.2 /home/pi/scripts/set_date_time.sh %s > /dev/null" % (date_time_cmd)
    #print command
    os.system("echo 'Setting forest2 system time...' >> /home/pi/scripts/log.txt")
    response = os.system(command)
    os.system("echo 'Forest2 system response: " + str(response) + "' >> /home/pi/scripts/log.txt")



    ser.close()
    time.sleep(1)
except serial.serialutil.SerialException:
  pass
