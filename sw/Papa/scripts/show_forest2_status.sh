#!/bin/sh

while true
do
  read var1 < forest2_status
  if [ $var1 -eq 0 ]
  then
    echo "Host is not Alive! Try again later.."
  else
    echo "Yes! Host is Alive!"
  fi
  sleep 1
done
