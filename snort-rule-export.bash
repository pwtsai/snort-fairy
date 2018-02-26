#!/bin/bash

### Initialization
file_input=`echo $1`
file_output=`echo $2`

### For line-by-line check
file_proc=`echo $3`

number='11'

while IFS='' read -r line || [[ -n "$line" ]]; do
        #echo "$line"

	number=$(( $number + 1))

	count=`echo $line | awk '{printf $1}'`
	ip=`echo $line | awk '{printf $2}' | awk -F',' '{printf $1}'`
	ip_prefix=`echo $ip | awk -F'.' '{printf $1"."$2"."}'`
	reason=`echo $line | awk -F'\"' '{printf NF}'`

	#if [ "$count" -gt 100 ] && [ "$ip_prefix" != "10.1" ] && [ "$reason" != "Login" ];then
	#	echo "$number deny host $ip" >> $file_output
	#fi

done < "$file_input"




