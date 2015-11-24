# Define a timestamp function
#timestamp() {  
#  date +"%F_%T"
#}

filename=$1
#echo $filename
python /home/pi/scripts/take_picture.py $filename
#echo "[$(timestamp)] RGB picture taken!"
