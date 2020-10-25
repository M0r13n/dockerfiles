#!/bin/bash
if [ -z "$1" ]; then
    echo "No BOOST version provided, falling back to 1.74.0"
fi

BOOST_VERSION=${1:-1.74.0}
BOOST_VERSION_ESCAPED=${BOOST_VERSION//./_}
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
base="$(dirname "${BASH_SOURCE[0]}")"

# Build image
docker build --rm --force-rm -t "${REPO_URL?}/${base?}:${BOOST_VERSION?}" "${DIR?}" --build-arg BOOST_VERSION="${BOOST_VERSION?}" --build-arg BOOST_VERSION_ESCAPED="${BOOST_VERSION_ESCAPED?}"
