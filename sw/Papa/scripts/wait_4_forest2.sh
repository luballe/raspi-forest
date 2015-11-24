#!/bin/sh

var1=0
read var1 < /home/pi/scripts/forest2_status
while [ $var1 -eq 0 ]
do
  echo "Forest2 is not Alive! Trying again in 1 sec..."
  read var1 < /home/pi/scripts/forest2_status
  #echo $var1
  sleep 1
done
echo "Forest2 is up!"
