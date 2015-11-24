#!/bin/sh
ip=$1

count=$( ping -c 1 $ip | grep "ttl=*" | wc -l )

while [ $count -eq 1 ]
do
  python /home/pi/scripts/reportTransmiting2Arduino.py
  msg=" is alive! Checking again in 10 secs..."
  echo $ip$msg
  count=$( ping -c 1 $ip | grep "ttl=*" | wc -l )
  sleep 10
done

msg=" is down!"
echo $ip$msg
