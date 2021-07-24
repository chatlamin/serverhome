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
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/grafana \
    --env GF_DATABASE_TYPE=$DB_CONNECTION \
    --env GF_DATABASE_HOST=$DB_HOST \
    --env GF_DATABASE_NAME=$DB_DATABASE \
    --env GF_DATABASE_USER=$DB_USERNAME \
    --env GF_DATABASE_PASSWORD=$DB_PASSWORD \
    --env GF_SECURITY_ADMIN_USER=$ADMIN_USER \
    --env GF_SECURITY_ADMIN_PASSWORD=$ADMIN_PASS \
    --env GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH=$DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH \
    --publish 3000:3000 \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME