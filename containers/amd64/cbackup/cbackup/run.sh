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
    --cap-drop SYS_ADMIN \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-apache2-conf:/etc/apache2 \
    --volume $CONTAINER_NAME-apache2-log:/var/log/apache2 \
    --volume $CONTAINER_NAME-data:/opt/cbackup \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --publish 80:80 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME