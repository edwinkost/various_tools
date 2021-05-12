#!/bin/bash

set -x

# set the following variables:
# - (temporary) working folder (i.e. for downloading, etc). 
MY_WORKING_FOLDER="/scratch-shared/edwinhs/compiling_delft3d_for_danghan_roller/"
# - svn (deltares) delft3d user name 
SVN_USER_NAME="hsutanudjajacchms99"
# - (deltares) delft3d svn site
SVN_SRC_SITE="https://svn.oss.deltares.nl/repos/delft3d/tags/delft3d4/7545/"
# - folder where our own delft3d source version (e.g. from Marcio) is located
OWN_SRC_FOLDER="/home/edwinhs/Downloads/mk/src_roller/"
# - source code folder (relative to MY_WORKING_FOLDER), where our own delft3d source version will be integrated to the one from the (deltares) delft3d svn site  
SOURCE_FOLDER="delft3d_source/"
# - target folder where delft3d will be installed
TARGET_INST_FOLDER="/scratch-shared/edwinhs/delft3d_for_danghan_roller_compiled_on_20210511/"


# get the current directory
pwd
ORIGIN_FOLDER=$(pwd)


# set, make and print (temporary) working folder
mkdir -p ${MY_WORKING_FOLDER}
cd ${MY_WORKING_FOLDER}
pwd

#~ # - delete the content of temporary folder (only if you like) - THIS IS DANGEROUS
#~ rm -rf *


# obtain the delft3d from the Deltares site
svn --username ${SVN_USER_NAME} checkout ${SVN_SRC_SITE} ${SOURCE_FOLDER}

#~ # obtain the delft3d from the Deltares site (using export)
#~ svn --username ${SVN_USER_NAME} export ${SVN_SRC_SITE} ${SOURCE_FOLDER}


# add and replace with the ones from our own delft3d source version (e.g. from Marcio) 
cd ${OWN_SRC_FOLDER}
ls
ls ${MY_WORKING_FOLDER}/${SOURCE_FOLDER}/src/
rsync --recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress * ${MY_WORKING_FOLDER}/${SOURCE_FOLDER}/src/


# go to the main source code folder
cd ${MY_WORKING_FOLDER}/${SOURCE_FOLDER}/src/


# (try to) make sure that we have correct permissions to the source code files - PERHAPS THIS IS NOT NEEDED
chmod -R 755 .


# load all required modules
module purge
module load pre2019
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


# cleaning up previous installation/build files
chmod 755 clean.sh
./clean.sh


# prepare installation/build files
chmod 755 autogen.sh
./autogen.sh


# do we need this???
cd third_party_open/kdtree2
./autogen.sh
cd -


# configure
MPICXX=mpiicpc MPICC=mpiicc MPIFC=mpiifort MPIF77=mpiifort CC=mpiicc CXX=mpiicpc FC=mpiifort F77=mpiifort CFLAGS='-O3' CXXFLAGS='-O3' FFLAGS='-O3' FCFLAGS='-O3' ./configure --prefix=${TARGET_INST_FOLDER} --with-netcdf --with-mpi


# install
make ds-install


# go back to the original folder where this script is called
cd ${ORIGIN_FOLDER}


set +x
