#!/bin/bash
work_dir=/mnt/beegfs/iozone
iozone_dir=/opt/iozone3_465
nodes_file=${iozone_dir}/nodes-list
results_file=${iozone_dir}/results.log

cd ~
rm –rf ${work_dir}
mkdir ${work_dir}
cd ${work_dir}

for (( x=2; x <= 6; x++ )); do
  num_procs=$((2**${x}));
  header="processes: ${num_procs}"
  echo ${header}
  printf"\n\n\n${header}\n\n" >> ${results_file}

  ${iozone_dir}/src/current/iozone -i 0 -i 1 -c -e -w -r 1m-t ${num_procs} \
  –s $((2560/${num_procs}))g -+n -+m ${nodes_file}>>${results_file}
done
