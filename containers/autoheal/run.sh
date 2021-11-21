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
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env AUTOHEAL_CONTAINER_LABEL=autoheal \
    --env AUTOHEAL_INTERVAL=180 \
    --env AUTOHEAL_START_PERIOD=180 \
    --env AUTOHEAL_DEFAULT_STOP_TIMEOUT=30 \
    --env DOCKER_SOCK=/var/run/docker.sock \
    --env CURL_TIMEOUT=30 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME