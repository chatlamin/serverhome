#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../../../settings/settings-common.sh

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
    --restart always \
    --cap-add sys_nice \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-conf:/etc/mysql \
    --volume $CONTAINER_NAME-data:/var/lib/mysql \
    --publish 65030:3306 \
    $IMAGE_TARGET

docker run --rm --link $CONTAINER_NAME:$CONTAINER_NAME martin/wait -p 3306 -t 600
docker exec $CONTAINER_NAME cp /read-only.cnf /etc/mysql/conf.d/
docker restart $CONTAINER_NAME
docker logs --follow $CONTAINER_NAME