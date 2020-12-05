# by Edwin H. Sutanudjaja on 2020-11-05

set -x

rsync -rv --copy-links --size-only --progress b381333@mistral.dkrz.de:/work/bb0820/ISIMIP/ISIMIP3a/InputData/climate/atmosphere/obsclim/GSWP3-W5E* .

set +x

