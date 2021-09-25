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

# https://dev.mysql.com/doc/refman/8.0/en/connecting.html
mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USERNAME --password=$DB_PASSWORD --skip-column-names -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;"
mysql \
    --host=$DB_HOST \
    --port=$DB_PORT \
    --user=$DB_USERNAME \
    --password=$DB_PASSWORD \
    --database=$DB_DATABASE < $BACKUP_PATH_FILE/$DB_DATABASE/$DB_DATABASE.sql