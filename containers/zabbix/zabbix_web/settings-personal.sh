#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=zabbix_web
# Репозиторий
EXPLORE=zabbix/zabbix-web-nginx-mysql
# Тэг образа старый
TAG_OLD=start
# Тэг образа новый
TAG_NEW=ubuntu-5.4.4

##
# Тип базы данных
DB_CONNECTION=mysql
# ip / dns базы данных
DB_HOST=mysql-8.serverhome.home
# Порт базы данных
DB_PORT=3306
# Имя базы данных
DB_DATABASE=zabbix
# Пользователь базы данных
DB_USERNAME=zabbix
# Пароль базы данных
DB_PASSWORD=Tiec2eyooL9Eem
# Имя контейнера базы данных
DB_CONTAINER_NAME=mysql-8
# Пароль от root
MYSQL_ROOT_PASSWORD=Dae2fiiChohng0
# Адрес zabbix_server
ZBX_SERVER_HOST=zabbix_server.serverhome.home
# Порт zabbix_server
ZBX_SERVER_PORT=65013

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------