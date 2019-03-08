#!/bin/bash

set -x

SOURCE="/projects/0/dfguu/data/hydroworld/"
TARGET="eejit_hydrowld_via_speedy:/scratch/depfg/hydrowld/data/hydroworld/"

# go to the source folder
cd ${SOURCE}

# rsync command
rsync --recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress * ${TARGET}

# rsync command - for final checking
rsync --recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress * ${TARGET}

# go back to the original folder (where this script is excecuted)
cd -

set +x
