#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../settings/settings-common.sh

# optional
source settings-secret.sh

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
    --volume $CONTAINER_NAME-upload:/var/www/html/storage/upload \
    --env TZ=Europe/Moscow \
    --env APP_KEY=$APP_KEY \
    --env DEFAULT_LANGUAGE=ru_RU \
    --env STATIC_CRON_TOKEN=$STATIC_CRON_TOKEN \
    --env DB_CONNECTION=$DB_CONNECTION \
    --env DB_HOST=$DB_HOST \
    --env DB_PORT=$DB_PORT \
    --env DB_DATABASE=$DB_DATABASE \
    --env DB_USERNAME=$DB_USERNAME \
    --env DB_PASSWORD=$DB_PASSWORD \
    --env ENABLE_MAIL_REPORT=true \
    --env MAIL_DESTINATION=$MAIL_DESTINATION \
    --env MAIL_MAILER=$MAIL_MAILER \
    --env MAIL_HOST=$MAIL_HOST \
    --env MAIL_PORT=$MAIL_PORT \
    --env MAIL_ENCRYPTION=$MAIL_ENCRYPTION \
    --env MAIL_USERNAME=$MAIL_USERNAME \
    --env MAIL_PASSWORD=$MAIL_PASSWORD \
    --env MAIL_FROM_ADDRESS=$MAIL_FROM_ADDRESS \
    --publish 65003:8080 \
    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET

docker logs --follow $CONTAINER_NAME