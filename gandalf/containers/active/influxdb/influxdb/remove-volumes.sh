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

#https://github.com/alexanderfefelov/docker-backpack/blob/main/utils/cleanup/prune-all.sh
read -p "WARNING: The data will be deleted. Press Y to continue: " -n 1 -r
echo
if [ "$REPLY" != "Y" ]; then
  exit
fi

docker volume rm $CONTAINER_NAME-conf
docker volume rm $CONTAINER_NAME-data
