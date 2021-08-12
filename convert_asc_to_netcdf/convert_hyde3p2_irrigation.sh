
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
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1800AD.asc ${OUT_FOLDER}/ir_rice1800AD.nc "1800-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1810AD.asc ${OUT_FOLDER}/ir_rice1810AD.nc "1810-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1820AD.asc ${OUT_FOLDER}/ir_rice1820AD.nc "1820-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1830AD.asc ${OUT_FOLDER}/ir_rice1830AD.nc "1830-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1840AD.asc ${OUT_FOLDER}/ir_rice1840AD.nc "1840-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1850AD.asc ${OUT_FOLDER}/ir_rice1850AD.nc "1850-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1860AD.asc ${OUT_FOLDER}/ir_rice1860AD.nc "1860-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1870AD.asc ${OUT_FOLDER}/ir_rice1870AD.nc "1870-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1880AD.asc ${OUT_FOLDER}/ir_rice1880AD.nc "1880-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1890AD.asc ${OUT_FOLDER}/ir_rice1890AD.nc "1890-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1900AD.asc ${OUT_FOLDER}/ir_rice1900AD.nc "1900-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1910AD.asc ${OUT_FOLDER}/ir_rice1910AD.nc "1910-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1920AD.asc ${OUT_FOLDER}/ir_rice1920AD.nc "1920-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1930AD.asc ${OUT_FOLDER}/ir_rice1930AD.nc "1930-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1940AD.asc ${OUT_FOLDER}/ir_rice1940AD.nc "1940-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1950AD.asc ${OUT_FOLDER}/ir_rice1950AD.nc "1950-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1960AD.asc ${OUT_FOLDER}/ir_rice1960AD.nc "1960-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1970AD.asc ${OUT_FOLDER}/ir_rice1970AD.nc "1970-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1980AD.asc ${OUT_FOLDER}/ir_rice1980AD.nc "1980-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice1990AD.asc ${OUT_FOLDER}/ir_rice1990AD.nc "1990-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2000AD.asc ${OUT_FOLDER}/ir_rice2000AD.nc "2000-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2001AD.asc ${OUT_FOLDER}/ir_rice2001AD.nc "2001-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2002AD.asc ${OUT_FOLDER}/ir_rice2002AD.nc "2002-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2003AD.asc ${OUT_FOLDER}/ir_rice2003AD.nc "2003-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2004AD.asc ${OUT_FOLDER}/ir_rice2004AD.nc "2004-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2005AD.asc ${OUT_FOLDER}/ir_rice2005AD.nc "2005-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2006AD.asc ${OUT_FOLDER}/ir_rice2006AD.nc "2006-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2007AD.asc ${OUT_FOLDER}/ir_rice2007AD.nc "2007-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2008AD.asc ${OUT_FOLDER}/ir_rice2008AD.nc "2008-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2009AD.asc ${OUT_FOLDER}/ir_rice2009AD.nc "2009-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2010AD.asc ${OUT_FOLDER}/ir_rice2010AD.nc "2010-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2011AD.asc ${OUT_FOLDER}/ir_rice2011AD.nc "2011-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2012AD.asc ${OUT_FOLDER}/ir_rice2012AD.nc "2012-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2013AD.asc ${OUT_FOLDER}/ir_rice2013AD.nc "2013-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2014AD.asc ${OUT_FOLDER}/ir_rice2014AD.nc "2014-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2015AD.asc ${OUT_FOLDER}/ir_rice2015AD.nc "2015-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2016AD.asc ${OUT_FOLDER}/ir_rice2016AD.nc "2016-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_rice2017AD.asc ${OUT_FOLDER}/ir_rice2017AD.nc "2017-01-01" &

wait

# irrigation norice (non-paddy)
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1800AD.asc ${OUT_FOLDER}/ir_norice1800AD.nc "1800-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1810AD.asc ${OUT_FOLDER}/ir_norice1810AD.nc "1810-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1820AD.asc ${OUT_FOLDER}/ir_norice1820AD.nc "1820-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1830AD.asc ${OUT_FOLDER}/ir_norice1830AD.nc "1830-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1840AD.asc ${OUT_FOLDER}/ir_norice1840AD.nc "1840-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1850AD.asc ${OUT_FOLDER}/ir_norice1850AD.nc "1850-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1860AD.asc ${OUT_FOLDER}/ir_norice1860AD.nc "1860-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1870AD.asc ${OUT_FOLDER}/ir_norice1870AD.nc "1870-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1880AD.asc ${OUT_FOLDER}/ir_norice1880AD.nc "1880-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1890AD.asc ${OUT_FOLDER}/ir_norice1890AD.nc "1890-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1900AD.asc ${OUT_FOLDER}/ir_norice1900AD.nc "1900-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1910AD.asc ${OUT_FOLDER}/ir_norice1910AD.nc "1910-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1920AD.asc ${OUT_FOLDER}/ir_norice1920AD.nc "1920-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1930AD.asc ${OUT_FOLDER}/ir_norice1930AD.nc "1930-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1940AD.asc ${OUT_FOLDER}/ir_norice1940AD.nc "1940-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1950AD.asc ${OUT_FOLDER}/ir_norice1950AD.nc "1950-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1960AD.asc ${OUT_FOLDER}/ir_norice1960AD.nc "1960-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1970AD.asc ${OUT_FOLDER}/ir_norice1970AD.nc "1970-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1980AD.asc ${OUT_FOLDER}/ir_norice1980AD.nc "1980-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice1990AD.asc ${OUT_FOLDER}/ir_norice1990AD.nc "1990-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2000AD.asc ${OUT_FOLDER}/ir_norice2000AD.nc "2000-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2001AD.asc ${OUT_FOLDER}/ir_norice2001AD.nc "2001-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2002AD.asc ${OUT_FOLDER}/ir_norice2002AD.nc "2002-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2003AD.asc ${OUT_FOLDER}/ir_norice2003AD.nc "2003-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2004AD.asc ${OUT_FOLDER}/ir_norice2004AD.nc "2004-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2005AD.asc ${OUT_FOLDER}/ir_norice2005AD.nc "2005-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2006AD.asc ${OUT_FOLDER}/ir_norice2006AD.nc "2006-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2007AD.asc ${OUT_FOLDER}/ir_norice2007AD.nc "2007-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2008AD.asc ${OUT_FOLDER}/ir_norice2008AD.nc "2008-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2009AD.asc ${OUT_FOLDER}/ir_norice2009AD.nc "2009-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2010AD.asc ${OUT_FOLDER}/ir_norice2010AD.nc "2010-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2011AD.asc ${OUT_FOLDER}/ir_norice2011AD.nc "2011-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2012AD.asc ${OUT_FOLDER}/ir_norice2012AD.nc "2012-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2013AD.asc ${OUT_FOLDER}/ir_norice2013AD.nc "2013-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2014AD.asc ${OUT_FOLDER}/ir_norice2014AD.nc "2014-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2015AD.asc ${OUT_FOLDER}/ir_norice2015AD.nc "2015-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2016AD.asc ${OUT_FOLDER}/ir_norice2016AD.nc "2016-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/ir_norice2017AD.asc ${OUT_FOLDER}/ir_norice2017AD.nc "2017-01-01" &

