ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER postgres

ADD container/ /

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]