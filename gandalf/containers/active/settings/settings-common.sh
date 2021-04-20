#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# Основная архитектура
ARCHITECTURE=$(dpkg --print-architecture)
# Образ итоговый
IMAGE_TARGET=chatlamin/$ARCHITECTURE-$NAME:latest
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

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------