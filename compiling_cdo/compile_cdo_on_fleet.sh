# source http://www.studytrails.com/blog/install-climate-data-operator-cdo-with-netcdf-grib2-and-hdf5-support/

TARGET_FOLDER="/home/sutan101/opt/cdo/cdo-1.9.6/"
rm -rf ${TARGET_FOLDER}
mkdir -p ${TARGET_FOLDER}

# make and go to the source folder
SOURCE_FOLDER="/home/sutan101/tmp/cdo/"
rm -rf ${SOURCE_FOLDER}
mkdir -p ${SOURCE_FOLDER}
cd ${SOURCE_FOLDER}

# download and install zlib using ./configure –prefix =/opt/cdo-install ; ‘make’, ‘make check’ and ‘make install’
cd ${SOURCE_FOLDER}
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/zlib-1.2.8.tar.gz
tar -xvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=${TARGET_FOLDER}
make
make check
make install

# download and install HDF5 using ./configure –with-zlib=/opt/cdo-install –prefix=/opt/cdo-install CFLAGS=-fPIC ; ‘make’, ‘make check’ and ‘make install’
cd ${SOURCE_FOLDER}
#~ wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-1.8.13.tar.gz
#~ tar -xvf hdf5-1.8.13.tar.gz
#~ cd hdf5-1.8.13
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz

./configure --with-zlib=${TARGET_FOLDER} --prefix=${TARGET_FOLDER} CFLAGS=-fPIC 