wait

# tot_irri (total irrigation), e.g. tot_irri2017AD.asc
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1800AD.asc ${OUT_FOLDER}/tot_irri1800AD.nc "1800-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1810AD.asc ${OUT_FOLDER}/tot_irri1810AD.nc "1810-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1820AD.asc ${OUT_FOLDER}/tot_irri1820AD.nc "1820-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1830AD.asc ${OUT_FOLDER}/tot_irri1830AD.nc "1830-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1840AD.asc ${OUT_FOLDER}/tot_irri1840AD.nc "1840-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1850AD.asc ${OUT_FOLDER}/tot_irri1850AD.nc "1850-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1860AD.asc ${OUT_FOLDER}/tot_irri1860AD.nc "1860-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1870AD.asc ${OUT_FOLDER}/tot_irri1870AD.nc "1870-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1880AD.asc ${OUT_FOLDER}/tot_irri1880AD.nc "1880-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1890AD.asc ${OUT_FOLDER}/tot_irri1890AD.nc "1890-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1900AD.asc ${OUT_FOLDER}/tot_irri1900AD.nc "1900-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1910AD.asc ${OUT_FOLDER}/tot_irri1910AD.nc "1910-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1920AD.asc ${OUT_FOLDER}/tot_irri1920AD.nc "1920-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1930AD.asc ${OUT_FOLDER}/tot_irri1930AD.nc "1930-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1940AD.asc ${OUT_FOLDER}/tot_irri1940AD.nc "1940-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1950AD.asc ${OUT_FOLDER}/tot_irri1950AD.nc "1950-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1960AD.asc ${OUT_FOLDER}/tot_irri1960AD.nc "1960-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1970AD.asc ${OUT_FOLDER}/tot_irri1970AD.nc "1970-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1980AD.asc ${OUT_FOLDER}/tot_irri1980AD.nc "1980-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri1990AD.asc ${OUT_FOLDER}/tot_irri1990AD.nc "1990-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2000AD.asc ${OUT_FOLDER}/tot_irri2000AD.nc "2000-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2001AD.asc ${OUT_FOLDER}/tot_irri2001AD.nc "2001-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2002AD.asc ${OUT_FOLDER}/tot_irri2002AD.nc "2002-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2003AD.asc ${OUT_FOLDER}/tot_irri2003AD.nc "2003-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2004AD.asc ${OUT_FOLDER}/tot_irri2004AD.nc "2004-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2005AD.asc ${OUT_FOLDER}/tot_irri2005AD.nc "2005-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2006AD.asc ${OUT_FOLDER}/tot_irri2006AD.nc "2006-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2007AD.asc ${OUT_FOLDER}/tot_irri2007AD.nc "2007-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2008AD.asc ${OUT_FOLDER}/tot_irri2008AD.nc "2008-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2009AD.asc ${OUT_FOLDER}/tot_irri2009AD.nc "2009-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2010AD.asc ${OUT_FOLDER}/tot_irri2010AD.nc "2010-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2011AD.asc ${OUT_FOLDER}/tot_irri2011AD.nc "2011-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2012AD.asc ${OUT_FOLDER}/tot_irri2012AD.nc "2012-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2013AD.asc ${OUT_FOLDER}/tot_irri2013AD.nc "2013-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2014AD.asc ${OUT_FOLDER}/tot_irri2014AD.nc "2014-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2015AD.asc ${OUT_FOLDER}/tot_irri2015AD.nc "2015-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2016AD.asc ${OUT_FOLDER}/tot_irri2016AD.nc "2016-01-01" &
bash convert_asc_to_netcdf.sh ${INP_FOLDER}/tot_irri2017AD.asc ${OUT_FOLDER}/tot_irri2017AD.nc "2017-01-01" &

wait


set +x
