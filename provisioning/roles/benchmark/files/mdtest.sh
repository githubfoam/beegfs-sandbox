#!/bin/bash
work_dir=/mnt/beegfs/mdtest
mdtest_dir=/opt/mdtest-1.9.3
nodes_file=/tmp/nodes-list
results_file=${mdtest_dir}/results.log

cd ~
rm –rf ${work_dir}
mkdir ${work_dir}
#cd ${work_dir}

for (( x=0; x <= 6; x++ )); do
  num_procs=$((2**${x}));
  files_per_dir=$((1000000/64/${num_procs}))
  header="processes: ${num_procs}, files per directory: ${files_per_dir}"

  echo ${header}
  printf"\n\n\n${header}\n\n" >> ${results_file}

  rm –rf ${work_dir}/*
  mpirun --mca btl self,tcp --map-by node -hostfile ${nodes_file} \
  -np ${num_procs} ${mdtest_dir}/mdtest -C -T -d ${work_dir} -i 5 \
  -I ${files_per_dir} -z 2 -b 8-L -u -F -r >> ${results_file}
done
