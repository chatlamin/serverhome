#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Текущее время
TIMESTAMP=$(date '+%d-%m-%Y_%H-%M-%S')
# Путь сохранения данных
BACKUP_DIR=/data1/backup/project
# Что сохраняем
TARGET=$HOME/github/serverhome
# Удалить копии старше COUNT дней
COUNT=7
# Минимальный размер бэкапа в килобайтах
SIZE_MIN=100
# healthchecks ping url
PING_URL=http://healthchecks.serverhome.home:8000/ping/9fbded76-430b-4274-8e65-a2b212eb3db3
# Путь для удаленной копии
REMOTE_DIR=/data1/remote/project

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Создаем папку
sudo mkdir -p $BACKUP_DIR/$TIMESTAMP

# Делаем бэкап в помощью утилиты tar
sudo tar -czpf $BACKUP_DIR/$TIMESTAMP/backup.tar.gz \
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