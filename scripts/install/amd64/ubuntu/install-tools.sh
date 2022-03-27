#!/usr/bin/env bash

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

sudo apt-get -qq install \
    apache2-utils \
    dos2unix \
    git git-lfs \
    htop \
    httpie \
    jq \
    mc \
    multitail \
    ncdu \
    nmap \
    nmon \
    openssh-server \
    petname \
    pv \
    pwgen \
    rlwrap \
    shellcheck \
    snmp \
    snmp-mibs-downloader \
    smitools \
    tree \
    unrar \
    uuid-runtime \
    whois \
    smartmontools \
    nfs-client \
    cifs-utils \
    libatomic1 `# для mydumper/myloader https://github.com/mydumper/mydumper#ubuntu--debian` \
    clickhouse-client \
    influxdb-client \
    mongodb-clients \
    mysql-client \
    postgresql-client \
    redis-tools