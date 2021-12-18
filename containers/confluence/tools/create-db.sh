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
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "CREATE DATABASE $DATABASE_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "CREATE USER IF NOT EXISTS '$ATL_JDBC_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$ATL_JDBC_PASSWORD';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "GRANT ALL ON $DATABASE_NAME.* TO '$ATL_JDBC_USER'@'%';"
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD <<< "show databases;"