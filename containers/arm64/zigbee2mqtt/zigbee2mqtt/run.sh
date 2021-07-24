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
    --device $ZIGBEE_DONGLE:/dev/ttyACM0 \
    --volume $CONTAINER_NAME-data:/app/data \
    --env TZ=Europe/Moscow \
    --publish 65009:8080 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME