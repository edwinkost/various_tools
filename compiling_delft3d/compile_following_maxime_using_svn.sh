#!/bin/bash


# set the following variables:
# - (temporary) working folder (i.e. for downloading, etc). 
MY_WORKING_FOLDER="/scratch-shared/edwinkle/compiling_delft3d/"
# - svn (deltares) delft3d user name 
SVN_USER_NAME="hsutanudjajacchms99"
# - (deltares) delft3d svn site
SVN_SRC_SITE=
# - folder where delft3d version from the (deltares) delft3d svn site will be saved (relative to MY_WORKING_FOLDER)
SVN_SRC_FOLDER=
# - folder where delft3d version from marcio is located
OWN_SRC_FOLDER=
# - target folder where delft3d will be installed
TARGET_INST_FOLDER=


# set, make and print (temporary) working folder
mkdir -p ${MY_WORKING_FOLDER}
cd ${MY_WORKING_FOLDER}
pwd


# obtain the delft3d from the Deltares site
svn 

svn --username hsutanudjajacchms99 checkout https://svn.oss.deltares.nl/repos/delft3d/tags/delft3d4/7545 delft3d_repository_tag-7545

# replace and 


# load all required modules
module purge
module load surfsara
module load eb
module load intel/2017b
module load netCDF/4.4.1.1-intel-2017b
module load netCDF-Fortran/4.4.4-intel-2017b

# set the correct variables
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

#~ # do we need this???
#~ cd third_party_open/kdtree2
#~ ./autogen.sh
#~ cd -

MPICXX=mpiicpc MPICC=mpiicc MPIFC=mpiifort MPIF77=mpiifort CC=mpiicc CXX=mpiicpc FC=mpiifort F77=mpiifort CFLAGS='-O3' CXXFLAGS='-O3' FFLAGS='-O3' FCFLAGS='-O3' ./configure --prefix='/home/edwinkle/opt/delf3d-test/' --with-netcdf --with-mpi

make ds-install

# go back to the script folder
#~ cd /scratch-shared/edwinkle/try_to_compile
cd ~/github/edwinkost/various_tools/compiling_delft3d
