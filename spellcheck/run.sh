#!/bin/bash

ORG=elac

# Version can be specified by first arg. Default is stable
if [ $# -eq 0 ]; then
    SCVERSION="stable"
else
    SCVERSION="$1"
fi

# Stop exisiting containers and ignore error messages (container does not exist)
docker container stop ${ORG?}/shellcheck:"${SCVERSION?}" &> /dev/null;

# Start a new container with the current work dir mounted under /mnt as a readonly volume. 
# Pass shellcheck.sh as a entry point
docker run --rm -it \
    -v "$PWD":/mnt \
    --workdir /mnt \
    ${ORG?}/shellcheck:"${SCVERSION?}" ./shellcheck.sh