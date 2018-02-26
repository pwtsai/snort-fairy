#!/bin/bash

### Initialization
RULE_PATH='/etc/snort/rules'
EXT_RULE_PATH='/etc/snort/ext_rules'
WWW_PATH='/var/www/html'
WWW_FILE='3Bf87JkU3WeS35Nc.log'


### Update rules
mkdir -p $RULE_PATH
mkdir -p $EXT_RULE_PATH

# Update Rules from https://rules.emergingthreats.net/
cd $EXT_RULE_PATH
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-attack_response.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-botcc.portgrouped.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-botcc.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-ciarmy.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-compromised.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-dns.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-dos.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-dshield.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-exploit.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-ftp.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-inappropriate.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-malware.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-misc.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-mobile_malware.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-rpc.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-scada.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-scan.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-shellcode.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-snmp.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-sql.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-telnet.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-tftp.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-tor.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-trojan.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-web_server.rules
wget -q -N -T 10 -t 3 https://rules.emergingthreats.net/open/snort-2.9.0/rules/emerging-worm.rules

# Update Rules from https://sslbl.abuse.ch/blacklist/
wget -q -N -T 10 -t 3 https://sslbl.abuse.ch/blacklist/sslipblacklist.rules

# Update Rules from https://feodotracker.abuse.ch/blocklist/
wget -q -N https://feodotracker.abuse.ch/blocklist/?download=snort -O feodotrackerblacklist.rules

# Update Rules from https://zeustracker.abuse.ch/blocklist.php
wget -q -N https://zeustracker.abuse.ch/blocklist.php?download=snort -O zeustrackerblacklist.rules

### Change owner to snort
chown snort:snort -R $EXT_RULE_PATH


### Generate renew log
rm -f $WWW_PATH/$WWW_FILE
touch $WWW_PATH/$WWW_FILE

# Check official snort rules first
        stat_rule=`stat -c %y $RULE_PATH/blacklist.rules | awk '{printf $1}'`
        echo 'snapshot-2982 ('$stat_rule')' >> $WWW_PATH/$WWW_FILE

# Check extension rules
rulefile=(`cat /etc/snort/snort.conf | grep EXT_RULE_PATH | grep include | sed /#/d | awk -F'\\/' '{printf $2" "}'`)

for i in "${rulefile[@]}"
do
        stat_rule=`stat -c %y $EXT_RULE_PATH/$i | awk '{printf $1}'`
        echo $i '('$stat_rule')' >> $WWW_PATH/$WWW_FILE
done

