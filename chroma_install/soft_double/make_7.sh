#!/bin/bash -l

INSTALL=/dssg/home/acct-phyww/phyww/chroma/chroma_double_gcc-8.5
export PATH=$INSTALL/bin:$PATH


module purge 
module load openmpi/4.1.1-gcc-8.5.0
module load gcc/8.5.0


cd chroma
make clean
./autogen.sh
make clean
./configure --prefix=${INSTALL}/chroma_double \
        --with-qmp=${INSTALL}/qmp --with-qdp=${INSTALL}/qdp++ --enable-qop-mg \
        --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --with-qdpc=${INSTALL}/qdp \
        --with-qopqdp=${INSTALL}/qopqdp --enable-precision=double --enable-parallel-arch=parscalar\
        --enable-sse3 --enable-sse-wilson-dslash \
        FC=mpif90 CC=mpicc CXX=mpicxx \
        CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"\
        CXXFLAGS="-fopenmp -D_REENTRANT -g -std=c++11 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math -fpermissive"
make -j 32
make install
cd ..
