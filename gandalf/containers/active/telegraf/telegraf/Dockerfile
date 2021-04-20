ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

CMD ["telegraf", "--config-directory", "/etc/telegraf/telegraf.d"]