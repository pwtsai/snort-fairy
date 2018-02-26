#!/bin/bash
now=`date +"%Y-%m-%d" -d "12/31/2016"`
end=`date +"%Y-%m-%d" -d "05/15/2017"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y-%m-%d" -d "$now + 1 day"`;
	now_year=`echo $now | awk -F'-' '{printf $1}'`
	now_mon=`echo $now | awk -F'-' '{printf $1"-"$2}'`
	echo "$now_year $now_mon $now" 
        /root/snort-fairy/snort-log-attacker.bash $now_year $now_mon $now
done
