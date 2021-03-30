#!/bin/bash

if [ $DOCKER_DEBUG = 1 ]; then
  uname -a
  set
  hostname
  ip a
fi

if [ $DOCKER_DEBUG = "1" ]; then
  cat /etc/resolv.conf
fi
