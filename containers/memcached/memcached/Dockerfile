ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       netcat `# For health checks` \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY container/ /

USER memcache