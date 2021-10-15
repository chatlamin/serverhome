ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

USER root

RUN chmod g+rwx /usr/share/kibana/config

USER kibana