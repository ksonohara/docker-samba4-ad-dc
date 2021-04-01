#!/bin/bash


rm -rf /etc/krb5.conf
if [ -d /var/lib/samba/sysvol/exs.e-software.network ]; then
  echo 'Done. reuse.'
else
  rm -rf /etc/samba/smb.conf
  rm -rf /var/lib/samba/private/*
  rm -rf /var/lib/samba/sysvol/*

  SAMBA_TOOL_OPTIONS=${AD_OPTIONS:-}

  [ -n "$AD_HOST_IP" ] && SAMBA_TOOL_OPTIONS="$SAMBA_TOOL_OPTIONS --host-ip=$AD_HOST_IP"

  samba-tool domain provision \
    --use-rfc2307 \
    --realm=$AD_REALM \
    --host-name=$AD_HOST \
    --domain=$AD_DOMAIN \
    --adminpass=$AD_PASSWORD \
    --server-role=dc \
    --dns-backend=SAMBA_INTERNAL $SAMBA_TOOL_OPTIONS

  if [ $AD_NOSTRONGAUTH = 1 ]; then
    sed -i "5a ldap server require strong auth = no" /etc/samba/smb.conf
  fi

  sed -i -e '11,18d' /etc/samba/smb.conf

  cat /.docker/smb-global.conf >> /etc/samba/smb.conf
  echo "[netlogon]" >> /etc/samba/smb.conf
  echo "        path = /var/lib/samba/sysvol/sambaad.local/scripts" >> /etc/samba/smb.conf
  echo "        read only = No" >> /etc/samba/smb.conf
  echo "[sysvol]" >> /etc/samba/smb.conf
  echo "        path = /var/lib/samba/sysvol" >> /etc/samba/smb.conf
  echo "        read only = No" >> /etc/samba/smb.conf
  cat /.docker/smb-share.conf >> /etc/samba/smb.conf
fi

rm -f /etc/krb5.conf
ln -s /var/lib/samba/private/krb5.conf /etc/krb5.conf

echo "search $DNS_DOMAIN"    > /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf

samba-tool domain level show

touch /.docker/setup
