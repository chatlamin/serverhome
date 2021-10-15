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
    --volume $CONTAINER_NAME-data:/var/lib/postgresql/data \
    --volume $CONTAINER_NAME-conf:/etc/postgresql \
    --env POSTGRES_USER=$POSTGRES_USER \
    --env POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    --env POSTGRES_DB=$POSTGRES_DB\
    --publish 65019:5432 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME