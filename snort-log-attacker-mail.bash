#!/bin/bash
#------------------------------------------------------------------------------------#
# Author: Pang-Wei Tsai (CCE, NCKUEE)                                                #
# E-mail: cache@mail.ee.ncku.edu.tw                                                  #
# Update: 2011/09/26                                                                 #
#------------------------------------------------------------------------------------#i

# Log
securitymail_dir='/mnt/ramdisk/mailgen_blacklist_tmp'

### Initialization
wr_time=`date +%Y-%m-%d-%H%M`
wr_year=`date +%Y`
wr_year_mon=`date +%Y-%m`
wr_year_mon_day=`date +%Y-%m-%d`

location=`echo /var/www/html/blacklist/$wr_year/$wr_year_mon`
filename=`echo blacklist-$wr_year_mon_day.log`
file_output=`echo "$location/$filename"`

host_name='example.org'
host_ip='10.1.1.1'
admin_name='admin'
admin_mail='admin@example.org'


echo " " > $securitymail_dir
echo "This is the daily report made by $host_name ($host_ip)." >> $securitymail_dir
echo " " >> $securitymail_dir
echo "Host: 'https://'$host_name" >> $securitymail_dir
echo "Project Name: snort-fairy" >> $securitymail_dir
echo "Source: https://github.com/pwtsai/snort-fairy" >> $securitymail_dir
echo "Copyright © 2016-$wr_year MTT License" >> $securitymail_dir
echo " " >> $securitymail_dir
echo " " >> $securitymail_dir
echo "Report SN: blacklist-$wr_year_mon_day.log" >> $securitymail_dir
echo " " >> $securitymail_dir
cat $file_output >> $securitymail_dir
echo " " >> $securitymail_dir
echo " " >> $securitymail_dir
echo "--">> $securitymail_dir
echo "This email contains confidential information of network system." >> $securitymail_dir
echo "Please do not use or disclose it in any way and delete it if you are not the intended recipient." >> $securitymail_dir

cat $securitymail_dir | mail -r "$admin_name <$admin_mail>" -s "NIDS Daily Report ($wr_year_mon_day)" $admin_mail

sleep 1
rm -f $securitymail_dir


