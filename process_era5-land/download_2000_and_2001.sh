
set -x

# Wind

# -year 2000, months 1 to 12
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Temp 2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Wind 2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Sp   2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Tp   2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Ssr  2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Fa   2000 2000 1 12 0 0 28 -16 41 &

# -year 2001, month 1 only
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Temp 2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Wind 2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Sp   2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Tp   2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Ssr  2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ Fa   2001 2001 1  1 0 0 28 -16 41 &

wait

set +x
