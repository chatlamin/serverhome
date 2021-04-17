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

docker volume rm $CONTAINER_NAME-conf
docker volume rm $CONTAINER_NAME-data
