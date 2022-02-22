#!/bin/bash -l

INSTALL=/lustre/home/acct-phyww/phyww-mhchu/bin
export PATH=$INSTALL/bin:$PATH



module load openmpi/3.1.5-gcc-4.8.5
module load gcc/8.3.0-gcc-4.8.5



#### delete fopenmp


#rm -rf qmp
#git clone --recursive  git://github.com/usqcd-software/qmp.git
cd qmp
autoreconf -vi 
./configure --prefix=${INSTALL}/qmp  \
     CC=mpicc CXX=mpicxx \
     CXXFLAGS="-fopenmp -D_REENTRANT -g -O3 -finline-limit=50000 -std=c++11 -mavx2" \
     CFLAGS="-fopenmp -D_REENTRANT -g -O3 -std=gnu99" --with-qmp-comms-type=MPI
make 
make install
cd ..

#rm -rf qio
#git clone --recursive  git://github.com/usqcd-software/qio.git
cd qio
autoreconf -vi
./configure --prefix=${INSTALL}/qio \
     CC=mpicc CXX=mpicxx \
     -with-qmp=${INSTALL}/qmp -enable-largefile -enable-dml-output-buffering\
     CFLAGS="-fopenmp -D_REENTRANT -g -O3 -std=gnu99" 
make 
make install
cd ..

#rm -rf qla
#git clone --recursive  git://github.com/usqcd-software/qla.git
cd qla
autoreconf -f
./configure --prefix=${INSTALL}/qla \
      CC=mpicc CXX=mpicxx \
      --enable-sse3 --enable-temp-precision=D \
      CFLAGS="-Wall -std=gnu99 -msse3 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer"
make 
make install
cd ..

#rm -rf qdp
#git clone --recursive  git://github.com/usqcd-software/qdp.git
cd qdp
autoreconf -f
./configure --prefix=${INSTALL}/qdp \
       CC=mpicc CXX=mpicxx \
       --with-qmp=${INSTALL}/qmp --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --enable-sse\
       CFLAGS="-Wall -std=gnu99 -O3 -fargument-noalias-global -funroll-all-loops -fpeel-loops -ftree-vectorize"
make 
make install
cd .. 

#rm -rf qopqdp
#git clone --recursive  git://github.com/usqcd-software/qopqdp.git
cd qopqdp
autoreconf -f
./configure --prefix=${INSTALL}/qopqdp \
       CC=mpicc CXX=mpicxx \
       --with-qmp=${INSTALL}/qmp --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --with-qdp=${INSTALL}/qdp\
       --enable-underscores CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3"
make 
make install
cd ..

#rm -rf qdpxx
#git clone --recursive  git://github.com/usqcd-software/qdpxx.git

cd qdpxx
./autogen.sh
./configure --prefix=${INSTALL}/qdp++\
       --with-qmp=${INSTALL}/qmp --enable-precision=double --enable-parallel-arch=parscalar\
       --enable-largefile --enable-sse2 --enable-openmp\
       --enable-parallel-io --enable-dml-output-buffering \
       CC=mpicc CXX=mpicxx\
       CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"\
       CXXFLAGS="-fopenmp -D_REENTRANT -g -std=c++11 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"
make  
make install
cd ..

#cd qdpxx_single
#./autogen.sh
#./configure --prefix=${INSTALL}/qdp++_single\
#       --with-qmp=${INSTALL}/qmp --enable-precision=single --enable-parallel-arch=parscalar\
#       --enable-largefile --enable-sse2 --enable-openmp\
#       --enable-parallel-io --enable-dml-output-buffering \
#       CC=mpicc CXX=mpicxx\
#       CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"\
#       CXXFLAGS="-fopenmp -D_REENTRANT -g -std=c++11 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"
#make  
#make install
#cd ..

#rm -rf chroma
#git clone --recursive  git://github.com/JeffersonLab/chroma.git
cd chroma
./autogen.sh
./configure --prefix=${INSTALL}/chroma_double \
        --with-qmp=${INSTALL}/qmp --with-qdp=${INSTALL}/qdp++ --enable-qop-mg \
        --with-qio=${INSTALL}/qio --with-qla=${INSTALL}/qla --with-qdpc=${INSTALL}/qdp \
        --with-qopqdp=${INSTALL}/qopqdp --enable-precision=double --enable-parallel-arch=parscalar\
        --enable-sse3 --enable-sse-wilson-dslash \
        FC=mpif90 CC=mpicc CXX=mpicxx \
        CFLAGS="-fopenmp -D_REENTRANT -g -std=gnu99 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math"\
        CXXFLAGS="-fopenmp -D_REENTRANT -g -std=c++11 -O3 -mfpmath=sse -ffast-math -funroll-loops -fprefetch-loop-arrays -fomit-frame-pointer -ftree-vectorize -fassociative-math -fpermissive"
make 
make install
cd ..


#cd source_codes
#make
#cd ..

