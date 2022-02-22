#!/bin/bash -l
INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0



cd qdpxx
make clean
./autogen.sh
make clean
./configure --prefix=${INSTALL}/qdp++\
       --with-qmp=${INSTALL}/qmp --enable-precision=double --enable-parallel-arch=parscalar\
       --enable-largefile --enable-sse2 --enable-openmp\
       --enable-parallel-io --enable-dml-output-buffering \
       CC=mpicc CXX=mpicxx\
       CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"\
       CXXFLAGS="-fopenmp -D_REENTRANT -g -std=c++11 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"
make -j 32 
make install
cd ..
