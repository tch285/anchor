FROM ubuntu:22.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

# ARG ROOT_BIN=root_v6.32.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz
ARG PYTHIA_VER=8311

WORKDIR /opt

COPY packages ./

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install --no-install-recommends $(cat packages) \
 && rm -rf /var/lib/apt/lists/* \
 && wget https://pythia.org/download/pythia83/pythia${PYTHIA_VER}.tgz \
 && tar xvfz pythia${PYTHIA_VER}.tgz \
 && cd pythia${PYTHIA_VER} \
 && ./configure --with-python \
 && gmake
