FROM sonohara/ubuntu-base
MAINTAINER Expert Software Inc. / https://www.e-software.company

LABEL name="Samba 4 AD/DC" \
      vendor="ExpertSoftware Inc." \
      license="GPLv3" \
      build-date="20210525" \
      build-tag="1.0.2_5" \
      build-version="5"

COPY config.txt /.docker/config
COPY smb-global.txt /.docker/smb-global.conf
COPY smb-share.txt /.docker/smb-share.conf

COPY init.sh /.docker/init.sh
COPY setup.sh /.docker/setup.sh
COPY service.sh /.docker/service.sh
RUN chmod 755 /.docker
RUN chmod 755 /.docker/*.sh

#RUN sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt update -y
RUN apt install -y samba smbclient krb5-kdc winbind vim

ENV DNS_FORWARD_1 1.1.1.1
ENV DNS_FORWARD_2 4.4.4.4
ENV DNS_DOMAIN sambaad.local
ENV AD_PASSWORD PASS0rd123
ENV AD_REALM sambaad.local
ENV AD_HOST ad
ENV AD_DOMAIN SAMBAAD
ENV AD_NOSTRONGAUTH 1
ENV AD_HOST_IP ""
ENV AD_OPTIONS ""

VOLUME ["/var/lib/samba", "/var/log/samba", "/etc/samba", "/run/samba"]

EXPOSE 53 53/udp 135 137/udp 138/udp 139 389 445 464 636

RUN apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
