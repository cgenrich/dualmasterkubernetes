#!/bin/bash
hostAddress=`vagrant ssh 1 -c "ifconfig enp0s8 | grep 'inet' | cut -d: -f2 "|awk '{print $2}'`
# create a cache directory outside the virtual machines
# the directory must be wide open for the virtual machine to create directories
# the cache will survive destroy
mkdir -p .vagrant/squidCache
chmod g+x .vagrant/squidCache/
setfacl -d -m g::rwx .vagrant/squidCache/
setfacl -d -m o::rwx .vagrant/squidCache/
>.vagrant/vagrantHostsIp
vagrant ssh 1 -c "sudo yum -y install squid;sudo sed -i 's|#cache_dir ufs /var/spool/squid 100 16 256|cache_dir ufs /vagrant/.vagrant/squidCache 7000 16 256|' /etc/squid/squid.conf;sudo systemctl start squid;sudo systemctl enable squid"
for host in `ls .vagrant/machines/`
do

        vagrant ssh $host -c "sudo sed -i -e '\$aproxy=http://$hostAddress:3128' /etc/yum.conf;sudo sed -i 's/^mirrorlist/#mirrorlist/g; s/^#baseurl/baseurl/g' /etc/yum.repos.d/CentOS-Base.repo;sudo sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf;sudo systemctl stop firewalld;sudo systemctl disable firewalld;sudo yum -y install ntp;sudo systemctl start ntpd;sudo systemctl enable ntpd"
	echo `vagrant ssh $host -c "ifconfig enp0s8 | grep 'inet' | cut -d: -f2 "|awk '{print $2}'`>>vagrantHostsIp
done
echo "completed host setup, storing vagrant IP addresses in .vagrant/vagrantHostsIp"
cat .vagrant/vagrantHostsIp
