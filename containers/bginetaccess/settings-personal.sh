#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=bginetaccess
# Образ для сборки
export IMAGE_BUILDER=openjdk:15-jdk-buster
# Номер версии
NUMBER_VERSION=8.2110
# Номер сборки
NUMBER_BUILD=2112011536
# Тэг образа
TAG_NEW=$NUMBER_VERSION-$NUMBER_BUILD
# Название файла с архивом bginetaccess
export BGBILLING_DOWNLOAD_FILE=BGInetAccess_$NUMBER_VERSION-$NUMBER_BUILD.zip
# Путь для скачивания файла bginetaccess
export BGBILLING_DOWNLOAD_URL=https://bgbilling.ru/download/$NUMBER_VERSION/data/$BGBILLING_DOWNLOAD_FILE

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------