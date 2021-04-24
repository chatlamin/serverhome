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
    --restart always \
    --network host \
    --volume $CONTAINER_NAME-conf1:/etc/pihole \
    --volume $CONTAINER_NAME-conf2:/etc/dnsmasq.d \
    --env TZ=Europe/Moscow \
    --env IPv6=false \
    --env DNSMASQ_LISTENING=local \
    --env PIHOLE_DNS_=$PIHOLE_DNS \
    --env VIRTUAL_HOST="$CONTAINER_NAME.$DOCKER_HOST_DOMEN" \
    --env WEBPASSWORD=$WEBPASSWORD \
    --env QUERY_LOGGING=true \
    --env SKIPGRAVITYONBOOT=1 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME