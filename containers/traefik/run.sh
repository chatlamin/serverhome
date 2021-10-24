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
    --restart unless-stopped \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/traefik \
    --volume $CONTAINER_NAME-log:/var/log/traefik \
    --publish 65050:8080 \
    --publish 65051:80 \
    --publish 65052:443 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME