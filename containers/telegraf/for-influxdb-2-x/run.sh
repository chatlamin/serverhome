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
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --network host \
    --privileged \
    --user telegraf:$(stat -c '%g' /var/run/docker.sock) \
    --restart unless-stopped \
    --volume $CONTAINER_NAME-conf:/etc/telegraf \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /:/host:ro \
    --env HOST_NAME_HOST=$HOST_NAME_HOST \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME