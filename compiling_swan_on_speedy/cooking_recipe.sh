

  575  export PATH="/home/price102/local/ncdf4_3/bin/:$PATH"
  576  export LD_LIBRARY_PATH="/home/price102/local/ncdf4_3/lib:$LD_LIBRARY_PATH"
  577  nf-config --all
  578  export FC=gfortran
  579  nf-config --all
  580  perl switch.pl -unix -netcdf
  581  make config
  582  FLAGS_SER=-I/home/price102/local/ncdf4_3/include/ NETCDFROOT=/home/price102/local/ncdf4_3/ LIBS_SER='-L/home/price102/local/ncdf4_3/lib -lnetcdff  -lnetcdf -lnetcdf' make ser
