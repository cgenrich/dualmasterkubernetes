#!/bin/bash

if [[ $# -eq 0 ]] ; then
	echo "Usage: "`basename "$0"`" <number of hosts> [memory] [cpu]"
	echo "	Memory will default to 2GB and CPU to 2"
	exit 0
fi
nhosts=$1
if [[ -z $nhosts ]] ; then
	echo "Number of hosts must be specified"
	exit 2
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
../baseSetup.sh
