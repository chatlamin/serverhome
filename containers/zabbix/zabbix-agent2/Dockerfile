ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

COPY container/ /

USER root

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       curl \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER 1997