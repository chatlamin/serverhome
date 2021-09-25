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
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-uploads:/app/uploads \
    --env ROOT_URL=$ROOT_URL \
    --env MONGO_URL=$MONGO_URL \
    --env MONGO_OPLOG_URL=$MONGO_OPLOG_URL \
    --env ADMIN_USERNAME=$ADMIN_USERNAME \
    --env ADMIN_PASS=$ADMIN_PASS \
    --env ADMIN_EMAIL=$ADMIN_EMAIL \
    --env PORT=$PORT \
    --publish 65055:3000 \
    --publish 65103:9458 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME