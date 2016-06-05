##Create virtual static machines
This project makes assumptions about using existing machines.  We can quickly create some machines with vagrant if you don't have any to play with.

###Prerequisites
* Vagrant
  * yum install vagrant
* Virtual Box
  * yum install virtualbox

###Commands
* sameNodes/install.sh 4 1024 1
  * 4 nodes named (1,2,3,4) will be created with 1GB ram and 1 cpu each
* namedNodes/install.sh 3
  * 3 nodes will be created named (primary,secondary,1) with 2GB and 2 cpu each
