ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget

ADD container/ /