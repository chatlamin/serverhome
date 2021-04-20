#!/usr/bin/env bash

#https://github.com/alexanderfefelov/scripts/blob/ba800d0fbd66a335fbdfdfc8fa5683ffb3a0411a/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

docker rmi $IMAGE_TARGET
docker rmi $IMAGE_SOURCE_NEW
docker rmi $IMAGE_SOURCE_OLD
