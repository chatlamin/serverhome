#!/usr/bin/env bash

# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# Каталог локальных дампов БД
LOCAL_BACKUP=/$HOME/backups/dir

mkdir -p $LOCAL_BACKUP

# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

tar --same-owner -xvf $HOME/backup.tar.gz -C $LOCAL_BACKUP