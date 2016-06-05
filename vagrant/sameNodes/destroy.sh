#!/bin/bash
export VHOSTS_NUM=`ls .vagrant/machines/|wc -l`
export VHOSTS_MEM=256
export VHOSTS_CPU=1
vagrant destroy -f
if [[ $? -eq 0 ]] ; then
	rm -fr .vagrant/machines
fi
