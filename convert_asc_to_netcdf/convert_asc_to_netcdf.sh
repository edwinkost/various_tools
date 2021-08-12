
INP_FILE=$1
OUT_FILE=$2
DATETIME=$3

gdal_translate -of NETCDF ${INP_FILE} ${OUT_FILE}.tmp
cdo -L -f nc4 -setreftime, -setdate,${DATETIME} ${OUT_FILE}.tmp ${OUT_FILE} 
rm ${OUT_FILE}.tmp


