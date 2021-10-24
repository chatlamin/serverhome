#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=grafana
# Репозиторий
EXPLORE=grafana/grafana
# Тэг образа старый
TAG_OLD=8.2.0
# Тэг образа новый
TAG_NEW=8.2.2

##
# Тип базы данных
DB_CONNECTION=mysql
# ip / dns базы данных
DB_HOST=mysql.serverhome.home
# Имя базы данных
DB_DATABASE=grafana
# Пользователь базы данных
DB_USERNAME=grafana
# Пароль базы данных
DB_PASSWORD=shohg5Sei3igh3
# Имя контейнера базы данных
DB_CONTAINER_NAME=mysql-8
# Пароль от root
MYSQL_ROOT_PASSWORD=Dae2fiiChohng0
# Логин дэфолтного администратора
ADMIN_USER=admin
# Пароль дэфолтного администратора
ADMIN_PASS=Thee2veih0hoo4
# Путь к дэфолтному дэшборду
DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH=/etc/grafana/provisioning/dashboards/common/telegraf-system.json
# Локальный порт
LOCAL_PORT=3000

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------