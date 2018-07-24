#!/bin/bash


if [ $DOCKER_DEBUG = 1 ]; then
  uname -a
  set
  hostname
fi

echo search $DNS_DOMAIN> /etc/resolv.conf
echo nameserver 127.0.0.1>> /etc/resolv.conf
echo nameserver $DNS_FORWARD>> /etc/resolv.conf

if [ $DOCKER_DEBUG = "1" ]; then
  cat /etc/resolv.conf
fi
