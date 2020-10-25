#!/bin/bash

ORG="elac"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
base="$(dirname "${BASH_SOURCE[0]}")"

build() {
    org="$1"
    version="$2"

    # Delete old image
    docker rmi ${org?}/shellcheck:"${version?}"

    # Build image
    docker build --rm "$DIR" -t "${REPO_URL?}/${base?}:${version?}" --build-arg SCVERSION="${version?}"
}

# Version can be specified by first arg. Default is stable
if [ $# -eq 0 ]; then
    SCVERSION="stable"
else
    SCVERSION="$1"
fi

build "${ORG}" "${SCVERSION}"
