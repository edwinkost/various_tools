
INP_FILE=$1
OUT_FILE=$2

DATE=$3

gdal_translate -of NETCDF ${INP_FILE} ${OUT_FILE}.tmp
cdo -L -f nc4 -setreftime,1850-01-01,00:00:00 -settime,00:00:00 -setdate,${DATE} -invertlat ${OUT_FILE}.tmp ${OUT_FILE} 
rm ${OUT_FILE}.tmp


