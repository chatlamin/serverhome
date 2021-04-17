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

docker stop $CONTAINER_NAME
docker rm -f $CONTAINER_NAME
docker volume rm $CONTAINER_NAME-conf1
docker volume rm $CONTAINER_NAME-conf2
docker rmi $IMAGE_TARGET
docker rmi $IMAGE_SOURCE_NEW
docker rmi $IMAGE_SOURCE_OLD
./build.sh
./run.sh