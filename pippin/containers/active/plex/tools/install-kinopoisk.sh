#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

CONTAINER_NAME=plex
PLEX_CONF_PATH=/data1/plex-conf/_data

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

cd $PLEX_CONF_PATH/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
git clone https://github.com/amirotin/Kinopoisk.bundle.git
chown -R 911:911 Kinopoisk.bundle/
docker restart $CONTAINER_NAME
docker logs -f $CONTAINER_NAME