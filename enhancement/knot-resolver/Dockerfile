ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       netcat \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY container/ /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/kresd", "-n", "-c", "/etc/knot-resolver/kresd.conf"]