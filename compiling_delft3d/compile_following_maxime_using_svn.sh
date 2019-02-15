#!/bin/bash

# load all required modules
module purge
module load surfsara
module load eb
module load intel/2017b
module load netCDF/4.4.1.1-intel-2017b
module load netCDF-Fortran/4.4.4-intel-2017b

export FC=mpiifort
export F77=mpiifort
export CC=mpiicc
export CXX=mpiicpc
export MPICXX=mpiicpc
export MPICC=mpiicc
export MPIFC=mpiifort
export MPIF77=mpiifort

# go to the source code folder
cd /scratch-shared/edwinkle/delft3d-svn/delft3d_repository_tag-7545/src/

# (try to) make sure that we have correct permissions to the source code files - NOT NEEDED
# chmod -R 755 .

# cleaning up previous installation/build files
./clean.sh

./autogen.sh

# do we need this???
cd third_party_open/kdtree2
./autogen.sh
cd -

MPICXX=mpiicpc MPICC=mpiicc MPIFC=mpiifort MPIF77=mpiifort CC=mpiicc CXX=mpiicpc FC=mpiifort F77=mpiifort CFLAGS='-O3' CXXFLAGS='-O3' FFLAGS='-O3' FCFLAGS='-O3' ./configure --prefix='/home/edwinkle/opt/delf3d-test/' --with-netcdf --with-mpi

# make ds-install
# - using some cores to speed up
make -j 4 ds-install

cd /scratch-shared/edwinkle/try_to_compile

