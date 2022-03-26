для запуска выполни:

Скачай и установки go для windows https://golang.org/doc/install (проверено на go1.16.5.windows-amd64.msi )
Скачай и установи smartmontools для windows https://github.com/smartmontools/smartmontools/releases (проверено на smartmontools-7.2-1.win32-setup.exe)
Открой командную строку
Убедись, что go установлена (например выполнить go version)
Убедись, что smartmontools установлена (например выполни smartctl --scan)

Скачай и распакуй scrutiny, к примеру в каталог c:/scrutiny/0.3.12/ https://github.com/AnalogJ/scrutiny/releases (качай Source code (zip),должен скачатся файл scrutiny-0.3.12.zip)

Создай каталог для логов c:/scrutiny/log и конфига c:/scrutiny/config
Пример конфига https://github.com/AnalogJ/scrutiny/blob/master/example.collector.yaml

Выполни для запуска:

    cd c:\scrutiny\0.3.12\collector\cmd\collector-metrics\
    go.exe run .\collector-metrics.go run