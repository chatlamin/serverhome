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
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf-1:/usr/share/logstash/config \
    --volume $CONTAINER_NAME-conf-2:/usr/share/logstash/pipeline \
    --publish 5514:5514 \
    --publish 5514:5514/udp \
    --publish 5044:5044 \
    --publish 9600:9600 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME