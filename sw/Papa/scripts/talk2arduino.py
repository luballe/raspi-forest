import time
import serial
ser = serial.Serial('/dev/ttyAMA0',9600,timeout=1)
ser.open()

try:
  while 1:
    ser.write("1")
    response = ser.readline()
    print response
    time.sleep(1)
except KeyboardInterrup:
  ser.close()
