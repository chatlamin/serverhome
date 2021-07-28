#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Путь к файлам qbittorrent
TORRENT_PATH=/var/lib/docker/volumes/qbittorrent-data/_data
# Путь к сериалам медиасервера
SERIALS_PATH=/var/lib/docker/volumes/plex-serials/_data

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Делаем перемещение
sudo mv -v $TORRENT_PATH/* $SERIALS_PATH/