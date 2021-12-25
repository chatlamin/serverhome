#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=cbackup
# Образ для сборки
export IMAGE_BUILDER=ubuntu:16.04
# Тэг образа
TAG_NEW=1.1.2

##
# Имя базы данных
DB_DATABASE=cbackup
# Пользователь базы данных
DB_USERNAME=cbackup
# Пароль базы данных
DB_PASSWORD=Aebaxeivoo6eiv
# Имя контейнера базы данных
DB_CONTAINER_NAME=mysql-5-7-master
# Пароль от root
MYSQL_ROOT_PASSWORD=Dae2fiiChohng0
# Пароль пользователя cbackup
export CBACKUP_USER_PASSWORD=cbackup_password

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------