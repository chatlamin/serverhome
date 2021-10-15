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
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/dkron \
    --volume $CONTAINER_NAME-log:/var/log/dkron \
    --volume $CONTAINER_NAME-data:/dkron.data \
    --publish 65005:8080 \
    $IMAGE_TARGET \
    agent \
    --server \
    --bootstrap-expect=1 \
    --ui=true \
    --node-name=$CONTAINER_NAME.$DOCKER_HOST_DOMEN

docker logs --follow $CONTAINER_NAME