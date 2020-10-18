# We use Ubuntu 20.04
FROM ubuntu:focal

LABEL MAINTAINER="me@leonmortenrichter.de"
LABEL DESCRIPTION="Run shellcheck.sh inside a docker container."


# Install necessary software
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y xz-utils wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*;

# Set Version to stable. Could also be "latest" or "v0.4.7"
ENV SCVERSION="stable"

# Download file from server and extract it's contents
RUN wget --max-redirect 3 "https://github.com/koalaman/shellcheck/releases/download/${SCVERSION?}/shellcheck-${SCVERSION?}.linux.x86_64.tar.xz" \
    && tar -xvf "./shellcheck-${SCVERSION?}.linux.x86_64.tar.xz"

# Place the shellcheck executable inside the usr/bin directory
RUN cp "shellcheck-${SCVERSION}/shellcheck" /usr/bin/


ENTRYPOINT ["/bin/bash"]