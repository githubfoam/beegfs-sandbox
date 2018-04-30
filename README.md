# Beegfs Sandbox
Beegfs Sandbox Testing .Cross-platform via vagrant Linux, Windows, Mac.
(work under progress)

BeeGFS (formerly FhGFS) is the leading parallel cluster file system.
Latest Stable Version: 6.18.    
https://www.beegfs.io

Centos 7.4  
https://www.centos.org/download/

Download Vagrant.  
vagrant version Installed Version: 2.0.4   
https://www.vagrantup.com/downloads.html

Ansible Local Provisioner   
https://www.vagrantup.com/docs/provisioning/ansible_local.html

Ansible
ansible --version ansible 2.5.1  
https://www.ansible.com/

Download Oracle VM VirtualBox  
VBoxManage -version 5.2.8r121009        
https://www.virtualbox.org/wiki/Downloads

Benchmarking

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


mdtest  

The value for the number of processes ${NUM_PROCS} depends on the number on clients to test and the number of processes per client to test. The number of directories can be calculated as ${NUM_DIRS} = (parameter -b ^ parameter -z). The total amount of files should always be higher than 1 000 000, so ${FILES_PER_DIR} is calculated as ${FILES_PER_DIR} = (1000000 / ${NUM_DIRS} / ${NUM_PROCS}).

File Create/Stat/Remove Benchmark   
$ mpirun -hostfile /tmp/nodefile --map-by node -np ${NUM_PROCS} mdtest -C -T -r -F -d /mnt/beegfs/mdtest -i 3 -I ${FILES_PER_DIR} -z 2 -b 8 -L -u
https://www.beegfs.io/wiki/Benchmark#externaltools

BeeGFS®Benchmarks on IBM OpenPOWERServers
https://www.beegfs.io/docs/whitepapers/IBM_OpenPower_P8_BeeGFS_Performance_by_ThinkParQ.pdf
