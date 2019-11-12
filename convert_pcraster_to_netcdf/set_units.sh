
MAINFOLDER="/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/"

set -x

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/groundwater/aquifer_thickness_estimate/thickness_05min.nc
VARNAME="thickness_05min_map"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/groundwater/confining_layer_parameters/confining_layer_thickness_version_2016.nc
VARNAME="confining_layer_thickness_version_2016_map"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/groundwater/properties/groundwaterProperties5ArcMin.nc
VARNAME="specificYield"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
VARNAME="recessionCoeff"
ncatted -O -h -a units,${VARNAME},o,c,"day-1" ${NCFILE}
VARNAME="kSatAquifer"
ncatted -O -h -a units,${VARNAME},o,c,"m day-1" ${NCFILE}
ncdump -h ${NCFILE}
ncview ${NCFILE}


NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/irrNonPaddy/fractionNonPaddy.nc
VARNAME="fractionNonPaddy_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/irrPaddy/fractionPaddy.nc
VARNAME="fractionPaddy_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}


NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/coverFractionInputGrassland.nc
VARNAME="coverFractionInput"
ncatted -O -h -a units,${VARNAME},o,c,"m2 m-2" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/cropCoefficientGrassland.nc
VARNAME="kc"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/interceptCapInputGrassland.nc
VARNAME="interceptCapInput"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/rfrac1_short.nc
VARNAME="rfrac1_short_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/rfrac2_short.nc
VARNAME="rfrac2_short_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalShort/vegf_short.nc
VARNAME="vegf_short_map"
ncatted -O -h -a units,${VARNAME},o,c,"m2 m-2" ${NCFILE}
ncdump -h ${NCFILE}


NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/coverFractionInputForest.nc
VARNAME="coverFractionInput"
ncatted -O -h -a units,${VARNAME},o,c,"m2 m-2" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/cropCoefficientForest.nc
VARNAME="kc"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/interceptCapInputForest.nc
VARNAME="interceptCapInput"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/rfrac1_tall.nc
VARNAME="rfrac1_tall_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/rfrac2_tall.nc
VARNAME="rfrac2_tall_map"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/landCover/naturalTall/vegf_tall.nc
VARNAME="vegf_tall_map"
ncatted -O -h -a units,${VARNAME},o,c,"m2 m-2" ${NCFILE}
ncdump -h ${NCFILE}


NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/landSurface/soil/soilProperties5ArcMin.nc 
VARNAME="firstStorDepth"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="secondStorDepth"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="soilWaterStorageCap1"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="soilWaterStorageCap2"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="airEntryValue1"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="airEntryValue2"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
VARNAME="poreSizeBeta1"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
VARNAME="poreSizeBeta2"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
VARNAME="resVolWC1"
ncatted -O -h -a units,${VARNAME},o,c,"m3 m-3" ${NCFILE}
VARNAME="resVolWC2"
ncatted -O -h -a units,${VARNAME},o,c,"m3 m-3" ${NCFILE}
VARNAME="satVolWC1"
ncatted -O -h -a units,${VARNAME},o,c,"m3 m-3" ${NCFILE}
VARNAME="satVolWC2"
ncatted -O -h -a units,${VARNAME},o,c,"m3 m-3" ${NCFILE}
VARNAME="KSat1"
ncatted -O -h -a units,${VARNAME},o,c,"m day-1" ${NCFILE}
VARNAME="KSat2"
ncatted -O -h -a units,${VARNAME},o,c,"m day-1" ${NCFILE}
VARNAME="percolationImp"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}
ncview ${NCFILE}


NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/gtopo05min.nc
VARNAME="gtopo05min_map"
ncatted -O -h -a units,${VARNAME},o,c,"m" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/precipitation_correl.nc
VARNAME="precipitation"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/precipitation_slope.nc
VARNAME="precipitation"
ncatted -O -h -a units,${VARNAME},o,c,"mm m-1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/temperature_correl.nc
VARNAME="temperature"
ncatted -O -h -a units,${VARNAME},o,c,"1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/temperature_slope.nc
VARNAME="temperature"
ncatted -O -h -a units,${VARNAME},o,c,"degrees Celcius m-1" ${NCFILE}
ncdump -h ${NCFILE}

NCFILE=${MAINFOLDER}/pcrglobwb2_input/global_05min/meteo/downscaling_from_30min/uniqueIds_30min.nc
VARNAME="uniqueIds_30min_map"
ncatted -O -h -a units,${VARNAME},o,c,"-" ${NCFILE}
ncdump -h ${NCFILE}


sutan101@gpu002.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/channel_properties$
sutan101@gpu002.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/channel_properties$
sutan101@gpu002.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/channel_properties$ for fl in *.nc; do echo $fl ; cdo showvar $fl; cdo showunit $fl ; done
bankfull_depth.nc
 bankfull_depth_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
bankfull_width.nc
 bankfull_width_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
channel_gradient.nc
 channel_gradient_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
channel_parameters_5_arcmin_october_2015.nc
 lddMap cellAreaMap gradient bankfull_width bankfull_depth dem_floodplain dem_riverbed
cdo showname: Processed 7 variables [0.01s 8520KB]
 pcraster_ldd m2 1 m m m m
cdo showunit: Processed 7 variables [0.01s 8520KB]
dzRel0000.nc
 dzRel0000_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0001.nc
 dzRel0001_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0005.nc
 dzRel0005_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0010.nc
 dzRel0010_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0020.nc
 dzRel0020_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0030.nc
 dzRel0030_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0040.nc
 dzRel0040_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0050.nc
 dzRel0050_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0060.nc
 dzRel0060_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0070.nc
 dzRel0070_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0080.nc
 dzRel0080_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0090.nc
 dzRel0090_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
dzRel0100.nc
 dzRel0100_map
cdo showname: Processed 1 variable [0.01s 7992KB]
 unknown
cdo showunit: Processed 1 variable [0.01s 7992KB]
sutan101@gpu002.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/channel_properties$ 




set +x

