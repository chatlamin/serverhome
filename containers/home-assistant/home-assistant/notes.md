# notes
Не забудь:

Создать и указать свои секреты в файле containers/amd64/homeassistant/homeassistant/container/config/secrets.yaml

или

Заменить в во всех файлах конфигураций `!secret FOO` на свои секреты

или

При в containers/amd64/homeassistant/homeassistant/Dockerfile закомментировать строку `ADD container/ /`, что бы получить чистую конфигурацию