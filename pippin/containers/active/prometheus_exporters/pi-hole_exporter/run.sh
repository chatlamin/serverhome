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
    --log-opt loki-retries=10 \
    --log-opt loki-batch-size=102400 \
    --log-opt no-file=false \
    --log-opt keep-file=true \
    --log-opt max-size=5m \
    --log-opt max-file=3 \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --restart unless-stopped \
    --env PIHOLE_HOSTNAME=$PIHOLE_HOST \
    --env PIHOLE_PASSWORD=$PIHOLE_PASSWORD \
    --env PIHOLE_PORT=$PIHOLE_PORT \
    --env INTERVAL=30s \
    --env PORT=65100 \
    --publish 65100:65100 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME