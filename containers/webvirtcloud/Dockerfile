ARG IMAGE_BUILD

FROM $IMAGE_BUILD

EXPOSE 80
EXPOSE 6080

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
#CMD tail -f /dev/null

RUN echo 'APT::Get::Clean=always;' >> /etc/apt/apt.conf.d/99AutomaticClean

RUN apt-get update -qqy \
    && DEBIAN_FRONTEND=noninteractive apt-get -qyy install \
    --no-install-recommends \
    git \
    python3-venv \
    python3-dev \
    python3-lxml \
    libvirt-dev \
    zlib1g-dev \
    nginx \
    pkg-config \
    gcc \
    libldap2-dev \
    libssl-dev \
    libsasl2-dev \
    libsasl2-modules \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/retspen/webvirtcloud.git
ADD container/ /

RUN cp --recursive --no-target-directory /webvirtcloud /srv/webvirtcloud

RUN chown -R www-data:www-data /srv/webvirtcloud

# Setup webvirtcloud
WORKDIR /srv/webvirtcloud
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip3 install -U pip && \
    pip3 install wheel && \
    pip3 install -r conf/requirements.txt && \
    chown -R www-data:www-data /srv/webvirtcloud

RUN . venv/bin/activate && \
    python3 manage.py migrate && \
    chown -R www-data:www-data /srv/webvirtcloud

# Setup Nginx
RUN printf "\n%s" "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    chown -R www-data:www-data /var/lib/nginx

RUN cp /webvirtcloud/conf/nginx/webvirtcloud.conf /etc/nginx/conf.d/

# Register services to runit
RUN mkdir /etc/service/nginx && \
    mkdir /etc/service/nginx-log-forwarder && \
    mkdir /etc/service/webvirtcloud && \
    mkdir /etc/service/novnc
RUN cp --recursive --no-target-directory /webvirtcloud/conf/runit/nginx /etc/service/nginx/run
RUN cp --recursive --no-target-directory /webvirtcloud/conf/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run
RUN cp --recursive --no-target-directory /webvirtcloud/conf/runit/novncd.sh /etc/service/novnc/run
RUN cp --recursive --no-target-directory /webvirtcloud/conf/runit/webvirtcloud.sh /etc/service/webvirtcloud/run

# Define mountable directories.
#VOLUME []

RUN chown -R www-data /var/www/.ssh

WORKDIR /srv/webvirtcloud