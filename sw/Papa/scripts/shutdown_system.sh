timestamp() {
  date +"%F_%T"
}

#Report to arduino that we go to sleep
python /home/pi/scripts/reportShuttingDown2Arduino.py

echo "[$(timestamp)] Waiting for 30 secs before shutting down..."
sleep 30

echo "[$(timestamp)] Shutting down forest2..."
/home/pi/scripts/apagar_hijito.sh

echo "[$(timestamp)] Shutting down forest1..."
/home/pi/scripts/apagar_papa.sh

