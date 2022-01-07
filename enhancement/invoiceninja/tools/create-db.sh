#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source ../settings-personal.sh
source ../../settings/settings-common.sh
source ../public.env

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/blob/main/grafana/init/initialize-database.sql
# создаем БД, пользователя и права
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MARIADB_ROOT_PASSWORD <<< "CREATE DATABASE $DB_DATABASE;"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MARIADB_ROOT_PASSWORD <<< "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MARIADB_ROOT_PASSWORD <<< "GRANT ALL ON $DB_DATABASE.* TO '$DB_USERNAME'@'%';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MARIADB_ROOT_PASSWORD <<< "flush privileges;"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MARIADB_ROOT_PASSWORD <<< "show databases;"