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

docker create \
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/config \
    --volume $CONTAINER_NAME-cache:/cache \
    --volume $CONTAINER_NAME-media:/media \
    --volume $CONTAINER_NAME-movies:/movies \
    --volume $CONTAINER_NAME-serials:/serials \
    --publish 65048:8096 \
    --publish 65049:8920 \
    --publish 7359:7359/udp \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET
