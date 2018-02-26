#!/bin/bash

core_max=`grep -c ^processor /proc/cpuinfo`

core_use=`echo $core_max`
#core_use=$(( $core_max ))
#core_use=12

killall snort >/dev/null 2>&1
sleep 10

/usr/local/bin/snort -c /etc/snort/snort.conf -D -i eth2 -R 151 >/dev/null 2>&1
echo "Snort dameon is up (1/$core_use)"
sleep 2

for (( i=2; i<=$core_use; i++ ))
do
	/usr/local/bin/snort -c /etc/snort/snort.conf -D -i eth2 -R 15$i & >/dev/null 2>&1
	echo "Snort dameon is up ($i/$core_use)"
	sleep 2
done

