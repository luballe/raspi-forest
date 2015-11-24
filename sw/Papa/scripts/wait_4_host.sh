#!/bin/sh

hostname=$1
path="/home/pi/scripts/"
pipe_sufix="_pipe_status"
pipe=$path$hostname$pipe_sufix
var1=0
if [ ! -p "$pipe" ]
then
  msg="No named pipe: "
  echo $msg$pipe
  exit 1
fi
read var1 < $pipe 
#command=$commmand$pipe
#eval $command
#read var1 < /home/pi/scripts/forest2_status
while [ $var1 -eq 0 ]
do
  msg=" is not Alive! Trying again in 1 sec..."
  echo $hostname$msg
  read var1 < $pipe 
  #eval $command
  #read var1 < /home/pi/scripts/forest2_status
  #echo $var1
  sleep 1
done

msg=" is up!"
echo $hostname$msg
sleep 5
