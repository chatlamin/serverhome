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

mkdir -p $BACKUP_DIR

# https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
mysqldump \
    --host=$DB_HOST \
    --port=$DB_PORT \
    --user=$DB_USERNAME \
    --password=$DB_PASSWORD \
    --allow-keywords \
    --column-statistics=0 \
    --events \
    --flush-logs \
    --hex-blob \
    --result-file=$BACKUP_DIR/$DB_DATABASE.sql \
    --routines \
    --single-transaction \
    --triggers \
    $DB_DATABASE