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
    --network host \
    --privileged \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-assets:/assets/custom \
    --volume $CONTAINER_NAME-data:/data \
    --volume $CONTAINER_NAME-log:/var/log \
    --volume $CONTAINER_NAME-www:/var/www/html \
    --volume $CONTAINER_NAME-mysql:/var/lib/mysql \
    --publish 80:80 \
    --publish 443:443 \
    --publish 4445:4445 \
    --publish 4569:4569 \
    --publish 5060:5060 \
    --publish 5060:5060/udp \
    --publish 5160:5160 \
    --publish 5160:5160/udp \
    --publish 8001:8001 \
    --publish 8003:8003 \
    --publish 8008:8008 \
    --publish 8009:8009 \
    --publish 8025:8025 \
    --publish 18000-18100:18000-18100/udp \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME