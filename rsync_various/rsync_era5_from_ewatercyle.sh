#!/bin/bash

set -x

# source folder
SOURCE="edwinhs@int2-bb.cartesius.surfsara.nl:/projects/0/wtrcycle/ERA5/"

# target folder
TARGET="/scratch/depfg/sutan101/data/era5/from_ewatercyle_copied_on_20191018/ERA5/"

#~ # - to /scratch (disk is fast, but it is often failed)
#~ TARGET="eejit_hydrowld_via_speedy:/scratch/depfg/hydrowld/data/hydroworld/"


# the following options should make symlinks broken
# - NOTE: All links should be skipped and updated mannually.
OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress"


#~ # the following options should also include copying real files and folders of symlinks
#~ # - NOTE: All links should be skipped and updated mannually.
#~ OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress --copy-links"


# rsync command
rsync ${OPTIONS} ${SOURCE}/* ${TARGET}

# rsync command - for final checking
rsync ${OPTIONS} ${SOURCE}/* ${TARGET}

set +x
