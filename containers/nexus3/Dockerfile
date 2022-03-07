ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

ADD container/ /

RUN chown -R 200 /nexus-data

USER nexus