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
DB_DATABASE=healthchecks
# Путь сохранения дампа
BACKUP_DIR=/data2/backup/mysql/$DB_DATABASE
# Удалить копии старше COUNT дней
COUNT=7
# Минимальный размер бэкапа в килобайтах
SIZE_MIN=100
# healthchecks ping url
PING_URL=http://healthchecks.serverhome.home:8000/ping/b0a3b296-ec97-4336-be05-4f8511a63fd3
# Путь для удаленной копии
REMOTE_DIR=/data2/duplicati-backups/_data/mysql/healthchecks

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Создаем папку
sudo mkdir -p $BACKUP_DIR/$TIMESTAMP/tar

# Делаем бэкап https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
sudo mysqldump \
    --host=$DB_HOST \
    --port=$DB_PORT \
    --user=$DB_USERNAME \
    --password=$DB_PASSWORD \
    --allow-keywords \
    --column-statistics=0 \
    --events \
    --flush-logs \
    --hex-blob \
    --result-file=$BACKUP_DIR/$TIMESTAMP/$DB_DATABASE.sql \
    --routines \
    --single-transaction \
    --triggers \
    $DB_DATABASE

# Делаем архив
sudo tar -cvzpf $BACKUP_DIR/$TIMESTAMP/tar/backup.tar.gz  --absolute-names \
    $BACKUP_DIR/$TIMESTAMP
    # Если нужно что то исключить из бэкапа
    # --exclude=/path-to

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