#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# Тип OS
export OS=linux
# Основная архитектура
export ARCHITECTURE=$(dpkg --print-architecture)
# Образ целевой старый
IMAGE_TARGET_OLD=chatlamin/$ARCHITECTURE-$NAME:$TAG_OLD
# Образ целевой новый
IMAGE_TARGET=chatlamin/$ARCHITECTURE-$NAME:$TAG_NEW
# Образ источника старый
IMAGE_SOURCE_OLD=$EXPLORE:$TAG_OLD
# Образ источника новый
export IMAGE_SOURCE_NEW=$EXPLORE:$TAG_NEW
# Имя контейнера
export CONTAINER_NAME=$NAME
# Домены хост-машины
export DOCKER_HOST_DOMEN=$(hostname | awk -F '.' '{print $2"."$3}')
# Имя хост-машины
export HOST_NAME_HOST=$(hostname)
# Путь в точкам монтирования томов докер-контейнеров на хост машине
CONTAINERS_VOLUMES=/var/lib/docker/volumes
# Путь к Loki для отправки логов
LOKI_URL=http://loki.$DOCKER_HOST_DOMEN:3100/loki/api/v1/push


#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------