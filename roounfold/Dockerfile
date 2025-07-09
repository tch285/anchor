FROM ubuntu:24.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.36.02.Linux-ubuntu24.04-x86_64-gcc13.3.tar.gz

WORKDIR /opt

COPY packages requirements.txt /opt/apps/

ENV VIRTUAL_ENV=/opt/env
ENV ROOTSYS=/opt/apps/root
ENV PATH=$ROOTSYS/bin:${VIRTUAL_ENV}/bin:/opt/apps/RooUnfold/build:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:/opt/apps/RooUnfold/build:$PYTHONPATH
ENV LD_LIBRARY_PATH=/opt/apps/RooUnfold/build:$LD_LIBRARY_PATH
ENV CLING_STANDARD_PCH=none

RUN cd /opt/apps \
 && apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install --no-install-recommends $(cat packages) wget\
 && python3 -m venv ${VIRTUAL_ENV} \
 && . ${VIRTUAL_ENV}/bin/activate \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir --upgrade pip \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir -r requirements.txt \
 && rm -rf /var/lib/apt/lists/*\
 && wget https://root.cern/download/${ROOT_BIN} \
 && tar -xzvf ${ROOT_BIN} \
 && rm -f ${ROOT_BIN} \
 && echo /opt/root/lib >> /etc/ld.so.conf \
 && ldconfig \
 && yes | unminimize \
 && git clone --depth 1 --branch 3.0.5 https://gitlab.cern.ch/RooUnfold/RooUnfold.git \
 && cd RooUnfold \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && echo "3.0.5" > /opt/apps/RooUnfold/build/version.txt