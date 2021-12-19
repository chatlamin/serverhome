ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

RUN apk add --quiet --no-cache \
      netcat-openbsd `# For health checks`

COPY container/ /

CMD [ "redis-server", "/etc/redis/redis.conf" ]