#!/bin/bash
if [ -z "$1" ]; then
    echo "No BOOST version provided, falling back to 1.74.0"
fi

ORG=elac
BOOST_VERSION=${1:-1.74.0}
BOOST_VERSION_ESCAPED=${BOOST_VERSION//./_}
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Delete old image
docker rmi ${ORG}/boost:${BOOST_VERSION}

# Build image
docker build "$DIR" -t ${ORG}/boost:"${BOOST_VERSION}" --build-arg BOOST_VERSION="${BOOST_VERSION}" --build-arg BOOST_VERSION_ESCAPED="${BOOST_VERSION_ESCAPED}"
