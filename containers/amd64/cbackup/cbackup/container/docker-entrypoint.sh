#!/bin/bash

USER_PASSWORD=cbackup_password

if [ "$(ls /opt/cbackup)" ];
then
    echo "cbackup установлен"
else
    echo "Подготавливаем cbackup"
    rsync -axHAX /opt/cbackup.orig/ /opt/cbackup/
fi

echo "Изменение пароля пользователя cbackup"
echo "cbackup:$USER_PASSWORD" | chpasswd
echo "end"

exec "$@"