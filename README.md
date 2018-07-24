# Summary

Samba 4 ActiveDirectory DC docker container.

# Description

Include ubuntu:18.04 image.

# Usage

## Configuration

### --env

    DOCKER_DEBUG 0
    DNS_FORWARD 8.8.8.8
    DNS_DOMAIN sambaad.local
    AD_PASSWORD PASS0rd123
    AD_REALM sambaad.local
    AD_DOMAIN SAMBAAD
    AD_NOSTRONGAUTH 1
    AD_HOST_IP ""
    AD_OPTIONS ""

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
    /.docker

## Examples

### Start Docker Container

    sudo docker run --privileged -it -p 389:389 \
                -e "DOCKER_DEBUG=1" \
                -e "DNS_FORWARD=8.8.8.8" \
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
