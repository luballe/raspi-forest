#!/bin/sh

target="192.168.100.2"
while true
do
  count_1=$( ping -c 1 $target | grep "ttl=*" | wc -l )
  # If found an "ttl=" then the host is up 
  if [ $count_1 -eq 1 ]
  then
    #echo "Yes! Host is Alive!"
    #Write value in a named pipe (forest2_status
    echo 1 > /home/pi/scripts/forest2_status
    sleep 1
 else
    #count_2=$( ping -c 1 $target -W 500| grep "Unreachable" | wc -l )
    # If found an "Unreachable" then the host is down 
    #if [ $count_2 -eq 1 ]
    #then 
      #echo "Host is not Alive! Try again later.."
      echo 0 > /home/pi/scripts/forest2_status
    #fi
    #sleep 1
  fi
done

#echo $var1
#var1=1
