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
    --volume $CONTAINER_NAME-conf:/var/www/html \
    --volume $CONTAINER_NAME-data:/var/lib/snipeit \
    --env APP_ENV=production \
    --env APP_DEBUG=false \
    --env APP_TIMEZONE=Europe/Moscow \
    --env APP_LOCALE=ru \
    --env APP_KEY=base64:rHyqHJacXfS7NlP0wSzxwSL2ZGZkukK3roX2597oYGs= \
    --env APP_URL=http://snipe-it.serverhome.home:65040 \
    --env MYSQL_PORT_3306_TCP_ADDR=$DB_HOST \
    --env MYSQL_PORT_3306_TCP_PORT=$DB_PORT \
    --env MYSQL_DATABASE=$DB_DATABASE \
    --env MYSQL_USER=$DB_USERNAME \
    --env MYSQL_PASSWORD=$DB_PASSWORD \
    --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    --publish 65040:80 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME