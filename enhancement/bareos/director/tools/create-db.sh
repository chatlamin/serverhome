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

docker exec -i $DB_CONTAINER_NAME psql --username=$DB_ADMIN_USER --no-password postgres <<< "CREATE DATABASE $DB_NAME ENCODING 'SQL_ASCII' TEMPLATE=template0;"
docker exec -i $DB_CONTAINER_NAME psql --username=$DB_ADMIN_USER --no-password postgres <<< "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME psql --username=$DB_ADMIN_USER --no-password postgres <<< "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"
docker exec -i $DB_CONTAINER_NAME psql --username=$DB_ADMIN_USER --no-password postgres <<< "\l"