#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# http://stackoverflow.com/a/246128
HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $HOME/settings.sh
# Yandex.Disk токен (как получить - https://neblog.info/skript-bekapa-na-yandeks-disk)
# TOKEN='your_token'
source $HOME/settings-secret.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# original https://neblog.info/skript-bekapa-na-yandeks-disk

function logger()
{
    echo "["`date "+%Y-%m-%d %H:%M:%S"`"] File $BACKUP_DIR: $1" >> $BACKUP_DIR/$LOGFILE
}

function parseJson()
{
    local output
    regex="(\"$1\":[\"]?)([^\",\}]+)([\"]?)"
    [[ $2 =~ $regex ]] && output=${BASH_REMATCH[2]}
    echo $output
}

function checkError()
{
    echo $(parseJson 'error' "$1")
}

function getUploadUrl()
{
    json_out=`curl -s -H "Authorization: OAuth $TOKEN" https://cloud-api.yandex.net:443/v1/disk/resources/upload/?path=app:/$FILENAME&overwrite=true`
    json_error=$(checkError "$json_out")
    if [[ $json_error != '' ]];
    then
        logger "$PROJECT - Yandex.Disk error: $json_error"
    echo ''
    else
        output=$(parseJson 'href' $json_out)
        echo $output
    fi
}

function uploadFile
{
    local json_out
    local uploadUrl
    local json_error
    uploadUrl=$(getUploadUrl)
    if [[ $uploadUrl != '' ]];
    then
    echo $UploadUrl
        json_out=`curl -s -T $1 -H "Authorization: OAuth $TOKEN" $uploadUrl`
        json_error=$(checkError "$json_out")
    if [[ $json_error != '' ]];
    then
        echo "$PROJECT - Yandex.Disk error: $json_error"
    else
        echo "$PROJECT - Copying file to Yandex.Disk success"
    fi
    else
        echo 'Some errors occured. Check log file for detail'
    fi
}

function backups_list()
{
    # Ищем в директории приложения все файлы бекапов и выводим их названия:
    curl -s -H "Authorization: OAuth $TOKEN" "https://cloud-api.yandex.net:443/v1/disk/resources?path=app:/&sort=created&limit=100" | tr "{},[]" "\n" | grep "name[[:graph:]]*.tar.gz" | cut -d: -f 2 | tr -d '"'
}

function backups_count()
{
    local bkps=$(backups_list | wc -l)
    # Если мы бекапим и файлы, и БД, то на 1 бекап у нас приходится 2 файла. Поэтому количество бекапов = количество файлов / 2:
    expr $bkps / 2
}

function remove_old_backups()
{
    bkps=$(backups_count)
    old_bkps=$((bkps - MAX_BACKUPS))
    if [ "$old_bkps" -gt "0" ];then
        echo "Удаляем старые бекапы с Яндекс.Диска"
        # Цикл удаления старых бекапов:
        # Выполняем удаление первого в списке файла 2*old_bkps раз
        for i in `eval echo {1..$((old_bkps * 2))}`; do
            curl -X DELETE -s -H "Authorization: OAuth $TOKEN" "https://cloud-api.yandex.net:443/v1/disk/resources?path=app:/$(backups_list | awk '(NR == 1)')&permanently=true"
        done
    fi
}

# Создаем каталог для локальный бэкапов на диске
sudo mkdir -p $BACKUP_DIR

# Создаем архив каталогов
sudo tar -czf $BACKUP_DIR/$FILENAME $DIRS

# Выгружаем на Яндекс.Диск архив с файлами
uploadFile $BACKUP_DIR/$FILENAME

# Удаляем архивы с диска
sudo find $BACKUP_DIR -type f -name "*.gz" -exec rm '{}' \;

# Удаляем старые бекапы с Яндекс.Диска (если MAX_BACKUPS > 0)
if
[ $MAX_BACKUPS -gt 0 ];
then
remove_old_backups;
fi