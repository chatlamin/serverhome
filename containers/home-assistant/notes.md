# notes
Не забудь:

Создать и указать свои секреты в файле containers/amd64/homeassistant/homeassistant/container/config/secrets.yaml

или

Заменить в во всех файлах конфигураций `!secret FOO` на свои секреты

или

При в containers/amd64/homeassistant/homeassistant/Dockerfile закомментировать строку `ADD container/ /`, что бы получить чистую конфигурацию

Настройка устройств xiaomi теперь происходит через привязку аккаунта mi home https://www.home-assistant.io/integrations/xiaomi_miio/#configuration

Ошибка WARNING (MainThread) [homeassistant.components.ssdp] Failed to setup listener for 0.0.0.0: [Errno 98] Address in use
Проверьте, не занят ли порт 1900. Возможно, это plex

Компонент для https (нужен белый ip) 
https://github.com/AlexxIT/Dataplicity
Регистрация https://www.dataplicity.com/