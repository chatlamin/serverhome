#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# ip / dns сервера баз данных
DB_HOST=mysql-8.serverhome.home
# Порт сервера баз данных
DB_PORT=3306
# Пользователь сервера баз данных
DB_USERNAME=root
# Пароль сервера баз данных
DB_PASSWORD=Dae2fiiChohng0
# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# http://stackoverflow.com/a/246128
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# Имя базы данных
DB=firefly_iii
# Каталог локальных дампов БД
LOCAL_DUMPS=/$HOME/backups/mysql/$DB
# Кол-во ядер
THREADS=2

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

mkdir -p $LOCAL_DUMPS
$BASEDIR/mydumper \
    --host $DB_HOST \
    --port $DB_PORT \
    --user $DB_USERNAME \
    --password $DB_PASSWORD \
    --database $DB \
    --build-empty-files \
    --compress \
    --logfile $LOCAL_DUMPS/backup.log \
    --verbose 3 \
    --outputdir $LOCAL_DUMPS \
    --threads $THREADS \
    --triggers \
    --events \
    --lock-all-tables \
    --routines