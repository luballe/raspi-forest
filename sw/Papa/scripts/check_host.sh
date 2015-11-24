#!/bin/sh
ip=$1
hostname=$2
path="/home/pi/scripts/"
pipe_prefix="pipe_status_"
pipe=$path$pipe_prefix$hostname
#echo $pipe
if [ ! -p "$pipe" ] 
then
  mkfifo $pipe
fi 

while true
do
  count_1=$( ping -c 1 $ip | grep "ttl=*" | wc -l )
  # If found an "ttl=" then the host is up 
  if [ $count_1 -eq 1 ]
  then
    #echo "Yes! Host is Alive!"
    #Write value in a named pipe (forest2_status
    #command="echo 1 > " 
    #amp=" &"
    #command=$command$pipe
    #eval $command
    echo 1 > $pipe
    sleep 1
 else
    #count_2=$( ping -c 1 $target -W 500| grep "Unreachable" | wc -l )
    # If found an "Unreachable" then the host is down 
    #if [ $count_2 -eq 1 ]
    #then 
      #echo "Host is not Alive! Try again later.."
    #command="echo 0 > " 
    #amp=" &"
    #command=$command$pipe
    echo 0 > $pipe
    #eval $command
      #echo 0 > /home/pi/scripts/forest2_status
    #fi
    #sleep 1
  fi
done

#echo $var1
#var1=1
