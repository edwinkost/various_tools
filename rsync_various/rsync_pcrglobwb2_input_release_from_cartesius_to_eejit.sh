#!/bin/bash

set -x

# NOTE: It is recommended for NOT USING hydrowld account of cartesius. 

SOURCE="/projects/0/dfguu/data/hydroworld/pcrglobwb2_input_release/"

# - to hydrowld home
TARGET="eejit_hydrowld_via_speedy:/quanta1/home/hydrowld/data/hydroworld/pcrglobwb2_input_release/"

#~ # - to /scratch (disk is fast, but it is often failed)
#~ TARGET="eejit_hydrowld_via_speedy:/scratch/depfg/hydrowld/data/hydroworld/"


# the following options should also include copying real files and folders of symlinks
OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress --copy-links"

# the following options should make symlinks broken
#~ OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress"


# go to the source folder
cd ${SOURCE}

# rsync command
rsync ${OPTIONS} * ${TARGET}

# rsync command - for final checking
rsync ${OPTIONS} * ${TARGET} 

# go back to the original folder (where this script is excecuted)
cd -

set +x
