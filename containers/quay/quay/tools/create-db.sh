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
# создаем БД, пользователя и права, расширение
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password postgres <<< "CREATE DATABASE $DB_DATABASE;"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password postgres <<< "CREATE USER $DB_USERNAME WITH PASSWORD '$DB_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password postgres <<< "GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USERNAME;"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password $DB_DATABASE <<< "CREATE EXTENSION pg_trgm;"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password $DB_DATABASE <<< "\dx"
docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRESQL_USER --no-password postgres <<< "\l"