ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

COPY container/ /

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       sshpass \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins