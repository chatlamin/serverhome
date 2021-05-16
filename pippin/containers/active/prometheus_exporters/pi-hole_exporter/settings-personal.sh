#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

##
# Название проекта
export NAME=pi-hole_exporter
# Версия релиза
export VERS=0.0.11
# Конечный образ
export IMAGE_BUILD=alpine:3.11
# Образ для сборки
export IMAGE_BUILDER=golang:1.15-alpine3.12

##
# Адрес pi-hole
PIHOLE_HOST=pi-hole.serverhome.home
# Порт pi-hole вэб-интерфейса
PIHOLE_PORT=65010
# Пароль от интерфейса pi-hole
PIHOLE_PASSWORD=eeleBarudah0an

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------