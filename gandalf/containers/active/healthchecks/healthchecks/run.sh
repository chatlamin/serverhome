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
    --volume $CONTAINER_NAME-conf:/config \
    --env SITE_ROOT=http://$CONTAINER_NAME.$DOCKERHOST \
    --env SITE_NAME=$CONTAINER_NAME \
    --env ALLOWED_HOSTS="*" \
    --env SUPERUSER_EMAIL=$SUPERUSER_EMAIL \
    --env SUPERUSER_PASSWORD=$SUPERUSER_PASSWORD \
    --env REGISTRATION_OPEN=False \
    --env SECRET_KEY=$SECRET_KEY \
    --env DB=$DB_CONNECTION \
    --env DB_HOST=$DB_HOST \
    --env DB_NAME=$DB_DATABASE \
    --env DB_USER=$DB_USERNAME \
    --env DB_PASSWORD=$DB_PASSWORD \
    --publish 8000:8000 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME