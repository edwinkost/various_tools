set -x

SOURCE="sutan101@speedy.geo.uu.nl:/nfsarchive/recovery-swift/home/edwin/*"

TARGET="/scratch/depfg/sutan101/files_from_speedy_rapid_etc_until_202004020/recovery-swift/home_edwin/"
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
