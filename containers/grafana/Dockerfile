ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

ADD container/ /

RUN apk add --quiet \
    curl \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install frser-sqlite-datasource \
    && grafana-cli plugins install redis-datasource \
    && grafana-cli plugins install alexanderzobnin-zabbix-app