lockfile=/home/adom/SIZE/LOCKED_USERS.txt
uids=$(ps -Al | grep jupyterhub- | awk '{print $3}')
default_size=$(awk  '{if($1=="default_size") print $2}' $1)
echo default_size = $default_size

echo  $(date) > $lockfile
for uid in $uids
do
	home=$(awk -F : '{if($3==uid) print $6}' uid=$uid /etc/passwd)
	uname=$(awk -F : '{if($3==uid) print $1}' uid=$uid /etc/passwd)
	h_size=$(du -s $home | awk '{print $1}')
	m_size=$(awk  '{if($1==uname) print $2}' uname=$uname $1)
	
	if [ X$m_size = X ]
	then
		m_size=$default_size
	fi

	m_size=$(echo $m_size*1024|bc)
	pid=$(ps -Al | grep jupyterhub- | awk '{if($3==uid) print $4}' uid=$uid)

	echo $uname $home $h_size $m_size $pid

	if [ $h_size -gt $m_size ]
	then
		kill $pid
		echo $uname >> $lockfile
	fi

done
