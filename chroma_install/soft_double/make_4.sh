#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0



cd qdp
make clean
autoreconf -f
make clean
./configure --prefix=${INSTALL}/qdp \
       CC=mpicc CXX=mpicxx \
       --with-qmp=${INSTALL}/qmp --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --enable-sse\
       CFLAGS="-Wall -std=gnu99 -O3 -fargument-noalias-global -funroll-all-loops -fpeel-loops -ftree-vectorize"
make -j 32
make install
cd ..
