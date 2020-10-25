#!/bin/bash
set -e
set -o pipefail

REPO_URL="${REPO_URL:-leonmortenrichter.jfrog.io/docker-local}"

build_and_push() {
    base=$1
    tag=$2
    build_dir=$3

    # Build image
    echo "Building $REPO_URL/$base:$tag in $build_dir."
    docker build --rm --force-rm -t "${REPO_URL}/${base}:${tag}" "${build_dir}" || return 1

    # If build was successful: push
    echo "+------------------------------------------------------+"
    echo "Successfully built ${base}:${tag}"
    echo "+------------------------------------------------------+"

    n=0
    until [ $n -ge 5 ]; do
        docker push --disable-content-trust=true "${REPO_URL}/${base}:${tag}" && break
        echo "Try #$n failed... sleeping for 15 seconds"
        n=$((n + 1))
        sleep 15
    done

    # If build was successful: push
    echo "+------------------------------------------------------+"
    echo "Successfully pushed ${base}:${tag}"
    echo "+------------------------------------------------------+"
}

do_build() {
    # Extract important information such as name, tag and build_dir
    file="$1"
    image=${file%Dockerfile}
    base=${image%%\/*}
    build_dir=$(dirname "$file")
    tag=${build_dir##*\/}

    if [[ -z "$tag" ]] || [[ "$tag" == "$base" ]]; then
        tag=latest
    fi

    build_and_push "${base}" "${tag}" "${build_dir}"
}

main() {
    # get the dockerfiles
    local files
    mapfile -t files < <(find -L . -iname '*Dockerfile' | sed 's|./||' | sort)

    for f in "${files[@]}"; do
        do_build "$f"
    done

}

main "$@"
