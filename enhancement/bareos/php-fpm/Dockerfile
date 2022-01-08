ARG IMAGE_BUILD

FROM $IMAGE_BUILD

ENV TIMEZONE=Europe/Moscow

RUN apk add --no-cache gettext && \
    apk add --no-cache --virtual .build-dependencies gettext-dev && \
    docker-php-ext-install gettext mysqli && \
    apk del .build-dependencies

COPY container/ /

RUN chmod u+x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/env", "php-fpm"]