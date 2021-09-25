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
    --hostname $HOST_NAME_HOST \
    --detach \
    --restart unless-stopped \
    --user root \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-data:/usr/share/filebeat \
    --volume /var/lib/docker/containers:/var/lib/docker/containers:ro \
    --volume /var/log:/log/system:ro \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME