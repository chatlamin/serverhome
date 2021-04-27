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
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart always \
    --network host \
    --volume $CONTAINER_NAME-conf:/etc/dnsmasq.d \
    --volume $CONTAINER_NAME-data:/etc/pihole \
    --env TZ=Europe/Moscow \
    --env IPv6=false \
    --env DNSMASQ_LISTENING=local \
    --env PIHOLE_DNS_=$PIHOLE_DNS \
    --env VIRTUAL_HOST="$CONTAINER_NAME.$DOCKER_HOST_DOMEN" \
    --env WEBPASSWORD=$WEBPASSWORD \
    --env QUERY_LOGGING=true \
    --env SKIPGRAVITYONBOOT=1 \
    --env WEB_PORT=65010 \
    --publish 65010:65010 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME