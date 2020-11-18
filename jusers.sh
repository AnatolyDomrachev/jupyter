tmp=/tmp/juser$$
new_users=new_users$(date +%d.%m.%H_%M).txt
awk '{print "if useradd -m -s /bin/bash " $1 "; then  echo " $1 " >> " new " ; ln -s /home/documents /home/" $1 " ; fi"}' new=$new_users $1 > $tmp
awk '{print "echo " $1 ":" $2 "| chpasswd "}' $1 >> $tmp
bash $tmp
rm $tmp
