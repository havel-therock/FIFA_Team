#!/bin/bash

printf "%7s Pid: %8s PPid: %8s NSsid: %8s Threads: %8s State: %15s FDSize %2s Opened files:\n"

for PROCESS in /proc/* ;
do
	PATTERN=[0-9]$

	if [[ $PROCESS =~ $PATTERN ]]; then
		I=0
		while read L ; do
			TAB[$I]=$L
			I=$[I + 1]
		done < $PROCESS/status

	printf "%3s${TAB[5]#*:}%10s${TAB[6]#*:}%10s${TAB[15]#*:}%10s${TAB[33]#*:}%10s${TAB[2]#*:}%6s${TAB[10]#*:}%8s"$(ls $PROCESS/fd | wc -l)"\n"
	fi
done
