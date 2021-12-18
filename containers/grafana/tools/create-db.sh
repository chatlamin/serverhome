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
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "CREATE DATABASE $GF_DATABASE_NAME;"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "CREATE USER IF NOT EXISTS '$GF_DATABASE_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$GF_DATABASE_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "GRANT ALL ON $GF_DATABASE_NAME.* TO '$GF_DATABASE_USER'@'%';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "show databases;"