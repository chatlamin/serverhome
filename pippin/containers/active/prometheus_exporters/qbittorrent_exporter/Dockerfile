ARG IMAGE_BUILD

FROM $IMAGE_BUILD
RUN apk add --update --no-cache \
    python3
RUN mkdir -p /project /tmp

ARG VERS

ADD https://github.com/esanchezm/prometheus-qbittorrent-exporter/releases/download/$VERS/prometheus-qbittorrent-exporter-$VERS.tar.gz /tmp/qbittorrent_exporter.tar.gz
RUN tar -C /tmp -xvf /tmp/qbittorrent_exporter.tar.gz
RUN mv -v /tmp/prometheus-qbittorrent-exporter-$VERS/* /project
RUN rm -R /tmp
RUN pip3 install /project
#ENV QBITTORRENT_HOST=""
#ENV QBITTORRENT_PORT=""
#ENV QBITTORRENT_USER=""
#ENV QBITTORRENT_PASS=""
#ENV EXPORTER_PORT="8000"
#ENV EXPORTER_LOG_LEVEL="INFO"
ENTRYPOINT ["qbittorrent-exporter"]