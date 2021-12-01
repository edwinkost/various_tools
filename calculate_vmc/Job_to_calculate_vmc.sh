#!/bin/bash 

#~ #PBS -l select=1:ncpus=256:mem=620gb
#~ #PBS -l walltime=72:00:00

#~ Express queue exp_48_128_72:
  #~ Permitted job configurations:
   #~ -lselect=1-16:ncpus=24-48:mem=252gb -lwalltime=240:00:00

#~ #PBS -l select=1:ncpus=48:mem=252gb
#~ #PBS -l walltime=72:00:00

#PBS -l select=1:ncpus=48:mem=124gb
#PBS -l walltime=72:00:00

#PBS -q express -P exp-00044

#PBS -N vmc_calc


bash calculate_vmc.sh "clone_01_30sec" &
bash calculate_vmc.sh "clone_02_30sec" &
bash calculate_vmc.sh "clone_03_30sec" &
bash calculate_vmc.sh "clone_04_30sec" &
bash calculate_vmc.sh "clone_05_30sec" &
bash calculate_vmc.sh "clone_06_30sec" &
bash calculate_vmc.sh "clone_07_30sec" &

wait
