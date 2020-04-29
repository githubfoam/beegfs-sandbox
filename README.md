# Beegfs Sandbox

Travis (.com) dev branch:
[![Build Status](https://travis-ci.com/githubfoam/beegfs-sandbox.svg?branch=centos7)](https://travis-ci.com/githubfoam/beegfs-sandbox)  

```
>vagrant up vg-mgmt01

```

```
[vagrant@client01 ~]$ beegfs-ctl --listnodes --nodetype=meta --nicdetails
meta01 [ID: 1]
   Ports: UDP: 8005; TCP: 8005
   Interfaces:
   + eth1[ip addr: 192.168.44.20; type: TCP]
   + eth0[ip addr: 10.0.2.15; type: TCP]

Number of nodes: 1
Root: 1


[vagrant@client01 ~]$ beegfs-ctl --listnodes --nodetype=storage --nicdetails
storage01 [ID: 1]
   Ports: UDP: 8003; TCP: 8003
   Interfaces:
   + eth1[ip addr: 192.168.44.30; type: TCP]
   + eth0[ip addr: 10.0.2.15; type: TCP]

Number of nodes: 1


[vagrant@client01 ~]$ beegfs-ctl --listnodes --nodetype=client --nicdetails
4F34-5DE9100E-client01 [ID: 1]
   Ports: UDP: 8004; TCP: 0
   Interfaces:
   + eth1[ip addr: 192.168.44.40; type: TCP]
   + eth0[ip addr: 10.0.2.15; type: TCP]

Number of nodes: 1


# Displays connections the client is actually using
[vagrant@client01 ~]$ beegfs-net

mgmt_nodes
=============
mgmt01 [ID: 1]
   Connections: TCP: 1 (192.168.44.10:8008);

meta_nodes
=============
meta01 [ID: 1]
   Connections: TCP: 1 (192.168.44.20:8005);

storage_nodes
=============
storage01 [ID: 1]
   Connections: TCP: 1 (192.168.44.30:8003);


# Displays possible connectivity of the services
   [vagrant@client01 ~]$ beegfs-check-servers
   Management
   ==========
   mgmt01 [ID: 1]: reachable at 192.168.44.10:8008 (protocol: TCP)

   Metadata
   ==========
   meta01 [ID: 1]: reachable at 192.168.44.20:8005 (protocol: TCP)

   Storage
   ==========
   storage01 [ID: 1]: reachable at 192.168.44.30:8003 (protocol: TCP)



# Displays free space and inodes of storage and metadata targets
[vagrant@client01 ~]$ beegfs-df
METADATA SERVERS:
TargetID        Pool        Total         Free    %      ITotal       IFree    %
========        ====        =====         ====    =      ======       =====    =
       1      normal      41.0GiB      39.6GiB  97%       20.5M       20.4M 100%

STORAGE TARGETS:
TargetID        Pool        Total         Free    %      ITotal       IFree    %
========        ====        =====         ====    =      ======       =====    =
       1         low      41.0GiB      39.6GiB  97%       20.5M       20.5M 100%

<https://www.beegfs.io/wiki/ManualInstallWalkThrough>
```

Benchmarking
```
starts a write benchmark on all targets of all BeeGFS storage servers with an IO blocksize of 512 KB, using 10 threads (i.e. simulated client streams) per target, each of which will write 200 GB of data to its own file   
$sudo beegfs-ctl --storagebench --alltargets --write --blocksize=512K --size=200G --threads=10

query the benchmark status/result of all targets  
$sudo beegfs-ctl --storagebench --alltargets --status

use the watch command for repeating the query in a given interval in seconds  
$watch -n 1 beegfs-ctl --storagebench --alltargets --status

The generated files will not be automatically deleted when a benchmark is complete   
$beegfs-ctl --storagebench --alltargets --cleanup


IOR  
The value for the number of processes ${NUM_PROCS} depends on the number of clients to test and the number of processes per client. The block size ${BLOCK_SIZE} can be calculated with ((3 * RAM_SIZE_PER_STORAGE_SERVER * NUM_STORAGE_SERVERS) / ${NUM_PROCS}).

Multi-stream Throughput Benchmark  
$ mpirun -hostfile /tmp/nodefile --map-by node -np ${NUM_PROCS} /usr/bin/IOR -wr -i5 -t2m -b ${BLOCK_SIZE} -g -F -e
-o /mnt/beegfs/test.ior

Shared File Throughput Benchmark  
$ mpirun -hostfile /tmp/nodefile --map-by node -np ${NUM_PROCS} /usr/bin/IOR -wr -i5 -t1200k -b ${BLOCK_SIZE} -g -e
-o /mnt/beegfs/test.ior

IOPS Benchmark   
$ mpirun -hostfile /tmp/nodefile --map-by node -np ${NUM_PROCS} /usr/bin/IOR -w -i5 -t4k -b ${BLOCK_SIZE} -F -z -g
-o /mnt/beegfs/test.ior


MDTEST  

The value for the number of processes ${NUM_PROCS} depends on the number on clients to test and the number of processes per client to test. The number of directories can be calculated as ${NUM_DIRS} = (parameter -b ^ parameter -z). The total amount of files should always be higher than 1 000 000, so ${FILES_PER_DIR} is calculated as ${FILES_PER_DIR} = (1000000 / ${NUM_DIRS} / ${NUM_PROCS}).

File Create/Stat/Remove Benchmark   
$ mpirun -hostfile /tmp/nodefile --map-by node -np ${NUM_PROCS} mdtest -C -T -r -F -d /mnt/beegfs/mdtest -i 3 -I ${FILES_PER_DIR} -z 2 -b 8 -L -u   
https://www.beegfs.io/wiki/Benchmark#externaltools

BeeGFS®Benchmarks on IBM OpenPOWERServers   
<https://www.beegfs.io/docs/whitepapers/IBM_OpenPower_P8_BeeGFS_Performance_by_ThinkParQ.pdf>

HowTo Configure and Test BeeGFS with RDMA
<https://community.mellanox.com/s/article/howto-configure-and-test-beegfs-with-rdma>
```
```
Beegfs Sandbox Testing .Cross-platform via vagrant Linux, Windows, Mac.


BeeGFS (formerly FhGFS) is the leading parallel cluster file system.
Latest Stable Version: 7.1.2    
https://www.beegfs.io

Centos 7.7  
https://www.centos.org/download/

Download Vagrant.  
>vagrant version
Installed Version: 2.2.6
Latest Version: 2.2.6  
https://www.vagrantup.com/downloads.html

Ansible Local Provisioner   
https://www.vagrantup.com/docs/provisioning/ansible_local.html

Ansible
ansible --version ansible 2.9.1  
https://www.ansible.com/

Download Oracle VM VirtualBox  
>VBoxManage -version
6.0.14r133895       
https://www.virtualbox.org/wiki/Downloads
```
