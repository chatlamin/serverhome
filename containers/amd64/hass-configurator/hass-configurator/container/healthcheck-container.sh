#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# Минимальный рамер файлов в папке homeassistant
SIZE_MIN=50

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# Проверяем размер файлов. Если меньше полученного в SIZE_MIN - выходим с ошибкой 1
CURRENT=$(du -s /hass-config | awk '{print $1}')
if
[ $CURRENT -gt $SIZE_MIN ];
then
echo "Success"
else
exit 1
fi