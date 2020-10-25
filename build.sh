#!/bin/bash
set -e
set -o pipefail

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
REPO_URL="${REPO_URL:-leonmortenrichter.jfrog.io/docker-local}"

do_push() {
    base="$1"
    tag="$2"

    echo "+------------------------------------------------------+"
    echo "Pushing: ${base}:${tag}"
    echo "+------------------------------------------------------+"

    n=0
    until [ $n -ge 5 ]; do
        docker push --disable-content-trust=true "${REPO_URL}/${base}:${tag}" && break
        echo "Try #$n failed... sleeping for 15 seconds"
        n=$((n + 1))
        sleep 15
    done

    echo "+------------------------------------------------------+"
    echo "Successfully pushed ${base}:${tag}"
    echo "+------------------------------------------------------+"
}

do_build() {

    echo "+------------------------------------------------------+"
    echo "Building: ${1}:$2"
    echo "+------------------------------------------------------+"

    "$1/build.sh" "${@:2}"

    echo "+------------------------------------------------------+"
    echo "Successfully built: ${1}:$2"
    echo "+------------------------------------------------------+"
}

# Parse args
push=false
while getopts ":p:" opt; do
    case $opt in
    p)
        push=true
        shift 1
        ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

# A least a path is required
if [ $# -eq 0 ]; then
    printf "[ERROR]: No target defined.\nUsage: ./build.sh TARGET [VERSION].\n"
    exit 1
fi

# Check if path actually exists
if [ ! -d "${SCRIPT_DIR}/$1" ]; then
    echo "[ERROR]: ${SCRIPT_DIR}/$1 does not exist!"
    exit 2
fi

# If no version is provided fall back to latest
if [[ -z "$tag" ]] || [[ "$tag" == "$base" ]]; then
    tag=latest
fi

# Run build
do_build "$1" "$2"

# Also push
if [ $push = true ]; then
    do_push "$1" "$tag"
fi
