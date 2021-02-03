#!/bin/bash

module purge 
module load gcc/8.3.1
module load hpcx/2.7.0 

# size=$((6 * 1024 * 1024))
dtype=float
SZ=$1
#SZ=$((12 * 1024 * 1024))
ELEMENTS=$(($SZ/4))
omp=$2
EXE="stream_c_v2.exe"
file="test.out"
rm -f ${file}

make clean
# set -x
# gcc -std=c99 -O3 -fopenmp -S -ftree-vectorize ./stream_v2.c
# exit 1
make CFLAGS="-std=c99 -O3 -fopenmp -DSTREAM_ARRAY_SIZE=${ELEMENTS} -DSTREAM_TYPE=${dtype} -DNTIMES=50 -DHEAP_MEM -DVERBOSE"
 
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=${omp}

# mpirun -np 1 -H localhost:1 --bind-to none --report-bindings -x OMP_PLACES -x OMP_PROC_BIND -x OMP_NUM_THREADS ./${EXE} 2>&1 | tee -a ${file};
./${EXE} 2>&1 | tee -a ${file};
