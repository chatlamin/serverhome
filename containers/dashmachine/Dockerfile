ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       curl \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*