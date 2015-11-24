#!/bin/sh
ip=$1

count=$( ping -c 1 $ip | grep "ttl=*" | wc -l )

while [ $count -eq 0 ]
do
  msg=" is not Alive! Trying again in 1 sec..."
  echo $ip$msg
  count=$( ping -c 1 $ip | grep "ttl=*" | wc -l )
  sleep 1
done

msg=" is up!"
echo $ip$msg
