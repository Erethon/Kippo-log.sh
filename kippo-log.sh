#!/bin/bash

#Kippo-log.sh a script to view daily Kippo activity
#Author: Erethon (www.erethon.com)
#Date: 1/11/2012
#Version 0.1
#Usage: .kippo-log.sh [OPTIONS]
#	-f NUMBER: show files that were downloaded in the last NUMBER days


KIPPO_DIR=/home/user/kippo-svn #Directory where Kippo is installed

#Directories to save the log files. If the selected directories do not exist, they will be created automatically
INTERACTED=/home/user/logs/activity
LOGINS=/home/user/noactivity

#SQL parameters
user=yourusername #Your SQL username
password=yourpassword #Your SQL password
db=database_name #Your database name

activity=0
noactivity=0

if [ ! -f $INTERACTED ]; then
	mkdir -p $INTERACTED
fi

if [ ! -f $LOGINS ]; then
	mkdir -p $LOGINS
fi

attempts=`mysql --user=$user --password=$password $db -e 'select count(password) from auth' | grep '[0-9]'`

if [ ! -e .kippo-log.txt ]; then
	touch .kippo-log.txt
	echo "0" > .kippo-log.txt
fi

oldattempts=`cat .kippo-log.txt`
echo $attempts > .kippo-log.txt

for i in $( ls $KIPPO_DIR/log/tty ); do
	size=`du -b $KIPPO_DIR/log/tty/$i | cut -f 1 -s`
	if [ "$size" -lt "300" ]; then  #Never seen someone interacting with Kippo and the logfile being more than 300 bytes, adjust this if you think it's wrong
		mv $KIPPO_DIR/log/tty/$i $LOGINS/$i
		noactivity=`expr $noactivity + 1`
	else
		activity=`expr $activity + 1`
		mv $KIPPO_DIR/log/tty/$i $INTERACTED/$i
	fi
done

newpass=`mysql --user=$user --password=$password $db -e 'select count(distinct password) from auth' | grep '[0-9]'`

echo -e "\nTotal login attempts: $attempts"
echo "Total unique passwords tried: $newpass"
echo "New login attempts: `expr $attempts - $oldattempts`"
echo "Successful attempts: `expr $activity + $noactivity`"
echo "With activity: $activity"
echo "Without activity: $noactivity"


if [ $# -eq 2 ]; then
	if [ $1  == '-f' ]; then
		echo -e "\n------------------------------------------------------- \n"
		find $KIPPO_DIR/log/kippo.log* -mtime -$2 | xargs grep "Command found: wget " | cut -d' ' -f 14-15
	fi
fi
