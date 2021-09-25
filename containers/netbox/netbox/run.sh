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
    --volume $CONTAINER_NAME-conf:/etc/netbox \
    --volume $CONTAINER_NAME-data:/opt/netbox/netbox/media \
    --env DB_HOST=$DB_HOST \
    --env DB_PORT=$DB_PORT \
    --env DB_NAME=$DB_DATABASE \
    --env DB_PASSWORD=$DB_PASSWORD \
    --env DB_USER=$DB_USERNAME \
    --env SUPERUSER_API_TOKEN=$SUPERUSER_API_TOKEN \
    --env SUPERUSER_EMAIL=$SUPERUSER_EMAIL \
    --env SUPERUSER_NAME=$SUPERUSER_NAME \
    --env SUPERUSER_PASSWORD=$SUPERUSER_PASSWORD \
    --env SECRET_KEY=$SECRET_KEY \
    --publish 65021:8080 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME