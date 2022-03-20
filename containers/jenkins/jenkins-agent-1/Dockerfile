ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

# General purpose packages
RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
      sshpass \
      rsync \
      postgresql-client \
      curl \
      wget

# MySQL
RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
      mydumper

# Cleanup
RUN apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*