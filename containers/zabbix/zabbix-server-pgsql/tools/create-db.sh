#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source ../settings-personal.sh
source ../../../settings/settings-common.sh
source ../public.env

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/tree/main/networks/netbox/init
# создаем БД, пользователя и права
# https://postgrespro.com/list/thread-id/1493424

docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRES_USER_ROOT --no-password postgres <<< "CREATE DATABASE $POSTGRES_DB;"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRES_USER_ROOT --no-password postgres <<< "CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRES_USER_ROOT --no-password postgres <<< "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRES_USER_ROOT --no-password postgres <<< "\l"
