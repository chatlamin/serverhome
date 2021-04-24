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

echo $CONTAINERS_VOLUMES/"$PLEX_LOGS"

docker run \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --volume $CONTAINER_NAME-conf:/config \
    --volume $CONTAINERS_VOLUMES/"$PLEX_LOGS":/plex_logs \
    --env TZ=Europe/Moscow \
    --publish 65008:8181 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME