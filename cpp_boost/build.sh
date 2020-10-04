#!/bin/bash

if [ $# -eq 0 ]
  then
    printf "Usage: ./build.sh <BOOST_VERSION>\nExample: build-docker.sh 1.75.0"
    exit 1
fi

ORG=elac
BOOST_VERSION=$1
BOOST_VERSION_ESCAPED=${BOOST_VERSION//./_}

# Delete old image
docker rmi ${ORG}/boost:${BOOST_VERSION}

# Build image
docker build . -t ${ORG}/boost:${BOOST_VERSION} --build-arg BOOST_VERSION=${BOOST_VERSION} --build-arg BOOST_VERSION_ESCAPED=${BOOST_VERSION_ESCAPED}