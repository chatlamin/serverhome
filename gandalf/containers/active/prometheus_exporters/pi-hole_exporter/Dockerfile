ARG IMAGE_BUILDER
ARG IMAGE_BUILD
ARG OS
ARG ARCHITECTURE

FROM $IMAGE_BUILDER as builder
WORKDIR /go/src/github.com/eko/pihole-exporter
RUN mkdir -p /tmp

ARG VERS

ADD https://github.com/eko/pihole-exporter/archive/v$VERS.tar.gz /tmp/pihole_exporter.tar.gz
RUN tar -C /tmp -xvf /tmp/pihole_exporter.tar.gz
RUN ls /tmp
RUN mv -v /tmp/pihole-exporter-$VERS/* /go/src/github.com/eko/pihole-exporter
RUN apk --no-cache add git alpine-sdk
RUN GO111MODULE=on go mod vendor
RUN CGO_ENABLED=0 GOOS=$OS GOARCH=$ARCHITECTURE go build -ldflags '-s -w' -o binary ./

FROM $IMAGE_BUILD
WORKDIR /root/
COPY --from=builder /go/src/github.com/eko/pihole-exporter/binary pihole-exporter
CMD ["./pihole-exporter"]