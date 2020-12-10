#!/usr/bin/env bash

set -x

INP_FOLDER="/scratch/depfg/sutan101/data/merit_dem/merit_dem_03sec/tiles_03sec/"

OUT_FOLDER="/scratch/depfg/sutan101/data/merit_dem/merit_dem_03sec/virtual_raster_03sec/"
mkdir -p ${OUT_FOLDER}
cd ${OUT_FOLDER}

gdalbuildvrt elevation_merit_dem_03sec.vrt ${INP_FOLDER}/dem_tif_n00e000/*tif ${INP_FOLDER}/dem_tif_n00e030/*tif ${INP_FOLDER}/dem_tif_n00e060/*tif ${INP_FOLDER}/dem_tif_n00e090/*tif ${INP_FOLDER}/dem_tif_n00e120/*tif ${INP_FOLDER}/dem_tif_n00e150/*tif ${INP_FOLDER}/dem_tif_n00w030/*tif ${INP_FOLDER}/dem_tif_n00w060/*tif ${INP_FOLDER}/dem_tif_n00w090/*tif ${INP_FOLDER}/dem_tif_n00w120/*tif ${INP_FOLDER}/dem_tif_n00w180/*tif ${INP_FOLDER}/dem_tif_n30e000/*tif ${INP_FOLDER}/dem_tif_n30e030/*tif ${INP_FOLDER}/dem_tif_n30e060/*tif ${INP_FOLDER}/dem_tif_n30e090/*tif ${INP_FOLDER}/dem_tif_n30e120/*tif ${INP_FOLDER}/dem_tif_n30e150/*tif ${INP_FOLDER}/dem_tif_n30w030/*tif ${INP_FOLDER}/dem_tif_n30w060/*tif ${INP_FOLDER}/dem_tif_n30w090/*tif ${INP_FOLDER}/dem_tif_n30w120/*tif ${INP_FOLDER}/dem_tif_n30w150/*tif ${INP_FOLDER}/dem_tif_n30w180/*tif ${INP_FOLDER}/dem_tif_n60e000/*tif ${INP_FOLDER}/dem_tif_n60e030/*tif ${INP_FOLDER}/dem_tif_n60e060/*tif ${INP_FOLDER}/dem_tif_n60e090/*tif ${INP_FOLDER}/dem_tif_n60e120/*tif ${INP_FOLDER}/dem_tif_n60e150/*tif ${INP_FOLDER}/dem_tif_n60w030/*tif ${INP_FOLDER}/dem_tif_n60w060/*tif ${INP_FOLDER}/dem_tif_n60w090/*tif ${INP_FOLDER}/dem_tif_n60w120/*tif ${INP_FOLDER}/dem_tif_n60w150/*tif ${INP_FOLDER}/dem_tif_n60w180/*tif ${INP_FOLDER}/dem_tif_s30e000/*tif ${INP_FOLDER}/dem_tif_s30e030/*tif ${INP_FOLDER}/dem_tif_s30e060/*tif ${INP_FOLDER}/dem_tif_s30e090/*tif ${INP_FOLDER}/dem_tif_s30e120/*tif ${INP_FOLDER}/dem_tif_s30e150/*tif ${INP_FOLDER}/dem_tif_s30w030/*tif ${INP_FOLDER}/dem_tif_s30w060/*tif ${INP_FOLDER}/dem_tif_s30w090/*tif ${INP_FOLDER}/dem_tif_s30w120/*tif ${INP_FOLDER}/dem_tif_s30w150/*tif ${INP_FOLDER}/dem_tif_s30w180/*tif ${INP_FOLDER}/dem_tif_s60e000/*tif ${INP_FOLDER}/dem_tif_s60e030/*tif ${INP_FOLDER}/dem_tif_s60e060/*tif ${INP_FOLDER}/dem_tif_s60e090/*tif ${INP_FOLDER}/dem_tif_s60e120/*tif ${INP_FOLDER}/dem_tif_s60e150/*tif ${INP_FOLDER}/dem_tif_s60w030/*tif ${INP_FOLDER}/dem_tif_s60w060/*tif ${INP_FOLDER}/dem_tif_s60w090/*tif ${INP_FOLDER}/dem_tif_s60w180/*tif

set +x
