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