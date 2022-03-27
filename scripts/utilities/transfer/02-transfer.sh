#!/usr/bin/env bash

# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# Каталог локальных дампов БД
LOCAL_BACKUP=/$HOME/backups/dir
# Имя пользователя
USERNAME=login
# Адрес назначения
REMOTE_ADDRESS=192.168.88.5

scp $LOCAL_BACKUP/backup.tar.gz $USERNAME@$REMOTE_ADDRESS:$HOME