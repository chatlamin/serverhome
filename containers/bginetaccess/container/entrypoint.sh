#!/usr/bin/env bash

./opt/bgbilling/BGInetAccess/bin/update.sh 2>&1 | tee --append /opt/bgbilling/BGInetAccess/log/updater.out

exec "$@"