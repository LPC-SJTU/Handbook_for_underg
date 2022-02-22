#!/bin/bash -l

INSTALL=/lustre/home/acct-phyww/phyww/bin
export PATH=$INSTALL/bin:$PATH



module load openmpi/3.1.4-gcc-4.8.5
module load gcc/8.3.0-gcc-4.8.5



#### delete fopenmp


rm -rf qmp
git clone --recursive  git://github.com/usqcd-software/qmp.git

rm -rf qio
git clone --recursive  git://github.com/usqcd-software/qio.git

rm -rf qla
git clone --recursive  git://github.com/usqcd-software/qla.git

rm -rf qdp
git clone --recursive  git://github.com/usqcd-software/qdp.git
rm -rf qopqdp
git clone --recursive  git://github.com/usqcd-software/qopqdp.git

rm -rf qdpxx
git clone --recursive  git://github.com/usqcd-software/qdpxx.git


rm -rf chroma
git clone --recursive  git://github.com/JeffersonLab/chroma.git
