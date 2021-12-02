ARG IMAGE_BUILDER

FROM $IMAGE_BUILDER

ARG BGBILLING_DOWNLOAD_URL_ACCESS
ARG BGBILLING_DOWNLOAD_FILE_ACCESS

RUN mkdir -p /opt/bgbilling /var/log/bginetaccess

ADD $BGBILLING_DOWNLOAD_URL_ACCESS /opt/bgbilling

RUN unzip /opt/bgbilling/$BGBILLING_DOWNLOAD_FILE_ACCESS -d /opt/bgbilling

RUN apt-get -qq update \
 && apt-get -qq install --no-install-recommends \
    supervisor
ADD container/ /

RUN chmod 744 /opt/bgbilling/BGInetAccess/bin/*.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]