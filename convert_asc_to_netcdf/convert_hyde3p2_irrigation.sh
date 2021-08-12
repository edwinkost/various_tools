
set -x

#~ $ ls -lah /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/*2017*
#~ -rw-rw-rw- 1 sutan101 depfg  53M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/conv_rangeland2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  59M Sep  1  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/cropland2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  62M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/grazing2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_norice2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  54M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/pasture2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  54M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/rangeland2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  58M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/rf_norice2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/rf_rice2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  51M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/tot_irri2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  58M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/tot_rainfed2017AD.asc
#~ -rw-rw-rw- 1 sutan101 depfg  50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/tot_rice2017AD.asc
#~ -rw-r--r-- 1 sutan101 depfg 1.5K Aug 12 10:32 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/unzip_1800-2017.sh

#~ $ ls -lah /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice*
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1800AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1810AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1820AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1830AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1840AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1850AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1860AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1870AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1880AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1890AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1900AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1910AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1920AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1930AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1940AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1950AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1960AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1970AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1980AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice1990AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2000AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2001AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2002AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2003AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2004AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2005AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2006AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2007AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2008AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2009AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2010AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2011AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2012AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2013AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2014AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2015AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2016AD.asc
#~ -r--r--r-- 1 sutan101 depfg 50M Sep  7  2017 /scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/ir_rice2017AD.asc

INP_FOLDER="/scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/lu/"

OUT_FOLDER="/scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/netcdf_irr/"
mkdir -p ${OUT_FOLDER}


# irrigation rice (paddy)
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1800AD.asc ${OUT_FOLDER}/ir_rice1800AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1810AD.asc ${OUT_FOLDER}/ir_rice1810AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1820AD.asc ${OUT_FOLDER}/ir_rice1820AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1830AD.asc ${OUT_FOLDER}/ir_rice1830AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1840AD.asc ${OUT_FOLDER}/ir_rice1840AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1850AD.asc ${OUT_FOLDER}/ir_rice1850AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1860AD.asc ${OUT_FOLDER}/ir_rice1860AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1870AD.asc ${OUT_FOLDER}/ir_rice1870AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1880AD.asc ${OUT_FOLDER}/ir_rice1880AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1890AD.asc ${OUT_FOLDER}/ir_rice1890AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1900AD.asc ${OUT_FOLDER}/ir_rice1900AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1910AD.asc ${OUT_FOLDER}/ir_rice1910AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1920AD.asc ${OUT_FOLDER}/ir_rice1920AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1930AD.asc ${OUT_FOLDER}/ir_rice1930AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1940AD.asc ${OUT_FOLDER}/ir_rice1940AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1950AD.asc ${OUT_FOLDER}/ir_rice1950AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1960AD.asc ${OUT_FOLDER}/ir_rice1960AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1970AD.asc ${OUT_FOLDER}/ir_rice1970AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1980AD.asc ${OUT_FOLDER}/ir_rice1980AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1990AD.asc ${OUT_FOLDER}/ir_rice1990AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2000AD.asc ${OUT_FOLDER}/ir_rice2000AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2001AD.asc ${OUT_FOLDER}/ir_rice2001AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2002AD.asc ${OUT_FOLDER}/ir_rice2002AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2003AD.asc ${OUT_FOLDER}/ir_rice2003AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2004AD.asc ${OUT_FOLDER}/ir_rice2004AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2005AD.asc ${OUT_FOLDER}/ir_rice2005AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2006AD.asc ${OUT_FOLDER}/ir_rice2006AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2007AD.asc ${OUT_FOLDER}/ir_rice2007AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2008AD.asc ${OUT_FOLDER}/ir_rice2008AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2009AD.asc ${OUT_FOLDER}/ir_rice2009AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2010AD.asc ${OUT_FOLDER}/ir_rice2010AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2011AD.asc ${OUT_FOLDER}/ir_rice2011AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2012AD.asc ${OUT_FOLDER}/ir_rice2012AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2013AD.asc ${OUT_FOLDER}/ir_rice2013AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2014AD.asc ${OUT_FOLDER}/ir_rice2014AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2015AD.asc ${OUT_FOLDER}/ir_rice2015AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2016AD.asc ${OUT_FOLDER}/ir_rice2016AD.nc &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2017AD.asc ${OUT_FOLDER}/ir_rice2017AD.nc &

wait


set +x
