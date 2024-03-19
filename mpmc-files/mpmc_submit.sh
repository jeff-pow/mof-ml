#!/bin/bash
#BSUB -n 4
#BSUB -R "select[avx2] span[hosts=1]"
#BSUB -W 96:00
#BSUB -J xjobx
#BSUB -o stdout.%J
#BSUB -e stderr.%J

. /usr/share/Modules/init/bash
module purge
module load cuda/9.0 cmake/3.21.2 gcc/10.2.0 openmpi-gcc/openmpi4.1.0-gcc10.2.0 mkl/2017

mpirun /usr/local/usrapps/ssp/mpmc/mpmc *.inp > runlog.log
