#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker build \
    --build-arg IMAGE_BUILDER \
    --build-arg BGBILLING_DOWNLOAD_URL \
    --build-arg BGBILLING_DOWNLOAD_FILE \
    --tag $IMAGE_TARGET .