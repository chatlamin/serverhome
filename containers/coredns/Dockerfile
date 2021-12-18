FROM ubuntu:20.04

ARG TAG_NEW
ARG OS
ARG ARCHITECTURE

ADD https://github.com/coredns/coredns/releases/download/v${TAG_NEW}/coredns_${TAG_NEW}_${OS}_${ARCHITECTURE}.tgz /

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       curl \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /coredns
RUN tar --extract --gzip --file=coredns_${TAG_NEW}_${OS}_${ARCHITECTURE}.tgz --directory=/coredns

COPY container/ /

CMD ["/coredns/coredns", "-conf", "/etc/coredns/corefile"]