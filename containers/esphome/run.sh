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
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --privileged \
    --volume /dev/ttyUSB0:/dev/ttyUSB0 \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/config \
    --publish 65113:6052 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME