FROM ubuntu:22.04

WORKDIR /opt/
ENV VIRTUAL_ENV=/opt/.venv
ENV PATH=${VIRTUAL_ENV}/bin:$PATH
ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.32.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

COPY packages packages

RUN apt-get update -qq \
&& ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat packages) wget \
 && python3 -m venv ${VIRTUAL_ENV} \
 && . ${VIRTUAL_ENV}/bin/activate \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir --upgrade pip \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir numpy==1.26.3 pyhepmc_ng pyyaml tqdm \
 && wget https://root.cern/download/${ROOT_BIN} \
 && tar -xzvf ${ROOT_BIN} \
 && rm -f ${ROOT_BIN} \
 && echo /opt/root/lib >> /etc/ld.so.conf \
 && ldconfig \
 && rm -rf /var/lib/apt/lists/*

ENV ROOTSYS=/opt/root
ENV PATH=$ROOTSYS/bin:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH=none