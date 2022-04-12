#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://docs.docker.com/compose/install/
apt-get update
apt-get -qq install -y python3 python3-pip
pip3 install docker-compose

docker-compose --version