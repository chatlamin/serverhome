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
    --env-file private.env \
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --add-host host.docker.internal:172.17.0.1 \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/traefik \
    --volume $CONTAINER_NAME-log:/var/log/traefik \
    --volume $CONTAINER_NAME-cert:/etc/cert \
    --publish 65050:8080 \
    --publish 65051:8081 \
    --publish 80:80 \
    --publish 443:443 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME