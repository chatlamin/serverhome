#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source ../settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/blob/main/gitea/init/initialize-gitea.sh
# https://docs.gitea.io/en-us/command-line/#admin

docker exec -ti $CONTAINER_NAME \
  gitea admin user create \
    --admin \
    --email admin@serverhome.home \
    --username admin_serverhome \
    --password aeyeaZa1uyeera \
    --config /etc/gitea/conf/app.ini

docker exec -ti $CONTAINER_NAME \
  gitea admin user create \
    --email user@serverhome.home \
    --username user_serverhome \
    --password ooW6eisuch8ohr \
    --config /etc/gitea/conf/app.ini

docker exec -ti $CONTAINER_NAME \
  gitea admin user create \
    --email backuper@serverhome.home \
    --username backuper \
    --password eeCheish5ooQu3 \
    --must-change-password=false \
    --config /etc/gitea/conf/app.ini