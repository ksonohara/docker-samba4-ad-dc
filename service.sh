#!/bin/bash

samba -V

sed -i "/dns forwarder = /d" /etc/samba/smb.conf
sed -i "5a dns forwarder=$DNS_FORWARD" /etc/samba/smb.conf

cat /etc/samba/smb.conf
exec ionice -c 3 /usr/sbin/samba -i -s /etc/samba/smb.conf < /dev/null
