#!/bin/bash

#cat ${file} | grep Copy | awk '{print $2" "$3}'
file=$1

cat ${file} | grep Copy | awk '{print $3}'
# echo " "
cat ${file} | grep Scale | awk '{print $3}'
# echo " "
cat ${file} | grep 2ArrMult | awk '{print $3}'
# echo " "
cat ${file} | grep Add | awk '{print $3}'
# echo " "
cat ${file} | grep Triad | awk '{print $3}'
