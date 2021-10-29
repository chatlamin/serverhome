ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

ADD container/ /

CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf", "--config-directory", "/etc/telegraf/telegraf.d"]