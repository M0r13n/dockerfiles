#!/bin/bash

ORG=elac
SAMPLE_PROJECT=test

# Stop exisiting containers and ignore error messages (container does not exist)
docker container stop test-shellcheck &> /dev/null;

docker run --rm -it \
    --name ${SAMPLE_PROJECT}-shellcheck \
    -v "$PWD":/mnt \
    -- workdir /mnt \
    ${ORG}/shellcheck:latest ./shellcheck.sh