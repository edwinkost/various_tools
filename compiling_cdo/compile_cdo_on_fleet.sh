# source http://www.studytrails.com/blog/install-climate-data-operator-cdo-with-netcdf-grib2-and-hdf5-support/

SOURCE_FOLDER="/home/sutan101/tmp/cdo/"

TARGET_FOLDER="/home/sutan101/opt/cdo/cdo-1.9.6/"

# make and go to the source folder
rm -rf ${SOURCE_FOLDER}
mkdir -p ${SOURCE_FOLDER}
cd ${SOURCE_FOLDER}

# download and install zlib using ./configure –prefix =/opt/cdo-install ; ‘make’, ‘make check’ and ‘make install’
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-1.8.14.tar.bz2
tar -xvf ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-1.8.14.tar.bz2

#~ Install HDF5 using
#~ ./configure –with-zlib=/opt/cdo-install –prefix=/opt/cdo-install CFLAGS=-fPIC
#~ ‘make’, ‘make check’ and ‘make install’
