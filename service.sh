#!/bin/bash

if [ $DOCKER_DEBUG = 1 ]; then
  samba -V
fi

cat /etc/samba/smb.conf.org > /etc/samba/smb.conf
cat /.docker/smb-global.conf >> /etc/samba/smb.conf
echo "[netlogon]" >> /etc/samba/smb.conf
echo "        path = /var/lib/samba/sysvol/sambaad.local/scripts" >> /etc/samba/smb.conf
echo "        read only = No" >> /etc/samba/smb.conf
echo "[sysvol]" >> /etc/samba/smb.conf
echo "        path = /var/lib/samba/sysvol" >> /etc/samba/smb.conf
echo "        read only = No" >> /etc/samba/smb.conf
cat /.docker/smb-share.conf >> /etc/samba/smb.conf

sed -i "/dns forwarder = /d" /etc/samba/smb.conf
sed -i "5a dns forwarder=$DNS_FORWARD_1 $DNS_FORWARD_2" /etc/samba/smb.conf

cat /etc/samba/smb.conf
exec ionice -c 3 /usr/sbin/samba -i -s /etc/samba/smb.conf < /dev/null
