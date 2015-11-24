space=" "
date_str=$1$space$2
echo $date_str
#str="\"2015-6-23 17:14:45\""
quote="'"
str=$quote$date_str$quote
command="sudo date -s "$str
echo $command
eval $command
#sudo date -s $str
