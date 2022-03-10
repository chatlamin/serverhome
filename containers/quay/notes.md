# notes

https://github.com/quay/quay/blob/master/docs/quick-local-deployment.md#build-the-quay-configuration-via-configtool

Для запуска режима конфигурации, добавьте в `./run` `config secret`, например так:

    $HEALTHCHECK_SETTINGS \
    $IMAGE_TARGET \
    config secret

И зайдите по адресу http://quay.serverhome.home:65016 логин `quayconfig` пароль `secret`



Для изменений конфигурации редактируйте файл `/var/lib/docker/volumes/quay-conf/_data/conf/stack/config.yaml`

