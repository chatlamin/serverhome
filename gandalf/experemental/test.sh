#!/usr/bin/env bash

# Elevate privileges
#[ $UID -eq 0 ] || exec sudo --preserve-env=VERSION bash "$0" "$@"

DOCKER_HOST=$(hostname | awk -F '.' '{print $2"."$3}')

echo $DOCKER_HOST
