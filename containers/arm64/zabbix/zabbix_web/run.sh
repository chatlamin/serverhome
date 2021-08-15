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
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --env DB_SERVER_HOST=$DB_HOST \
    --env DB_SERVER_PORT=$DB_PORT \
    --env MYSQL_USER=$DB_USERNAME \
    --env MYSQL_PASSWORD=$DB_PASSWORD \
    --env MYSQL_DATABASE=$DB_DATABASE \
    --env PHP_TZ=Europe/Moscow \
    --env ZBX_SERVER_HOST=$ZBX_SERVER_HOST \
    --env ZBX_SERVER_PORT=$ZBX_SERVER_PORT \
    --publish 65014:8080 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME