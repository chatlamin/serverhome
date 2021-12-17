#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source settings-personal.sh
source ../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://github.com/alexanderfefelov/docker-backpack/blob/main/dns/dnsmasq/build.sh
generate_config_files() {
  echo Generating config files...

  local -r IP_ADDRESS=$(ip route get 1.0.0.0 | awk '{ print $7 }')
  if [ -z $IP_ADDRESS ]; then
    echo Failed to detect IP address >&2
    exit 1
  fi
  export IP_ADDRESS
  envsubst \
    < build/template.custom.list \
    > container/etc/coredns/hosts

  echo ...config files generated
}

generate_config_files
export TAG_NEW
docker build \
    --build-arg OS \
    --build-arg ARCHITECTURE \
    --build-arg TAG_NEW \
    --tag $IMAGE_TARGET .

rm --force container/etc/coredns/hosts