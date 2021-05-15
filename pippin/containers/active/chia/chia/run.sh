#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../settings/settings-common.sh

# optional
source settings-secret.sh

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
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-ca:/etc/chia \
    --volume /data2/chia/plots-tmp:/plots-tmp \
    --volume /plots/plots:/plots \
    --env harvester="true" \
    --env keys="/etc/chia/keys/mnemonic.cfg" \
    --env farmer_ca_directory="/etc/chia/ca/" \
    --env farmer_address="$FARMER_ADDRESS" \
    --env farmer_port="$FARMER_PORT" \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME