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
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/knot-resolver \
    --volume $CONTAINER_NAME-cache:/var/cache/knot-resolver \
    --publish 53:53 \
    --publish 53:53/udp \
    --publish 853:853 \
    --publish 8443:443 \
    --publish 65202:8453 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET
