#!/bin/bash

dirs=$(ls /home)
res=/home/adom/SIZE/jsize.txt

echo $(date) > $res

for dir in $dirs
do
	if [ -d /home/$dir ]
	then
		du -s /home/$dir | sed s/\\\/home\\\///
	fi
done | sort -nr | awk '{printf("%-15s %.0f\n"), $2, $1/1024}' >> $res

