#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/ba800d0fbd66a335fbdfdfc8fa5683ffb3a0411a/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker run \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --network host \
    --privileged \
    --restart unless-stopped \
    --volume $CONTAINER_NAME-conf:/etc/telegraf \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /:/host:ro \
    --env HOST_MOUNT_PREFIX=/host \
    --env HOST_ETC=/host/etc \
    --env HOST_PROC=/host/proc \
    --env HOST_SYS=/host/sys \
    --env HOST_VAR=/host/var \
    --env HOST_RUN=/host/run \
    --env HOST_NAME_HOST=$HOST_NAME_HOST \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME