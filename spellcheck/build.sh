#!/bin/bash



ORG=elac
VERSION=latest

# TODO Delete old image 
# docker rmi ${ORG}/shellcheck

# Build image
docker build . -t ${ORG}/shellcheck:${VERSION}