# Shellcheck inside Docker

Minimal docker image with shellcheck binary installed.

![Successful linting of multiple files](../doc/spellcheck/to/success.png "Example Screen")

## Usage

The image is a minimal Ubuntu image that has only shellcheck installed inside the `/usr/bin/` directory.
Because `/bin/bash` is the entrypoint, you can either pass a command + parameters or pass a complete script.

### Build

In order to build the image run:

```sh
# Uses the stable version
./build.sh

# Uses latest version
./build.sh latest

# Uses custom version
./build.sh "v0.4.7"
```

The above commands would create three (3) images on your local machine:

```sh
$ docker image ls
REPOSITORY                  TAG                 IMAGE ID            CREATED              SIZE
elac/shellcheck             v0.4.7              ff43e2d9541d        58 seconds ago       127MB
elac/shellcheck             latest              3a0dfb6d5063        About a minute ago   102MB
elac/shellcheck             stable              fd5c4735b0d8        2 hours ago          101MB
```

### Run

The simplest way to use this container, would be to just print the current shellcheck version:

```sh
$ docker run --rm -it elac/shellcheck:v0.4.7 "shellcheck --version"
ShellCheck - shell script analysis tool
version: 0.4.7
license: GNU General Public License, version 3
website: http://www.shellcheck.net
```

Now imagine that you want to shellcheck all .sh files in a project. This can easily be done with the following:

```sh
docker run --rm -it \
    -v "$PWD":/mnt:ro \
    --workdir /mnt \
    elac/shellcheck "shellcheck *.sh"
```

But this would only list all **sh-files** inside your current directory. In order to get **all** scripts (+ some nice eye-candy) you can use the `shellcheck.sh` file.
Therefore you only need to start **run.sh**

```sh
./run.sh

   [✘] [ERROR]: found lining error ./build.sh
   [✔] [OK]: successfully linted ./run.sh
   [✔] [OK]: successfully linted ./shellcheck.sh
These files failed shellcheck: ./build.sh
```

This will mount your current dir under `/mnt` as a *readonly volume*. Then it will iterate over all sh files and check them.
