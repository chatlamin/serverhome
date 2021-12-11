ARG IMAGE_BUILDER

FROM $IMAGE_BUILDER

ARG BGBILLING_DOWNLOAD_URL
ARG BGBILLING_DOWNLOAD_FILE

RUN mkdir -p /opt/bgbilling

ADD $BGBILLING_DOWNLOAD_URL /opt/bgbilling

RUN unzip -qq /opt/bgbilling/$BGBILLING_DOWNLOAD_FILE -d /opt/bgbilling

ADD container/ /

RUN chmod 744 /opt/bgbilling/BGInetAccounting/bin/*.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/bgbilling/BGInetAccounting/bin/application.sh", "start"]