#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../settings/settings-common.sh

#---------------------------------------------------------------------
# End settings
#---------------------------------------------------------------------

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
    --volume $CONTAINER_NAME-data:/opt/youtrack/data \
    --volume $CONTAINER_NAME-conf:/opt/youtrack/conf \
    --volume $CONTAINER_NAME-logs:/opt/youtrack/logs \
    --volume $CONTAINER_NAME-backups:/opt/youtrack/backups \
    --publish 65027:8080 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME