#!/bin/bash


if [ $# -eq 0 ]
  then
    printf "Usage: ./run-docker.sh BOOST_VERSION\nExmaple: ./run-docker.sh 1.75.0"
    exit 1
fi

ORG="elac"
BOOST_VERSION=$1
docker run -ti ${ORG}/boost:${BOOST_VERSION} /bin/bash