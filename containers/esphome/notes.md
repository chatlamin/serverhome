# notes

Утилита для подготовки прошивки.

Получившуюся прошивку можно залить через из браузера через ресурс https://web.esphome.io/

Подключить esp32 к компьютеру, драйвер https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers

ИЛИ

В run.sh пропишите

```
    --privileged \
    --volume /dev/ttyUSB0:/dev/ttyUSB0 \
```

и прошивайте прямо в вэб-интерфейсе http://esphome.serverhome.home:65113/ выбрав пункт `Plug into the computer running ESPHome Dashboard` -> `CP2102 USB to UART Bridge Controller`