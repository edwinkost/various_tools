# by Edwin H. Sutanudjaja on 2020-11-06

set -x

rsync -rv --copy-links --size-only --progress b381333@mistral.dkrz.de:/work/bb0820/ISIMIP/ISIMIP3b/InputData/climate/atmosphere/bias-adjusted/global/daily/ssp585/* ssp585

set +x

