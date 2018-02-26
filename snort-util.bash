#!/bin/bash

### System Part
cpu_arr=(`mpstat -P ALL 1 1 | awk '/Average:/ && $2 ~ /[0-9]/ {printf $3" "}'`)
cpu_sum=$( IFS="+"; bc <<< "${cpu_arr[*]}" )
cpu_util=$(echo $cpu_sum / ${#cpu_arr[@]} | bc -l | awk '{printf "%.4f", $0}')

ram_util=`free | grep cache: | awk '{printf $3/($4+$3) * 100}' | awk '{printf "%.4f", $0}'`

m1=`cat /sys/class/net/eth2/statistics/rx_bytes`
sleep 10
m2=`cat /sys/class/net/eth2/statistics/rx_bytes`
nic_raw_util=`echo $(( $m2 - $m1 ));`
nic_util=`echo $(( $nic_raw_util / 1310720 ));`

r1=`cat /sys/class/net/eth2/statistics/rx_packets`
sleep 10
r2=`cat /sys/class/net/eth2/statistics/rx_packets`
nic_raw_rec=`echo $(( $r2 - $r1 ));`
nic_rec=`echo $(( $nic_raw_rec / 10 ));`

d1=`cat /sys/class/net/eth2/statistics/rx_dropped`
sleep 10
d2=`cat /sys/class/net/eth2/statistics/rx_dropped`
nic_raw_drop=`echo $(( $d2 - $d1 ));`
nic_drop=`echo $(( $nic_raw_drop / 10 ));`

thread_num=`ps -C snort --no-headers | wc -l`

echo $cpu_util' %',$ram_util' %',$nic_util' Mbps',$nic_rec' pps',$nic_drop' pps',$thread_num > /var/www/html/A2YR5bXP3d8kg9Sc.log


### Rule Part
### Initialization
RULE_PATH='/etc/snort/rules'
EXT_RULE_PATH='/etc/snort/ext_rules'
WWW_PATH='/var/www/html'
WWW_FILE='3Bf87JkU3WeS35Nc.log'

rm -f $WWW_PATH/$WWW_FILE
touch $WWW_PATH/$WWW_FILE

# Check official snort rules first
        stat_rule=`stat -c %y $RULE_PATH/blacklist.rules | awk '{printf $1}'`
        echo 'snapshot-2990 ('$stat_rule')' >> $WWW_PATH/$WWW_FILE

# Check extension rules
rulefile=(`cat /etc/snort/snort.conf | grep EXT_RULE_PATH | grep include | sed /#/d | awk -F'\\/' '{printf $2" "}'`)

for i in "${rulefile[@]}"
do
        stat_rule=`stat -c %y $EXT_RULE_PATH/$i | awk '{printf $1}'`
        echo $i '('$stat_rule')' >> $WWW_PATH/$WWW_FILE
done


