
set -x

OUT_DIR="/scratch/depfg/sutan101/recession_coefficient_version_2021-02-XX/30sec/netcdf/"
mkdir -p ${OUT_DIR}
rm ${OUT_DIR}/*

INP_DIR="/scratch/depfg/sutan101/recession_coefficient_version_2021-02-XX/30sec/"

#~ sutan101@login01.cluster:/scratch/depfg/sutan101/recession_coefficient_version_2021-02-XX/30sec/netcdf$ ls -lah ../*.map
#~ -r--r--r-- 1 sutan101 depfg 3.5G Mar  1 13:00 ../recession_coefficient_30sec.map
#~ -r--r--r-- 1 sutan101 depfg 3.5G Mar  1 11:46 ../k_conductivity_aquifer_filled.map
#~ -r--r--r-- 1 sutan101 depfg 3.5G Mar  1 12:17 ../specific_yield_aquifer_filled.map

python pcraster_to_netcdf.py -inp ${INP_DIR}/recession_coefficient_30sec.map   -out ${OUT_DIR}/recession_coefficient_30sec.nc         -unt "day-1"
python pcraster_to_netcdf.py -inp ${INP_DIR}/k_conductivity_aquifer_filled.map -out ${OUT_DIR}/k_conductivity_aquifer_filled_30sec.nc -unt "m.day-1"
python pcraster_to_netcdf.py -inp ${INP_DIR}/specific_yield_aquifer_filled.map -out ${OUT_DIR}/specific_yield_aquifer_filled_30sec.nc -unt "m3.m-3"

cd ${OUT_DIR}
ncview *.nc

set +x
