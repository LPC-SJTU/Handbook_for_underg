#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0


cd qla
make clean
autoreconf -f
make clean
./configure --prefix=${INSTALL}/qla \
      CC=mpicc CXX=mpicxx \
      --enable-sse3 --enable-temp-precision=D \
      CFLAGS="-Wall -std=gnu99 -msse3 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer"
make -j 32
make install
cd ..
