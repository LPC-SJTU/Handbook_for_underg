#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0


cd qio
make clean
autoreconf -vi
make clean
./configure --prefix=${INSTALL}/qio \
     CC=mpicc CXX=mpicxx \
     -with-qmp=${INSTALL}/qmp -enable-largefile -enable-dml-output-buffering\
     CFLAGS="-fopenmp -D_REENTRANT -g -O3 -std=gnu99"
make
make install
cd ..
