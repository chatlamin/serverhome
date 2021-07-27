#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Текущее время
TIMESTAMP=$(date '+%d-%m-%Y_%H-%M-%S')
# Путь сохранения данных
BACKUP_DIR=/data1/backups/local/docker-volumes
# Что сохраняем
TARGET=/var/lib/docker/volumes
# Что исключаем
EXCLUDE_1="/var/lib/docker/volumes/plex-conf/_data/Library/Application Support/Plex Media Server/Cache"
EXCLUDE_2="/var/lib/docker/volumes/plex-movies"
EXCLUDE_3="/var/lib/docker/volumes/plex-serials"
EXCLUDE_4="/var/lib/docker/volumes/plex-transcode"
EXCLUDE_5="/var/lib/docker/volumes/duplicati-backups"
EXCLUDE_6="/var/lib/docker/volumes/influxdb-data"
EXCLUDE_7="/var/lib/docker/volumes/loki-data"
EXCLUDE_8="/var/lib/docker/volumes/mosquitto-data"
EXCLUDE_9="/var/lib/docker/volumes/mysql-data"
EXCLUDE_10="/var/lib/docker/volumes/pi-hole-data"
EXCLUDE_11="/var/lib/docker/volumes/prometheus-data"
EXCLUDE_12="/var/lib/docker/volumes/qbittorrent-data"
EXCLUDE_13="/var/lib/docker/volumes/firefly-iii-upload"
EXCLUDE_14="/var/lib/docker/volumes/dkron-data"
EXCLUDE_15="/var/lib/docker/volumes/dkron-log"
# Удалить копии старше COUNT дней
COUNT=7
# Минимальный размер бэкапа в килобайтах
SIZE_MIN=100
# healthchecks ping url
PING_URL=http://healthchecks.serverhome.home:8000/ping/f427dbc6-5203-478b-904b-beac4b554c95
# Путь для удаленной копии
REMOTE_DIR=/data1/backups/remote/docker-volumes

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Создаем папку
sudo mkdir -p $BACKUP_DIR/$TIMESTAMP

# Делаем бэкап в помощью утилиты tar
sudo tar -czpf $BACKUP_DIR/$TIMESTAMP/backup.tar.gz \
    --exclude "$EXCLUDE_1" \
    --exclude "$EXCLUDE_2" \
    --exclude "$EXCLUDE_3" \
    --exclude "$EXCLUDE_4" \
    --exclude "$EXCLUDE_5" \
    --exclude "$EXCLUDE_6" \
    --exclude "$EXCLUDE_7" \
    --exclude "$EXCLUDE_8" \
    --exclude "$EXCLUDE_9" \
    --exclude "$EXCLUDE_10" \
    --exclude "$EXCLUDE_11" \
    --exclude "$EXCLUDE_12" \
    --exclude "$EXCLUDE_13" \
    --exclude "$EXCLUDE_14" \
    --exclude "$EXCLUDE_15" \
    --absolute-names $TARGET

# Ротация бэкапов
sudo find $BACKUP_DIR -mtime +$COUNT -delete

# Проверяем размер бэкапа. Если меньше полученного в SIZE_MIN - ошибка
CURRENT=$(du -s $BACKUP_DIR/$TIMESTAMP | awk '{print $1}')
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