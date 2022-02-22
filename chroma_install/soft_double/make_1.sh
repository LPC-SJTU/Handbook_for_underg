#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0


cd qmp
make clean
autoreconf -vi
make clean
./configure --prefix=${INSTALL}/qmp  \
     CC=mpicc CXX=mpicxx \
     CXXFLAGS="-fopenmp -D_REENTRANT -g -O3 -finline-limit=50000 -std=c++11 -mavx2" \
     CFLAGS="-fopenmp -D_REENTRANT -g -O3 -std=gnu99" --with-qmp-comms-type=MPI
make
make install
cd ..
