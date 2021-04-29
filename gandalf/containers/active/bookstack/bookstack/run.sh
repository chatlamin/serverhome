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
    --log-opt no-file=false \
    --log-opt keep-file=true \
    --log-opt max-size=5m \
    --log-opt max-file=3 \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/config \
    --env APP_URL=$APP_URL \
    --env DB_HOST=$DB_HOST \
    --env DB_PORT=$DB_PORT \
    --env DB_USER=$DB_USERNAME \
    --env DB_PASS=$DB_PASSWORD \
    --env DB_DATABASE=$DB_DATABASE \
    --publish 65001:80 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME
