#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------
##------------------------------Notes------------------------------##
# для arm плагин находится тут
# https://github.com/grafana/loki/issues/1973#issuecomment-645084374
#     docker plugin install grafana/loki-docker-driver:arm-v7 --alias loki --grant-all-permissions
##-----------------------------------------------------------------##


# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://grafana.com/docs/loki/latest/clients/docker-driver/#installing
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions