# Установка и запуск filebeat

Скачать filebeat для windows https://www.elastic.co/downloads/beats/filebeat (пример: https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.15.1-windows-x86_64.zip)

Создать каталог C:\softwar\filebeat\7.15.1\

Распаковать все содержимое архива в каталог C:\softwar\filebeat\7.15.1\

Положить каталог config в каталог C:\softwar\filebeat\7.15.1\

Для запуска filebeat выполни

    .\run-filebeat.bat

## Настройка на привере сбора логов программы chia

В файле config\filebeat.yml в строке

```
...
  paths:
    - c:\Users\USERNAME\.chia\mainnet\log\*
...
```

замени USERNAME на свой