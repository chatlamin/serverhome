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

docker run \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart on-failure:10 \
    --volume $CONTAINER_NAME-conf:/config \
    --volume $CONTAINER_NAME-data:/downloads \
    --env TZ=Europe/Moscow \
    --env WEBUI_PORT=65004 \
    --publish 65004:65004 \
    --publish 6881:6881 \
    --publish 6881:6881/udp \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME