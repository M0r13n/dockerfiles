#!/bin/bash

ORG="elac"

# Version can be specified by first arg. Default is stable
if [ $# -eq 0 ]; then
    SCVERSION="stable"
else
    SCVERSION="$1"
fi

VERSION="$SCVERSION"

# Delete old image
docker rmi ${ORG?}/shellcheck:"${VERSION?}"

# Build image
docker build . -t ${ORG?}/shellcheck:"${VERSION?}" --build-arg SCVERSION="${VERSION?}"
