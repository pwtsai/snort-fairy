#!/bin/bash

### Initialization
file_input=`echo $1`
file_output=`echo $2`

cat $file_input | awk '{dups[$0]++} END{for (line in dups) {print dups[line]"\t",line}}' | sort -n -r > $file_output

exit




### For line-by-line check
file_proc=`echo $3`

while IFS='' read -r line || [[ -n "$line" ]]; do
        #echo "$line"

        ip_src=`echo $line | awk -F',' '{printf $(NF-3)}'`
        #ip_src_prefix=`echo $ip_src | awk -F'.' '{printf $1$2}'`
        #ip_dst=`echo $line | awk -F',' '{printf $(NF-1)}'`
        #ip_dst_prefix=`echo $ip_dst | awk -F'.' '{printf $1$2}'`

        reason=`echo $line | awk -F',' '{printf $5}' | awk -F'\"' '{printf $2}'`

        echo $ip_src', '$reason >> $file_proc

done < "$file_input"

# O(n*n*m*m)
cat $file_proc | sort | uniq -c | sort -n -r > $file_output

# O(n*m)
#cat $file_proc | awk '!_[$0]++' | sort -n -r > $file_output




