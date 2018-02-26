#!/bin/bash
### Initialization
wr_time=`date +%Y-%m-%d-%H%M`
wr_year=`date +%Y`
wr_year_mon=`date +%Y-%m`
wr_year_mon_day=`date +%Y-%m-%d`

#wr_year="$1"
#wr_year_mon="$2"
#wr_year_mon_day="$3"

### Initialization
folder_log_input=`echo /var/www/html/arch/$wr_year/$wr_year_mon/$wr_year_mon_day`
location=`echo /var/www/html/blacklist/$wr_year/$wr_year_mon`
mkdir -p $location

filename=`echo blacklist-$wr_year_mon_day.log`
file_output=`echo "$location/$filename"`

grep -hr --include \*-src.log . $folder_log_input | grep -e TROJAN -e Trojan -e CNC -e CnC -e C\&C -e Bot -e WORM -e MOBILE_MALWARE -e MALWARE -e Malware | awk '$1=$1' | cut -d' ' -f2- | sort -u | awk -F',' '{print $1"\t"$2}' \
| sed '/Login/d' \
| sed '/ET TROJAN MS Remote Desktop micros User Login Request/d' \
| sed '/ET TROJAN MS Terminal Server Single Character Login possible Morto inbound/d' \
> $file_output

bash /root/snort-fairy/snort-log-attacker-mail.bash

#cat $file_input | awk '!a[$0]++' > $file_output


