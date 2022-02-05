#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Текущее время
TIMESTAMP=$(date '+%d-%m-%Y_%H-%M-%S')
# ip / dns базы данных
DB_HOST=mysql-8.serverhome.home
# Порт базы данных
DB_PORT=3306
# Пользователь базы данных
DB_USERNAME=root
# Пароль базы данных
DB_PASSWORD=Dae2fiiChohng0
# Имя базы данных
DB_DATABASE=home_assistant
# Путь сохранения дампа
BACKUP_DIR=/data1/backups/local/mysql/$DB_DATABASE
# Удалить копии старше COUNT дней
COUNT=7
# Минимальный размер бэкапа в килобайтах
SIZE_MIN=25
# Путь для удаленной копии
REMOTE_DIR=/data1/backups/remote/mysql/$DB_DATABASE

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Создаем папку
sudo mkdir -p $BACKUP_DIR/$TIMESTAMP/tar
sudo mkdir -p $BACKUP_DIR/$TIMESTAMP/dump

# Делаем бэкап https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
sudo mysqldump \
    --host=$DB_HOST \
    --port=$DB_PORT \
    --user=$DB_USERNAME \
    --password=$DB_PASSWORD \
    --allow-keywords \
    --events \
    --flush-logs \
    --hex-blob \
    --result-file=$BACKUP_DIR/$TIMESTAMP/dump/$DB_DATABASE.sql \
    --routines \
    --single-transaction \
    --triggers \
    $DB_DATABASE

# Делаем архив
sudo tar -cvzpf $BACKUP_DIR/$TIMESTAMP/tar/backup.tar.gz  --absolute-names \
    $BACKUP_DIR/$TIMESTAMP/dump

# Ротация бэкапов
sudo find $BACKUP_DIR -type f -mtime +$COUNT -exec rm -rf {} \;
sudo find $BACKUP_DIR -type d -mtime +$COUNT -exec rm -rf {} \;
sudo find $BACKUP_DIR -type d -empty -delete

# Проверяем размер бэкапа. Если меньше полученного в SIZE_MIN - ошибка
CURRENT=$(du -s $BACKUP_DIR/$TIMESTAMP/tar | awk '{print $1}')
if
[ $CURRENT -gt $SIZE_MIN ];
then
echo "ВСЕ ХОРОШО: Размер записанного архива нормальный"
else
echo "ОШИБКА: Размер записанного архива менее $SIZE_MIN киллобайт"
exit 1
fi

# Удаляем все из папки для удаленной копии
sudo rm --force --dir --recursive $REMOTE_DIR/*

# Создаем папку для удаленной копии
sudo mkdir -p $REMOTE_DIR/$TIMESTAMP

# Делаем удаленную копию
sudo cp -a $BACKUP_DIR/$TIMESTAMP/. $REMOTE_DIR/$TIMESTAMP