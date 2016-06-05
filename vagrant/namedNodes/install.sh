#!/bin/bash

if [[ $# -eq 0 ]] ; then
	echo "Usage: "`basename "$0"`" <number of hosts> [memory] [cpu]"
	echo "	At least two will always be created"
	exit 0
fi
nhosts=$1
if [[ $nhosts -lt 2 ]] ; then
	nhosts=0
else
	nhosts=$((nhosts-2))
fi
memory=$2
if [[ -z "$memory" ]] ; then
	memory=2048
fi
cpu=$3
if [[ -z "$cpu" ]] ; then
	cpu=2
fi

export VHOSTS_NUM=$nhosts
export VHOSTS_MEM=$memory
export VHOSTS_CPU=$cpu
#define the host names

vagrant up

#loop through hosts and boot strap
exit 1
systemctl stop firewalld
systemctl disable firewalld

yum -y install ntp
systemctl start ntpd
systemctl enable ntpd


