set -x

SOURCE="sutan101@rapid.geo.uu.nl:/nfsarchive/edwin-emergency-backup-DO-NOT-DELETE/*"

TARGET="/scratch/depfg/sutan101/files_from_speedy_rapid_etc_until_202004020/nfsarchive/edwin-emergency-backup-DO-NOT-DELETE/"
mkdir -p ${TARGET}

# the following options should also include copying real files and folders of symlinks
OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress --copy-links"

# the following options should make symlinks broken
#~ OPTIONS="--recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress"

# rsync command
rsync ${OPTIONS} ${SOURCE} ${TARGET}

# rsync command - for final checking
rsync ${OPTIONS} ${SOURCE} ${TARGET} 

# go back to the original folder (where this script is excecuted)
cd -

set +x
