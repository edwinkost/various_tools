#! /usr/bin/python

import os
import sys

user_name    = "edwinswt"
#~ user_name = sys.argv[1]

source_folder = "/oldscratch-shared/" + user_name + "/"
target_folder = "/scratch-shared/" + source_folder + "/"

# prepare target_folder
cmd = 'mkdir -p ' + target_folder
print(cmd); os.system(cmd)

# go to the source folder
msg = 'Move to the source folder : ' + source_folder
print(msg)
os.chdir(source_folder)
cmd = 'pwd'
print(cmd); os.system(cmd)

# rsync command
cmd = 'rsync --recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress * ' + target_folder
print(cmd); os.system(cmd)

# rsync command - for final checking
cmd = 'rsync --recursive --verbose --no-p --no-g --chmod=ugo=rwX --size-only --progress * ' + target_folder
print(cmd); os.system(cmd)
