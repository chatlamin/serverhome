#!/usr/bin/env bash

# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# Каталог локальных дампов БД
LOCAL_BACKUP=/$HOME/backups/dir
# Что бэкапим
OBJECT_NAME=/var/lib/docker/volumes/jenkins-data

mkdir -p $LOCAL_BACKUP

# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

tar -cpzf $LOCAL_BACKUP/backup.tar.gz $OBJECT_NAME