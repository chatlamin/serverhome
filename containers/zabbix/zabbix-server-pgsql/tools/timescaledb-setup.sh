#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source ../settings-personal.sh
source ../../../settings/settings-common.sh
source ../public.env

# Пароль сервера баз данных
export PGPASSWORD='Iecahho1amoo1f'
# Переменная подключения к postgresql
readonly PSQL="psql --host=$DB_SERVER_HOST --port=$DB_SERVER_PORT --username=root"

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/tree/main/networks/netbox/init
# создаем БД, пользователя и права
# https://postgrespro.com/list/thread-id/1493424

docker exec -i $DB_CONTAINER_NAME psql --username=$POSTGRES_USER_ROOT --no-password zabbix <<< "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;"

run_timescaledb() {
  $PSQL --dbname=zabbix <<< "$(envsubst < timescaledb.sql)"
}

run_timescaledb