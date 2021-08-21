#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/blob/main/grafana/init/initialize-database.sql
# создаем БД, пользователя и права
docker exec -i $DB_CONTAINER_NAME /usr/bin/mysql -u root --password=$MYSQL_ROOT_PASSWORD mremoteng < mysql_db_setup.sql
