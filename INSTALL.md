
### Change to be root
sudo su -
cd ~/
git clone https://github.com/pwtsai/snort-fairy.git


### Install dependency packages
apt-get update
apt-get -y install apache2 mrtg snmpd autorecon build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex  zlib1g-dev liblzma-dev openssl libssl-dev libtool automake wget git


### Download Snort source files, please get the latest one
cd /opt/
wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
wget https://www.snort.org/downloads/snort/snort-2.9.11.1.tar.gz


### Install DAQ and Snort
tar xvfz daq-2.0.6.tar.gz
cd daq-2.0.6
./configure; make; sudo make install
tar xvfz snort-2.9.11.1.tar.gz
cd snort-2.9.11.1
./configure --enable-sourcefire
make
make install


### Remove files
rm -rf /opt/daq-2.0.6
rm -rf /opt/snort-2.9.11.1


### Check installation status (Optional)
snort -V


#### Test rule reading (Optional)
snort -T -c /etc/snort/snort.conf


### Install PFRING
cd /opt
git clone https://github.com/ntop/PF_RING.git
cd PF_RING/kernel
make
insmod ./pf_ring.ko
cd ../userland
make
cd lib 
./configure 
make 
make install


### Compule daq module with PFRING
cd ../userland/snort/pfring-daq-module
autoreconf -ivf
./configure
make
make install


### Check pf_ring module status, if it is not listed, reboot or using insmod (Optional)
lsmod | grep pf_ring


### check files in /root/snort-fairy/conf, setup your corresponding configurations


### Initialize webpage
cp -r /root/snort-fairy/html/* /var/www/html
mkdir -p /var/www/html/mrtg 
mkdir -p /var/www/html/blacklist 
mkdir -p /var/www/html/arch 
mkdir -p /var/www/html/full 
mkdir -p /var/www/html/history
service apache2 restart


### Restart the host
reboot


### Some manual configutation for speedup log generation 

# In snort-log-attacker.bash (Optional)
grep -hr --include \*-src.log YOUR_HOME_SUBNET $folder_log_input | grep -e TROJAN -e Trojan -e CNC -e CnC -e C\&C -e Bot -e WORM -e MOBILE_MALWARE -e MALWARE -e Malware | awk '$1=$1' | cut -d' ' -f2- | sort -u | awk -F',' '{print $1"\t"$2}' \

# In snort-rule-export.bash (Optional)
if [ "$count" -gt 100 ] && [ "$ip_prefix" != "YOUR_HOME_SUBNET" ] && [ "$reason" != "Login" ];then
cache@ns:~/snort-fairy$ vi snort-rule-export.bash



