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
    --env-file public.env \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME.$DOCKER_HOST_DOMEN \
    --detach \
    --init \
    --restart unless-stopped \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $CONTAINER_NAME-data:/home/jenkins/agent \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET \
    -url http://jenkins.serverhome.home:65063/ \
    -workDir=/home/jenkins/agent \
    30d2e1f640cea859c67ebcbf71aa6ce6a4bacb48e5f5d189d6d879c55d0749c1 \
    jenkins-node-1

docker logs --follow $CONTAINER_NAME

#docker run --init jenkins/inbound-agent -url http://jenkins-server:port -workDir=/home/jenkins/agent <secret> <agent name>