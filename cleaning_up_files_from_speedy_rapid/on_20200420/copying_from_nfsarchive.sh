set -x

SOURCE="/nfsarchive/edwin-emergency-backup-DO-NOT-DELETE/"

TARGET="sutan101@eejit.geo.uu.nl:/scratch/depfg/sutan101/files_from_speedy_rapid_etc_until_202004020/nfsarchive/edwin-emergency-backup-DO-NOT-DELETE/"

# the following options should also include copying real files and folders of symlinks
OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress --copy-links"

# the following options should make symlinks broken
#~ OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress"

# go to the SOURCE FOLDER
cd ${SOURCE}

# rsync command
rsync ${OPTIONS} * ${TARGET}

# rsync command - for final checking
rsync ${OPTIONS} * ${TARGET} 

# go back to the original folder (where this script is excecuted)
cd -

set +x
