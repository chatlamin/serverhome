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

# https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
for DB in $(mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USERNAME --password=$DB_PASSWORD --skip-column-names -e 'show databases'); do
mkdir -p $BACKUP_DIR/$DB
mysqldump \
    --host=$DB_HOST \
    --port=$DB_PORT \
    --user=$DB_USERNAME \
    --password=$DB_PASSWORD \
    --allow-keywords \
    --events \
    --hex-blob \
    --result-file=$BACKUP_DIR/$DB/$DB.sql \
    --routines \
    --single-transaction \
    --triggers \
    --lock-tables \
    $DB;
done