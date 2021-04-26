#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker build \
    --build-arg VERS \
    --build-arg IMAGE_BUILD \
    --build-arg IMAGE_BUILDER \
    --build-arg OS \
    --build-arg ARCHITECTURE \
    --tag $IMAGE_TARGET .