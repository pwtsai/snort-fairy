#!/bin/bash

### Initialization
wr_time=`date +%Y-%m-%d-%H%M`
wr_year=`date +%Y`
wr_year_mon=`date +%Y-%m`
wr_year_mon_day=`date +%Y-%m-%d`


### FULL log
folder_log_input='/var/log/snort/alert.csv'
folder_log_output='/var/www/html/full'

location=`echo $folder_log_output/$wr_year/$wr_year_mon/$wr_year_mon_day`
filename=`echo $wr_time.full.log`
mkdir -p $location
mv /var/log/snort/alert.csv $location/$filename
touch $folder_log_input


### ARCH log

if [ -d "/mnt/ramdisk" ]; then
	folder_ramdisk='/mnt/ramdisk'
else
	mkdir -p /mnt/ramdisk
	mount -t tmpfs -o size=8G tmpfs /mnt/ramdisk/
	folder_ramdisk='/mnt/ramdisk'
fi

cd $folder_ramdisk
rm -f $folder_ramdisk/snortlog.*

file_input_raw='/var/log/snort/alert_lite_src.csv'
file_input=`echo $folder_ramdisk/snortlog.src`
mv $file_input_raw $file_input
touch $file_input_raw

file_input_raw2='/var/log/snort/alert_lite_dst.csv'
file_input2=`echo $folder_ramdisk/snortlog.dst`
mv $file_input_raw2 $file_input2
touch $file_input_raw2

# restart the snort first!
bash /root/snort-fairy/snort-enable.bash &
sleep 15

folder_log_output='/var/www/html/arch'
location=`echo $folder_log_output/$wr_year/$wr_year_mon/$wr_year_mon_day`
mkdir -p $location

filename=`echo $wr_time.arch-src.log`
file_output=`echo "$location/$filename"`
filename2=`echo $wr_time.arch-dst.log`
file_output2=`echo "$location/$filename2"`

timeout 55m bash /root/snort-fairy/snort-log-analyzer.bash $file_input $file_output &
timeout 55m bash /root/snort-fairy/snort-log-analyzer.bash $file_input2 $file_output2 &

sleep 5
rm -f $folder_ramdisk/snortlog.*

