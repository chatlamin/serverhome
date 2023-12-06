ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       netcat `# For health checks` \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY container/ /

ENTRYPOINT ["/entrypoint-container.sh"]
CMD ["/usr/sbin/kresd", "--noninteractive", "--config", "/etc/knot-resolver/kresd.conf.lua"]
