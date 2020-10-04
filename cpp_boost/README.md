# Docker with boost
This file sets up Ubuntu 20.04 with Boost installed.
Boost is installed from source, because the latest PPA for boost is most likely some version old.

## General

| Boost Header files | `/usr/include/boost/` |
|------|-------------------|

## Usage

### Build

In order to build the image with Boost version 1.74.0

```sh
.\build-docker.sh 1.74.0
```

### Run

To run  a built image with Boost version 1.74.0

```sh
./run-docker.sh 1.74.0
```

### Launch

You then can connect to the running container and directly launch into the bash:

```sh
docker run -it elac/boost:1.74.0 bash
```
