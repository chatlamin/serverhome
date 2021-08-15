# notes

___
Проблема:
Не доступен дэфолтный хост "Zabbix server" в вэб-интерфейсе http://zabbix_web.serverhome.home:65014/hosts.php

Ошибка:
```
Get value from agent failed: cannot connect to [[127.0.0.1]:10050]: [111] Connection refused
```
Решение:

Необходимо на хост машине, где запущен контейнер zabbix_server, запустить [zabbix_agent](https://github.com/chatlamin/serverhome/tree/main/containers/arm64/zabbix/zabbix_agent)

В `./run.sh` изменить значение переменной `ZBX_SERVER_HOST` на ip-address шлюза docker сети, в которой был запущен контейнер zabbix_server, получить его можно так: `sudo docker inspect --format='{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}' zabbix_server`

В настройках дэфолтного хоста "Zabbix server" в вэб-интерфейсе http://zabbix_web.serverhome.home:65014/hosts.php
1. Изменить значение `Host name` на `zabbix_agent.serverhome.home`
2. Удалить значение `Interfaces -> IP address`
3. Добавить значение `Interfaces -> DNS name` `zabbix_agent.serverhome.home`
4. Изменить значение `Interfasec -> Connect to` на `DNS`
4. Изменить значение `Interfaces -> Port` на `65017`

Комментарий:

Не стоит пытаться настраивать мониторинг zabbix_server с помощью дэфолтного хоста "Zabbix server". Удалите его в вэб-интерфейсе. В место этого лучше собирайте метрики о контейнере zabbix_server и хост машине с помощью [telegraf](https://github.com/chatlamin/serverhome/tree/main/containers/arm64/telegraf/telegraf)

___