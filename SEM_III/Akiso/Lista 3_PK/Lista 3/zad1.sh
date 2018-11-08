#!/bin/bash

OLD_READ=0
OLD_WRITE=0
N=0

while true
do
	READ=$(cat /proc/diskstats | awk '/sda / {print $6}' )
	WRITE=$(cat /proc/diskstats | awk '/sda / {print $10}' )
	READ=$[($READ*512)/1000]
	WRITE=$[($WRITE*512)/1000]
	if [[ $N -ge 1 ]] ; then
		READ_SPEED=$[$READ-$OLD_READ]
		WRITE_SPEED=$[$WRITE-$OLD_WRITE]
		printf "Odczyt: "$READ_SPEED"kB/s	Zapis: "$WRITE_SPEED"kB/s\n"
	fi
	OLD_READ=$READ
	OLD_WRITE=$WRITE
	N=$[$N+1]

	cat /proc/loadavg

	sleep 1
done
