#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=rocketchat
# Репозиторий
EXPLORE=rocket.chat
# Тэг образа старый
TAG_OLD=start
# Тэг образа новый
TAG_NEW=3.17.0

##
# root url
ROOT_URL="http://rocketchat.serverhome.home:65055"
# Путь к базе
MONGO_URL="mongodb://root:wah7nie6naZ0ka@mongodb-1.serverhome.home:27017,mongodb-2.serverhome.home:27018,mongodb-3.serverhome.home:27019/rocketchat?authSource=admin&replicaSet=rs01"
# Путь к базе для прослушивания
MONGO_OPLOG_URL="mongodb://root:wah7nie6naZ0ka@mongodb-1.serverhome.home:27017,mongodb-2.serverhome.home:27018,mongodb-3.serverhome.home:27019/local?authSource=admin&replicaSet=rs01"
# Логин администратора
ADMIN_USERNAME=admin_Phoh8mosh1quoo
# Пароль администратора
ADMIN_PASS=eeye9La4Utaifa
# Почта администратора
ADMIN_EMAIL=admin@example.com
# Порт rocketchat
PORT=3000

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------