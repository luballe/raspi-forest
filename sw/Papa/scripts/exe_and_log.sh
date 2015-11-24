echo "***Starting***"  >> /home/pi/scripts/log.txt

#echo "1 - Checking Forest2 status..." >> /home/pi/scripts/log.txt
#/home/pi/scripts/check_host.sh 192.168.100.2 forest2 &

#echo "2 - Checking Stephanie status..." >> /home/pi/scripts/log.txt
#/home/pi/scripts/check_host.sh 192.168.100.3 stephanie &

#echo "3 - Checking Luballe status..." >> /home/pi/scripts/log.txt
#/home/pi/scripts/check_host.sh 192.168.100.4 luballe &

echo "1 - Waiting till Forest2 is up..." >> /home/pi/scripts/log.txt
/home/pi/scripts/wait_4_host_up_2.sh 192.168.100.2 >> /home/pi/scripts/log.txt

echo "2 - Setting time from Arduino..." >> /home/pi/scripts/log.txt
/home/pi/scripts/setTime.sh  >> /home/pi/scripts/log.txt

echo "3 - Taking pictures..." >> /home/pi/scripts/log.txt
/home/pi/scripts/take_forest_pictures.sh >> /home/pi/scripts/log.txt

echo "4 - Waiting till luballe is down..." >> /home/pi/scripts/log.txt
/home/pi/scripts/wait_4_host_down_2.sh 192.168.100.4 >> /home/pi/scripts/log.txt

echo "4 - Waiting till stephanie is down..." >> /home/pi/scripts/log.txt
/home/pi/scripts/wait_4_host_down_2.sh 192.168.100.3 >> /home/pi/scripts/log.txt

echo "5 - Shutting down system..." >> /home/pi/scripts/log.txt
/home/pi/scripts/shutdown_system.sh >> /home/pi/scripts/log.txt

echo "END" >> /home/pi/scripts/log.txt
echo "" >> /home/pi/scripts/log.txt
