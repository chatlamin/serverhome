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
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/zabbix \
    --volume $CONTAINER_NAME-data:/var/lib/zabbix \
    --env DB_SERVER_HOST=$DB_HOST \
    --env DB_SERVER_PORT=$DB_PORT \
    --env MYSQL_USER=$DB_USERNAME \
    --env MYSQL_PASSWORD=$DB_PASSWORD \
    --env MYSQL_DATABASE=$DB_DATABASE \
    --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    --env ZBX_CACHESIZE=2048M \
    --env ZBX_IPMIPOLLERS=3 \
    --publish 65013:10051 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME