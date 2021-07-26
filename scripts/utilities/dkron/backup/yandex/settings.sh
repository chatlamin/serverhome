#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

# Директория для временного хранения бекапов, которые удаляются после отправки на Яндекс.Диск
BACKUP_DIR='/data1/backups/tmp-backup-yandex'
# Название проекта, используется в логах и именах архивов
PROJECT='pippin.serverhome.home'
# Максимальное количество хранимых на Яндекс.Диске бекапов (0 - хранить все бекапы):
MAX_BACKUPS='7'
# Дата, используется в именах архивов
DATE=`date '+%Y-%m-%d_%H-%M-%S'`
# Директории для архивации (указываются через пробел), которые будут помещены в единый архив и отправлены на Яндекс.Диск
DIRS="/data1/backups/remote"
# Имя лог-файла, хранится в директории, указанной в $BACKUP_DIR
LOGFILE='backup.log'
# Имя файла бэкапа
FILENAME=$DATE-$PROJECT.tar.gz

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------