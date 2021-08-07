# Ссылки на проект
https://www.home-assistant.io/

https://github.com/home-assistant/core

https://github.com/home-assistant/docker

https://hub.docker.com/r/homeassistant/home-assistant

# Адрес
http://homeassistant.serverhome.home:8123/

Не забудь:

Создать и указать свои секреты в файле containers/amd64/homeassistant/homeassistant/container/config/secrets.yaml

или

Заменить в во всех файлах конфигураций `!secret FOO` на свои секреты

или

При в containers/amd64/homeassistant/homeassistant/Dockerfile закомментировать строку `ADD container/ /`, что бы получить чистую конфигурацию