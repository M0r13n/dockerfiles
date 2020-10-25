# Dockerfiles

This is a list of useful dockerfiles.

## Build

You either build all images or build images individually.

### Single

This will build a single image:

``` sh
./build <TARGET> [OPTIONAL: version]
```

Example

``` sh
./build.sh shellcheck stable

# or

$ ./build.sh cpp_boost 1.73.0

```

You can also pass the optional `-p` parameter. If provided, the newly built image will be pushed toa repo defined in the REPO_URL var.

```sh
./build.sh -p shellcheck stable
```

### All

This command will build all images and try to push them to a repo defined in the REPO_URL var.

``` sh
./build_all.sh
```
