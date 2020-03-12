
set -x

# -year 2000, months 1 to 12
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ temp 2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ wind 2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ sp   2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ tp   2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ ssr  2000 2000 1 12 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ fa   2000 2000 1 12 0 0 28 -16 41 &

# -year 2001, month 1 only
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ temp 2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ wind 2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ sp   2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ tp   2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ ssr  2001 2001 1  1 0 0 28 -16 41 &
python ERA5LandDownload.py /scratch-shared/edwinhs/test_arise_meteo/hourly/ fa   2001 2001 1  1 0 0 28 -16 41 &

wait

set +x
