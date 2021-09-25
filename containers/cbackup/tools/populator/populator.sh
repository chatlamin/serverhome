#!/usr/bin/env bash

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

docker exec -i mysql-5-7 /usr/bin/mysql -u root --password=Dae2fiiChohng0 cbackup < init/test-data.sql