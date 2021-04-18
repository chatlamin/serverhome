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

docker run \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --volume $CONTAINER_NAME-conf:/etc/influxdb \
    --volume $CONTAINER_NAME-data:/var/lib/influxdb \
    --env TZ=Europe/Moscow \
    --publish 8086:8086 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME