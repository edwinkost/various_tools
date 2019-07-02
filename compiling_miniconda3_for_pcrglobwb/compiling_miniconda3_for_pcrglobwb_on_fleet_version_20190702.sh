
# get and install miniconda, set the directory to /home/sutan101/opt/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# set the PATH
export PATH=/home/sutan101/opt/miniconda3/bin/:$PATH

# install modules needed
conda install numpy udunits2 proj4 zlib hdf4 hdf5 netcdf4 h5py gdal=2.3.0 basemap six

# load pcraster 4.2.1 (compatible with python 3)
PCRASTER=/opt/pcraster/pcraster-4.2.1
export PATH=$PCRASTER/bin:$PATH
export PYTHONPATH=$PCRASTER/python:$PYTHONPATH

