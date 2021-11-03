ARG IMAGE_SOURCE_NEW

FROM $IMAGE_SOURCE_NEW

ADD container/ /

ENTRYPOINT ["/coredns", "-conf", "/etc/coredns/corefile"]