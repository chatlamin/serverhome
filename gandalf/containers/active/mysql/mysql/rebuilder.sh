#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Elevate privileges
[ $UID -eq 0 ] || exec sudo --preserve-env=VERSION bash "$0" "$@"

./remove-container.sh
./remove-volumes.sh
./remove-images.sh
./build.sh
./run.sh