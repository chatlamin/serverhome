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
    --volume $CONTAINER_NAME-conf:/wiki/config \
    --volume $CONTAINER_NAME-data:/wiki/data/content \
    --env DB_TYPE=$DB_CONNECTION \
    --env DB_HOST=$DB_HOST \
    --env DB_PORT=$DB_PORT \
    --env DB_NAME=$DB_DATABASE \
    --env DB_USER=$DB_USERNAME \
    --env DB_PASS=$DB_PASSWORD \
    --env CONFIG_FILE=/wiki/config/config.yml \
    --publish 65024:3000 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME