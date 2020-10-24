# We use Ubuntu 20.04
FROM ubuntu:focal

LABEL MAINTAINER="me@leonmortenrichter.de"
LABEL DESCRIPTION="C++ Build env with Boost libs available"

WORKDIR /usr/include/

# We pass the boost version argument as an argument
ARG BOOST_VERSION
ARG BOOST_VERSION_ESCAPED
ENV BOOST_VERSION=${BOOST_VERSION:-1.74.0}
ENV BOOST_VERSION_ESCAPED=${BOOST_VERSION_ESCAPED:-1_74_0}
ENV BOOST_ROOT=/usr/include/boost

# Install necessary software
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y git wget build-essential wget libbz2-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Place boost headers in  /usr/include/boost
RUN wget --max-redirect 3 https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_ESCAPED}.tar.gz
RUN mkdir -p /usr/include/boost \
    && tar zxf boost_${BOOST_VERSION_ESCAPED}.tar.gz -C /usr/include/boost --strip-components=1 \
    && cd ${BOOST_ROOT} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=shared runtime-link=shared install \
    && ldconfig



ENTRYPOINT /bin/bash