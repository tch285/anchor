FROM ubuntu:24.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.32.04.Linux-ubuntu24.04-x86_64-gcc13.2.tar.gz

WORKDIR /opt

COPY packages packages

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat packages) wget\
 && rm -rf /var/lib/apt/lists/*\
 && wget https://root.cern/download/${ROOT_BIN} \
 && tar -xzvf ${ROOT_BIN} \
 && rm -f ${ROOT_BIN} \
 && echo /opt/root/lib >> /etc/ld.so.conf \
 && ldconfig
RUN yes | unminimize

ENV ROOTSYS=/opt/root
ENV PATH=$ROOTSYS/bin:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH=none

# CMD ["root", "-b"]

RUN git clone --depth 1 --branch 3.0.5 https://gitlab.cern.ch/RooUnfold/RooUnfold.git \
 && cd RooUnfold \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j4 \
 && cd .. \
 && apt-get -y install python3-venv python3-pip \
 && rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/rooenv \
 && . rooenv/bin/activate \
 && pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir uproot tqdm pyyaml

ENV PATH=/opt/rooenv/bin:/opt/RooUnfold/build:$PATH
ENV PYTHONPATH=/opt/RooUnfold/build:$PYTHONPATH
ENV LD_LIBRARY_PATH=/opt/RooUnfold/build:$LD_LIBRARY_PATH
