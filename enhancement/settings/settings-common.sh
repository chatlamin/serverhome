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
# Домен хост-машины
export DOCKER_HOST_DOMEN=serverhome.home
# Имя хост-машины
export HOST_NAME_HOST=$(hostname)
# Путь в точкам монтирования томов докер-контейнеров на хост машине
CONTAINERS_VOLUMES=/var/lib/docker/volumes
# Путь к Loki для отправки логов
LOKI_URL=http://loki.$DOCKER_HOST_DOMEN:3100/loki/api/v1/push

## Настройки проверки здоровья контейнера
HEALTHCHECK_SETTINGS="
    --health-timeout 30s \
    --health-retries 5 \
    --health-interval 1m \
    --health-start-period 1m \
    --health-cmd /healthcheck-container.sh \
    --label autoheal=true \
"

## Настройки для подключения к traefik
TRAEFIK_ENTRYPOINTS=web
TRAEFIK_RULE="Host(\`${CONTAINER_NAME}.${DOCKER_HOST_DOMEN}\`)"
TRAEFIK_SETTINGS="
    --label traefik.enable=true \
    --label traefik.http.routers.$CONTAINER_NAME.entrypoints=$TRAEFIK_ENTRYPOINTS \
    --label traefik.http.routers.$CONTAINER_NAME.rule=$TRAEFIK_RULE \
    --label traefik.http.services.$CONTAINER_NAME.loadbalancer.server.port=$LOCAL_PORT \
"

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------
