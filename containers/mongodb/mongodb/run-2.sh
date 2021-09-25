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
    --name $CONTAINER_NAME-2 \
    --hostname $CONTAINER_NAME-2.$DOCKER_HOST_DOMEN \
    --detach \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-2-data:/data/db \
    --volume $CONTAINER_NAME-2-configdb:/data/configdb \
    --publish 27018:27018 \
    $IMAGE_TARGET \
    mongod --replSet rs01 --port 27018

docker logs --follow $CONTAINER_NAME-2