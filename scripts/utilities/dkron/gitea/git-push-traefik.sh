#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Имя пользователя бэкапа gitea
GITEA_LOGIN=backuper
# e-mail пользователя бэкапа gitea
GITEA_EMAIL=backuper@serverhome.home
# Адрес сервера gitea
GITEA_HOST=gitea.serverhome.home
# Порт ssh сервера gitea
GITEA_PORT=65023
# Название организации gitea (логика: одна организация - это bare-metal объединяющий компоненты)
GITEA_ORG=pippin.serverhome.home
# Путь для локального хранения репозиториев
REPO_PATH=$HOME/gitea
# Название репозитория
REPO_NAME=traefik

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

# Конфигурация пользователя backuper
git config --global user.email "$GITEA_EMAIL"
git config --global user.name "$GITEA_LOGIN"

# Создать каталог для хранения локальных копий репозитория
mkdir -p $REPO_PATH

# Сделать владельцем пользователя, который будет делать push репозитория
sudo chown -R $GITEA_LOGIN:$GITEA_LOGIN $REPO_PATH

# Склонировать репозиторий
# https://stackoverflow.com/a/56948182
cd $REPO_PATH \
 && GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git clone ssh://git@$GITEA_HOST:$GITEA_PORT/$GITEA_ORG/$REPO_NAME.git \
 && cd $REPO_PATH/$REPO_NAME \
 && git config core.sshCommand 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Удалить имеющиеся файлы в репозитории
rm -rf $REPO_PATH/$REPO_NAME/$REPO_NAME*

# Скопировать рабочие файлы прода в репозиторий
sudo cp -r /var/lib/docker/volumes/$REPO_NAME-conf $REPO_PATH/$REPO_NAME
sudo cp -r /var/lib/docker/volumes/$REPO_NAME-log $REPO_PATH/$REPO_NAME
sudo cp -r /var/lib/docker/volumes/$REPO_NAME-cert $REPO_PATH/$REPO_NAME

# Обновить владельца пользователя, который будет делать push репозитория
sudo chown -R $GITEA_LOGIN:$GITEA_LOGIN $REPO_PATH

# Фиксируем автоматические изменения
cd $REPO_PATH/$REPO_NAME \
 && git add --all . \
 && git commit -m "automatic push from $GITEA_LOGIN" \
 && git push