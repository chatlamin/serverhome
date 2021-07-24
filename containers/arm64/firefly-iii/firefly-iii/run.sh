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
    --volume $CONTAINER_NAME-upload:/var/www/html/storage/upload \
    --env TZ=Europe/Moscow \
    --env DEFAULT_LANGUAGE=ru_RU \
    --env APP_KEY=$APP_KEY \
    --env DB_CONNECTION=$DB_CONNECTION \
    --env DB_HOST=$DB_HOST \
    --env DB_PORT=$DB_PORT \
    --env DB_DATABASE=$DB_DATABASE \
    --env DB_USERNAME=$DB_USERNAME \
    --env DB_PASSWORD=$DB_PASSWORD \
    --publish 65003:8080 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME