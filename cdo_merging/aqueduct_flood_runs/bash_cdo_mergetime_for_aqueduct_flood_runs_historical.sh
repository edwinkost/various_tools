#! /usr/bin/bash

set -x

INP_DIR="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_flood/"

# ~ $ ls -lah /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_flood/
# ~ total 56K
# ~ drwxr-xr-x 7 edwinhs edwinhs 4.0K Dec 27 10:58 .
# ~ drwxr-xr-x 3 edwinhs edwinhs 4.0K Dec 28 16:59 ..
# ~ dr-xr-xr-x 4 edwinhs edwinhs 4.0K Dec 27 11:06 historical
# ~ dr-xr-xr-x 3 edwinhs edwinhs 4.0K Dec 27 10:58 rcp2p6
# ~ dr-xr-xr-x 3 edwinhs edwinhs 4.0K Dec 27 11:04 rcp4p5
# ~ dr-xr-xr-x 3 edwinhs edwinhs 4.0K Dec 27 11:02 rcp6p0
# ~ dr-xr-xr-x 3 edwinhs edwinhs 4.0K Dec 27 11:00 rcp8p5

# ~ $ ls -lah /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_flood/historical/1951-2005/
# ~ total 900K
# ~ dr-xr-xr-x 7 edwinhs edwinhs 4.0K Dec 27 11:06 .
# ~ dr-xr-xr-x 4 edwinhs edwinhs 4.0K Dec 27 11:06 ..
# ~ dr-xr-xr-x 2 edwinhs edwinhs 168K Dec 27 11:07 gfdl-esm2m
# ~ dr-xr-xr-x 2 edwinhs edwinhs 168K Dec 27 11:07 hadgem2-es
# ~ dr-xr-xr-x 2 edwinhs edwinhs 168K Dec 27 11:06 ipsl-cm5a-lr
# ~ dr-xr-xr-x 2 edwinhs edwinhs 172K Dec 27 11:06 miroc-esm-chem
# ~ dr-xr-xr-x 2 edwinhs edwinhs 168K Dec 27 11:06 noresm1-m

# ~ $ ls -lah /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_flood/rcp2p6/2006-2099/
# ~ total 1.6M
# ~ dr-xr-xr-x 7 edwinhs edwinhs 4.0K Dec 27 10:58 .
# ~ dr-xr-xr-x 3 edwinhs edwinhs 4.0K Dec 27 10:58 ..
# ~ dr-xr-xr-x 2 edwinhs edwinhs 300K Dec 27 10:59 gfdl-esm2m
# ~ dr-xr-xr-x 2 edwinhs edwinhs 300K Dec 27 11:00 hadgem2-es
# ~ dr-xr-xr-x 2 edwinhs edwinhs 300K Dec 27 10:59 ipsl-cm5a-lr
# ~ dr-xr-xr-x 2 edwinhs edwinhs 300K Dec 27 10:58 miroc-esm-chem
# ~ dr-xr-xr-x 2 edwinhs edwinhs 300K Dec 27 10:59 noresm1-m

OUT_DIR="/scratch-shared/edwinhs/pcrglobwb_aqueduct-flood_kinematic-wave/non-natural/"

# ~ edwinhs@tcn822.bullx:/scratch-shared/edwinsu/pcrglobwb_aqueduct-flood_kinematic-wave/natural$ ls -lah
# ~ total 176K
# ~ drwxr-xr-x 22 edwinsu edwinsu 4.0K Dec 28 15:49 .
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:44 ..
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 GFDL-ESM2M_hist_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 GFDL-ESM2M_rcp26_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 GFDL-ESM2M_rcp45_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 GFDL-ESM2M_rcp85_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 HadGEM2-ES_hist_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 HadGEM2-ES_rcp26_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 HadGEM2-ES_rcp45_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 HadGEM2-ES_rcp85_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 IPSL-CM5A-LR_hist_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 IPSL-CM5A-LR_rcp26_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 IPSL-CM5A-LR_rcp45_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 IPSL-CM5A-LR_rcp85_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 MIROC-ESM-CHEM_hist_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 MIROC-ESM-CHEM_rcp26_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 MIROC-ESM-CHEM_rcp45_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 MIROC-ESM-CHEM_rcp85_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 NorESM1-M_hist_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 NorESM1-M_rcp26_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 NorESM1-M_rcp45_naturalized
# ~ drwxr-xr-x  3 edwinsu edwinsu 4.0K Dec 28 15:49 NorESM1-M_rcp85_naturalized

# ~ example: python cdo_mergetime_aqueduct_flood.py /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_flood/historical/1951-2005/gfdl-esm2m/ /scratch-shared/edwinhs/test/ 1951-2005

python cdo_mergetime.py ${INP_DIR}/historical/1951-2005/gfdl-esm2m/     ${OUT_DIR}/GFDL-ESM2M_hist/merged_1951-2005/     1951-2005 &
python cdo_mergetime.py ${INP_DIR}/historical/1951-2005/hadgem2-es/     ${OUT_DIR}/HadGEM2-ES_hist/merged_1951-2005/     1951-2005 &
python cdo_mergetime.py ${INP_DIR}/historical/1951-2005/ipsl-cm5a-lr/   ${OUT_DIR}/IPSL-CM5A-LR_hist/merged_1951-2005/   1951-2005 &
python cdo_mergetime.py ${INP_DIR}/historical/1951-2005/miroc-esm-chem/ ${OUT_DIR}/MIROC-ESM-CHEM_hist/merged_1951-2005/ 1951-2005 &
python cdo_mergetime.py ${INP_DIR}/historical/1951-2005/noresm1-m       ${OUT_DIR}/NorESM1-M_hist/merged_1951-2005/      1951-2005 &

set +x




