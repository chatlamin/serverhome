ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

USER root

RUN chown root:filebeat /usr/share/filebeat/filebeat.yml

USER filebeat