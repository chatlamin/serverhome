ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

RUN apk add --quiet \
    curl

CMD ["server"]