#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../settings/settings-common.sh

#---------------------------------------------------------------------
# End settings
#---------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker stop $CONTAINER_NAME
docker rm -f $CONTAINER_NAME
docker rmi $IMAGE_TARGET_OLD
docker rmi $IMAGE_SOURCE_OLD
./build.sh
./run.sh