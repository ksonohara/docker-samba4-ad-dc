# Summary

Samba 4 ActiveDirectory DC docker container.

# Description

Include sonohara/ubuntu-base

# Changelog

## build-version 1 1.0.1_0 latest

    OS Upgrade / samba4-ad-dc:1.0.1_0

## build-version 0 1.0.0_0

    First Commit / samba4-ad-dc:1.0.0_0

# Usage

## Configuration

### --env (First Only)

    DNS_DOMAIN sambaad.local
    AD_PASSWORD PASS0rd123
    AD_REALM sambaad.local
    AD_DOMAIN SAMBAAD
    AD_NOSTRONGAUTH 1
    AD_HOST AD
    AD_HOST_IP ""
    AD_OPTIONS ""

### --env

    DOCKER_DEBUG 0
    DNS_FORWARD_1 1.1.1.1
    DNS_FORWARD_1 8.8.8.8

### --port

    53 DNS
    135
    137
    138
    139
    389 LDAP
    445
    464
    636 LDAPS

### --volume

    /var/lib/samba
    /var/log/samba
    /etc/samba
    /run/samba
    /.docker

## Examples

### Start Docker Container

    docker run --privileged -it -p 389:389 \
                -e "DOCKER_DEBUG=1" \
                -e "DNS_FORWARD_1=8.8.8.8" \
                -e "DNS_DOMAIN=sambaad.local" \
                -e "AD_PASSWORD=PASS0rd123" \
                -e "AD_REALM=sambaad.local" \
                -e "AD_DOMAIN=SAMBAAD" \
                --restart=always \
                -d sonohara/samba4-ad-dc

# Other

## Copyright and license

- Code released under [GNU GENERAL PUBLIC LICENSE Version 3](https://github.com/ksonohara/docker/blob/master/LICENSE)

## Author

K.Sonohara
- GitHub: https://github.com/ksonohara
- Homepage: [ExpertSoftware Inc.](https://www.e-software.company "ExpertSoftware Inc.")
- Facebbok: [株式会社エキスパートソフトウェア](https://www.facebook.com/expertsoftwareinc "株式会社エキスパートソフトウェア")
