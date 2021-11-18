#!/bin/bash

ori_dir=$PWD
#all_dirs=(gmx2021.3_n1080ti gmx2021.3_n2080ti gmx2021.3_n1080ti_update-gpu gmx2021.3_n2080ti_update-gpu)
#all_dirs=(.cpu8.gmx2021.3 .cpu8.gmx2020.3)
all_dirs=(.cpu8.gmx2021.4)
for i in ${all_dirs[@]}; do
  echo $i
  #mkdir $i
  cd $i
  # Copy
  #cp $ori_dir/simulation_files/* .
  #ln -s $ori_dir/charmm36.ff .
  #cp $ori_dir/run_aws.cmd .
  qsub run_aws.cmd
  cd ..
done
