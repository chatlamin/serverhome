ARG IMAGE_BUILDER

FROM $IMAGE_BUILDER

ARG CBACKUP_USER_PASSWORD

RUN echo "mysql-server mysql-server/root_password password fakepassword" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password fakepassword" | debconf-set-selections

RUN groupadd -r cbackup \
  && useradd -r -g cbackup -G www-data -d /opt/cbackup -s /bin/bash -c "cBackup System User" cbackup

RUN echo "cbackup:$CBACKUP_USER_PASSWORD" | chpasswd

RUN apt-get -qq update \
 && apt-get -qq install --no-install-recommends \
    git \
    snmp \
    default-jre \
    openssh-server \
    apache2 \
    php7.0-mysql \
    php7.0-curl \
    php7.0-json \
    php7.0-cgi \
    php7.0 \
    libapache2-mod-php7.0 \
    php-gmp \
    php-zip \
    php-intl \
    php-ssh2 \
    php-snmp \
    php-mbstring \
    php-mcrypt \
    php-bcmath \
    php-cli \
    php-curl \
    php \
    mysql-server \
    php-mysql \
    wget \
    supervisor \
    sudo

RUN wget -O ~/cbackup.deb "http://cbackup.me/latest?package=deb"

RUN cd ~ && dpkg -i cbackup.deb

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/apache2 /var/log/sshd /var/log/cbackup

ADD container/ /

CMD ["/usr/bin/supervisord"]

