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
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/zabbix \
    --volume $CONTAINER_NAME-data:/var/lib/zabbix \
    --volume $CONTAINER_NAME-export:/var/lib/zabbix/export \
    --volume $CONTAINER_NAME-snmptraps:/var/lib/zabbix/snmptraps \
    --volume $CONTAINER_NAME-snmp-conf:/etc/snmp \
    --volume $CONTAINER_NAME-externalscripts:/usr/lib/zabbix/externalscripts \
    --publish 31150:10051 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME