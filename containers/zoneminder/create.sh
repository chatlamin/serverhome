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
    --env-file private.env \
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --restart unless-stopped \
    --shm-size="8G" \
    --volume $CONTAINER_NAME-data:/var/cache/zoneminder \
    --volume $CONTAINER_NAME-conf:/config \
    --publish 65203:80 \
    --publish 65204:9000 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET
