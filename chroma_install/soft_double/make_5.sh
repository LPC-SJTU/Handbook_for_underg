#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5

module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0


cd qopqdp
make clean
autoreconf -f
make clean
./configure --prefix=${INSTALL}/qopqdp \
       CC=mpicc CXX=mpicxx \
       --with-qmp=${INSTALL}/qmp --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --with-qdp=${INSTALL}/qdp\
       --enable-underscores CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3"
make -j 32
make install
cd ..
