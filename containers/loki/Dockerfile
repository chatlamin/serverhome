ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

ADD container/ /

RUN apk add --quiet --no-cache \
      curl

CMD ["-config.file=/etc/loki/loki-config.yaml"]