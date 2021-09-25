# Ссылки на проект
https://cbackup.me/ru/

https://github.com/cBackup/main

https://github.com/chatlamin/cBackup-docker

## Supported architectures
| Architectures | Support |
| :------------ | :------ |
| amd64         | +       |
| arm64         | -       |
| armhf         | -       |


Используй mysql версии 5.7, так как у установщика cbackup проблемы с инициализации базы в mysql 8.X.XX. Ошибка `Undefined index: constraint_name` (в помощь https://github.com/yiisoft/yii2/issues/18171).

После запуска контейнера, supervisor будет пытаться запустить сервис cbackup до тех пор, пока вы не закончите первичную настройку по адресу http://IP-ADDRESS/cbackup/index.php

Не решенная проблема: в вэб интерфейсе будет отображатся, что `Java service is not running`, ошибка `Failed to connect to bus: No such file or directory`.
Причина - в данном проекте используется supervisor для запуска сервисов, требуемых cbackup, и cbackup не поддерживает такой тип запуска. Смотри /opt/cbackup/config/settings.ini
Подробнее https://cbackup.readthedocs.io/en/latest/getting-started/servers/general/ https://github.com/cBackup/main/blob/master/cookbook/ru/TROUBLESHOOTING.md
Данная проблема на работу приложения не влияет, она, видимо отвечает только за мониторинг сервиса cbackup