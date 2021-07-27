#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Текущее время
TIMESTAMP=$(date '+%d-%m-%Y_%H-%M-%S')
# ip / dns базы данных
DB_HOST=mysql.serverhome.home
# Порт базы данных
DB_PORT=3306
# Пользователь базы данных
DB_USERNAME=root
# Пароль базы данных
DB_PASSWORD=Dae2fiiChohng0
# Имя базы данных
DB_DATABASE=firefly_iii
# Путь сохранения дампа
BACKUP_DIR=/data1/backups/local/mysql/$DB_DATABASE
# Удалить копии старше COUNT дней
COUNT=7
# Минимальный размер бэкапа в килобайтах
SIZE_MIN=100
# healthchecks ping url
PING_URL=http://healthchecks.serverhome.home:8000/ping/f8f93906-12bd-4ee4-a3b6-16f8b1690526
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
sudo find $BACKUP_DIR -mtime +$COUNT -delete

# Проверяем размер бэкапа. Если меньше полученного в SIZE_MIN - ошибка
CURRENT=$(du -s $BACKUP_DIR/$TIMESTAMP/tar | awk '{print $1}')
if
[ $CURRENT -gt $SIZE_MIN ];
then
echo "ВСЕ ХОРОШО: Размер записанного архива нормальный"
curl -m 10 --retry 5 $PING_URL
else
echo "ОШИБКА: Размер записанного архива менее $SIZE_MIN киллобайт"
exit 1
fi

# Удаляем все из папки для удаленной копии
sudo rm -dr $REMOTE_DIR/*

# Создаем папку для удаленной копии
sudo mkdir -p $REMOTE_DIR/$TIMESTAMP

# Делаем удаленную копию
sudo cp -a $BACKUP_DIR/$TIMESTAMP/. $REMOTE_DIR/$TIMESTAMP