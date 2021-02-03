#!/bin/bash

module purge 
module load gcc/8.3.1
module load hpcx/2.7.0 

# size=$((6 * 1024 * 1024))
dtype=float
omp=$1

set -x
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=${omp}

file="hali_output_stream_1MB-64MB_OMP=${omp}.out"

rm -f ${file}

EXE="stream_c_v2.exe"

for i in `cat sizes.64`; do
    echo $i;
    make clean
    make CFLAGS="-O2 -fopenmp -DSTREAM_ARRAY_SIZE=$i -DSTREAM_TYPE=${dtype} -DNTIMES=50"

    mpirun -np 1 -H localhost:1 --bind-to none --report-bindings -x OMP_PLACES=cores -x OMP_PROC_BIND=close -x OMP_NUM_THREADS=${omp} ./${EXE} 2>&1 | tee -a ${file};
done
