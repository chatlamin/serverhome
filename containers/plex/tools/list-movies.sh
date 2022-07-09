#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

CONTAINER_NAME=plex

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker exec -ti $CONTAINER_NAME /usr/lib/plexmediaserver/Plex\ Media\ Scanner --list --section 1