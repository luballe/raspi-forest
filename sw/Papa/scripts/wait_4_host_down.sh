#!/bin/sh

timestamp() {
  date +"%F_%T"
}

hostname=$1
path="/home/pi/scripts/"
pipe_prefix="pipe_status_"
pipe=$path$pipe_prefix$hostname
#var1=0
if [ ! -p "$pipe" ]
then
  msg="No named pipe: "
  echo "[$(timestamp)] $msg$pipe"
  exit 1
fi
ping -c 3 192.168.100.4
sleep 30
read var1 < $pipe 
#command=$commmand$pipe
#eval $command
#read var1 < /home/pi/scripts/forest2_status
while [ $var1 -eq 1 ]
do
  #eval $command
  #read var1 < /home/pi/scripts/forest2_status
  #echo $var1
  python /home/pi/scripts/reportTransmiting2Arduino.py
  msg=" is connected! Checking again in 10 secs..."
  echo "[$(timestamp)] $hostname$msg"
  read var1 < $pipe 
  sleep 10
done

msg=" is down!"
echo "[$(timestamp)] $hostname$msg"
#sleep 5
