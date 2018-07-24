#!/bin/bash

if [ $DOCKER_DEBUG = 1 ]; then
  ls -lrt / | grep docker
  ls -lrt /.docker
fi
source /.docker/config

source /.docker/init.sh

[ -f /.docker/setup ] || {
  source /.docker/setup.sh
}

source /.docker/service.sh
