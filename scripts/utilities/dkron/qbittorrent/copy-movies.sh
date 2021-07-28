#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Путь к файлам qbittorrent
TORRENT_PATH=/var/lib/docker/volumes/qbittorrent-data/_data
# Путь к фильмам медиасервера
MOVIES_PATH=/var/lib/docker/volumes/plex-movies/_data

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Делаем перемещение
sudo mv -v $TORRENT_PATH/* $MOVIES_PATH/