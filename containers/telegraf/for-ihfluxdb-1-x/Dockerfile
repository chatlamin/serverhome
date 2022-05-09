ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

USER root

RUN rm --force /etc/telegraf/telegraf.d/*

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
     smartmontools nvme-cli chrony sudo curl \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'telegraf ALL = NOPASSWD: /usr/bin/smartctl, /usr/sbin/smartctl' | sudo EDITOR='tee -a' visudo

COPY container/ /

CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf", "--config-directory", "/etc/telegraf/telegraf.d"]