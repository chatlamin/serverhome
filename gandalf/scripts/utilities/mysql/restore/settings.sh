#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# ip / dns базы данных
DB_HOST=mysql.serverhome.home
# Порт базы данных
DB_PORT=3306
# Пользователь базы данных
DB_USERNAME=root
# Пароль базы данных
DB_PASSWORD=Dae2fiiChohng0
# Имя базы данных
DB_DATABASE=bookstack
# Домашний каталог текущего пользователя
export HOME=$(bash <<< "echo ~$SUDO_USER")
# Путь к сохраненному дампу
BACKUP_PATH_FILE=$HOME/backups-mysql/bookstack

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------