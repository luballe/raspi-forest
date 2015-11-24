# Define a timestamp functionb
timestamp() {
  date +"%F_%T"
}

NOW=$(date +"uniandes_%Y_%m_%d_%H%M%S")

log_file="/home/pi/scripts/log.txt"

#Report to arduino that we are taking pictures of the forest
python /home/pi/scripts/reportTakingPictures2Arduino.py

#echo $NOW
echo "[$(timestamp)] Taking RGB picture on forest1..."
/home/pi/scripts/take_RGB_picture.sh $NOW &
echo "[$(timestamp)] RGB picture taken!"

echo "[$(timestamp)] Taking NIR picture on forest2..."
command='/home/pi/scripts/take_NIR_picture.sh '
command=$command$NOW
#echo $command
OUTPUT="$( ssh pi@192.168.100.2 $command )"
echo "[$(timestamp)] NIR picture taken!"

echo "[$(timestamp)] Transfering NIR picture from forest2 to forest1..."
scp pi@192.168.100.2:/home/pi/forest-pictures/${OUTPUT} /home/pi/forest-pictures
echo "[$(timestamp)] NIR picture transfered!"

echo "[$(timestamp)] Deleting NIR picture on forest2..."
ssh pi@192.168.100.2 rm /home/pi/forest-pictures/${OUTPUT}
echo "[$(timestamp)] NIR picture deleted!"

echo "[$(timestamp)] Done!"

#echo "" >> $log_file


