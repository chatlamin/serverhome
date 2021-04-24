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

docker run \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --volume $CONTAINER_NAME-conf:/config \
    --volume $CONTAINER_NAME-movies:/movies \
    --volume $CONTAINER_NAME-serials:/serials \
    --volume $CONTAINER_NAME-transcode:/transcode \
    --env PLEX_CLAIM=$PLEX_CLAIM \
    --env TZ=Europe/Moscow \
    --publish 32400:32400 \
    --publish 1900:1900/udp \
    --publish 5353:5353/udp \
    --publish 8324:8324 \
    --publish 32410:32410/udp \
    --publish 32412:32412/udp \
    --publish 32413:32413/udp \
    --publish 32414:32414/udp \
    --publish 32469:32469 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME