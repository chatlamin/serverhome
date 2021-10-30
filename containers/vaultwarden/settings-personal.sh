#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=vaultwarden
# Репозиторий
EXPLORE=vaultwarden/server
# Тэг образа старый
TAG_OLD=start
# Тэг образа новый
TAG_NEW=1.23.0

##
# Токен для использования панели администратора
ADMIN_TOKEN=82OH7MoKNd/8X81bwgKKGsYpFA50gd8XZBGDOVxlOdTOoAUjNfO92O6m8GRW/nkA
# Тип базы данных
DB_CONNECTION=mysql
# ip / dns базы данных
DB_HOST=mysql-8.serverhome.home
# Порт базы данных
DB_PORT=3306
# Имя базы данных
DB_DATABASE=vaultwarden
# Пользователь базы данных
DB_USERNAME=vaultwarden
# Пароль базы данных
DB_PASSWORD=shohbohSee2oop
# Имя контейнера базы данных
DB_CONTAINER_NAME=mysql-8
# Пароль от root
MYSQL_ROOT_PASSWORD=Dae2fiiChohng0
# URL подключения к базе данных
DATABASE_URL=$DB_CONNECTION://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_DATABASE

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------