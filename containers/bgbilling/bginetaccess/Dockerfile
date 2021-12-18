FROM ubuntu:20.04

ARG BGBILLING_DOWNLOAD_URL
ARG BGBILLING_DOWNLOAD_FILE

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       netcat `# For health checks` \
       unzip \
       locales \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /opt/bgbilling /opt/java

ADD $BGBILLING_DOWNLOAD_URL /opt/bgbilling

RUN unzip -qq /opt/bgbilling/$BGBILLING_DOWNLOAD_FILE -d /opt/bgbilling

ADD container/ /

RUN cat OpenJDK15U-jdk_x64_linux_openj9_15.0.2_7_openj9-0.24.0.tar.gz* > OpenJDK15U-jdk_x64_linux_openj9_15.0.2_7_openj9-0.24.0.tar.gz

RUN tar -C /opt/java -xvf OpenJDK15U-jdk_x64_linux_openj9_15.0.2_7_openj9-0.24.0.tar.gz

RUN mv /opt/java/jdk-15.0.2+7 /opt/java/jdk15

RUN chmod 744 /opt/bgbilling/BGInetAccess/bin/*.sh

# https://stackoverflow.com/a/27931669
RUN locale-gen ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/bgbilling/BGInetAccess/bin/application.sh", "start"]