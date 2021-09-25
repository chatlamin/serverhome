ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

ADD container/ /

RUN apk add --quiet \
    && grafana-cli plugins install grafana-piechart-panel \
    && grafana-cli plugins install frser-sqlite-datasource \
    && grafana-cli plugins install redis-datasource