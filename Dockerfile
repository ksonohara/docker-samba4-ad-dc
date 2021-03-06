FROM ubuntu:18.04
MAINTAINER Expert Software Inc. / https://www.e-software.company

LABEL name="Samba 4 AD/DC" \
      vendor="ExpertSoftware Inc." \
      license="GPLv3" \
      build-date="20190711" \
      build-tag="1.0.0_1" \
      build-version="1"

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8

RUN mkdir /.docker

COPY config.txt /.docker/config
COPY smb-global.txt /.docker/smb-global.conf
COPY smb-share.txt /.docker/smb-share.conf

COPY init.sh /.docker/init.sh
COPY setup.sh /.docker/setup.sh
COPY service.sh /.docker/service.sh
RUN chmod 755 /.docker
RUN chmod 755 /.docker/*.sh

RUN apt-get install -y samba smbclient krb5-kdc winbind

RUN apt-get autoremove -y

ENV DOCKER_DEBUG 0

ENV DNS_FORWARD 1.1.1.1
ENV DNS_DOMAIN sambaad.local
ENV AD_PASSWORD PASS0rd123
ENV AD_REALM sambaad.local
ENV AD_DOMAIN SAMBAAD
ENV AD_NOSTRONGAUTH 1
ENV AD_HOST_IP ""
ENV AD_OPTIONS ""
#ENV AD_TIMEZONE "Asia/Tokyo"


VOLUME ["/var/lib/samba", "/var/log/samba", "/etc/samba", "/run/samba", "/.docker"]

EXPOSE 53 135 137/udp 138/udp 139 389 445 464 636

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


RUN apt-get clean

ENTRYPOINT ["/entrypoint.sh"]
