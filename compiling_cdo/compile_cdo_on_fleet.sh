# source http://www.studytrails.com/blog/install-climate-data-operator-cdo-with-netcdf-grib2-and-hdf5-support/

# activate g++
scl enable devtoolset-8 bash

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
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz
tar -xvf hdf5-1.10.5
cd hdf5-1.10.5
./configure --with-zlib=${TARGET_FOLDER} --prefix=${TARGET_FOLDER} CFLAGS=-fPIC 
make
make check
make install

# to enable dap, install libcurl from http://curl.haxx.se/download.html. install it from source using –prefix=/opt/cdo-install/
cd ${SOURCE_FOLDER}
wget https://curl.haxx.se/download/curl-7.65.0.tar.gz
tar -xvf curl-7.65.0.tar.gz
cd curl-7.65.0
./configure --prefix=${TARGET_FOLDER} 
make -j 6
make check -j 6
make install

# download and install NetCDF using: CPPFLAGS=-I/opt/cdo-install/include LDFLAGS=-L/opt/cdo-install/lib ./configure –prefix=/opt/cdo-install CFLAGS=-fPIC ; make ; make check ; make install
cd ${SOURCE_FOLDER}
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.0.tar.gz
tar -xvf netcdf-c-4.7.0.tar.gz
cd netcdf-c-4.7.0
CPPFLAGS=-I${TARGET_FOLDER}/include LDFLAGS=-L${TARGET_FOLDER}/lib ./configure --prefix=${TARGET_FOLDER} CFLAGS=-fPIC 
make -j 6
make check -j 6
make install

Install Jasper using
./configure –prefix=/opt/cdo-install  CFLAGS=-fPIC
‘make’, ‘make check’ and ‘make install’
Install grib using
./configure –prefix=/opt/cdo-install CFLAGS=-fPIC  –with-netcdf=/opt/cdo-install –with-jasper=/opt/cdo-install
‘make’, ‘make check’ and ‘make install’
Install cdo using
./configure –prefix=/opt/cdo-install CFLAGS=-fPIC  –with-netcdf=/opt/cdo-install –with-jasper=/opt/cdo-install –with-hdf5=/opt/cdo-install  –with-grib_api=/opt/cdo-install
‘make’, ‘make check’ and ‘make install’
