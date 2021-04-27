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
    --log-driver=loki \
    --log-opt loki-url=$LOKI_URL \
    --log-opt loki-retries=5 \
    --log-opt loki-batch-size=400 \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart always \
    --cap-add sys_nice \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/mysql \
    --volume $CONTAINER_NAME-data:/var/lib/mysql \
    --env MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
    --publish 3306:3306 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME