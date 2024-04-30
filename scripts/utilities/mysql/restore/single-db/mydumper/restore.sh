#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# ip / dns сервера баз данных
DB_HOST=mysql-8-master.serverhome.home
# Порт сервера баз данных
DB_PORT=65028
# Пользователь сервера баз данных
DB_USERNAME=root
# Пароль сервера баз данных
DB_PASSWORD=Dae2fiiChohng0
# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# http://stackoverflow.com/a/246128
BASEDIR="$(dirname -- "$BASH_SOURCE")"
# Имя базы данных
DB=firefly_iii
# Каталог локальных дампов БД
LOCAL_DUMPS=/$HOME/backups/mysql/$DB
# Кол-во ядер
THREADS=2

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

$BASEDIR/myloader \
    --host $DB_HOST \
    --port $DB_PORT \
    --user $DB_USERNAME \
    --password $DB_PASSWORD \
    --database $DB \
    --directory $LOCAL_DUMPS \
    --verbose 3 \
    --threads $THREADS \
    --enable-binlog 2>&1 | tee $LOCAL_DUMPS/restore.log
