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
* ./destroy.sh
  * must be run inside either sameNodes/ or namedNodes/
  * any virtual machines created will be destroyed

###Remote SSH enabled
* Normally *vagrant ssh <vm>* is used
  * However, this is suboptimal since the Vagrantfile must be available
* Work anywhere using normal *ssh vagrant@ipaddress*
  * ~/.ssh/config must be updated with VM configuration
```
Host 172.*.*.*
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  IdentitiesOnly yes
  User vagrant
  IdentityFile ~/github/dualmasterkubernetes/vagrant/insecure_private_key
  PasswordAuthentication no
```
**Verify insecure_private_key path**

###Optimization
* A package cache for yum is setup using squid
  * The first node is configured with squid
  * All yum requests use the squid proxy
  * The cache is stored on the host machine and survives **vagrant destroy**
