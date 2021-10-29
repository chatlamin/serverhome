Скачать filebeat для windows https://www.elastic.co/downloads/beats/filebeat

В файле filebeat.yml в строке

```
...
  paths:
    - c:\Users\USERNAME\.chia\mainnet\log\*
...
```

замени USERNAME на свой

для запуска выполни

    .\filebeat.exe -c filebeat.yml

или запусти файл `run-filebeat.bat`