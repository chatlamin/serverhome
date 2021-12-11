#!/usr/bin/env bash

./opt/bgbilling/BGInetAccounting/bin/update.sh 2>&1 | tee --append /opt/bgbilling/BGInetAccounting/log/updater.out

exec "$@"