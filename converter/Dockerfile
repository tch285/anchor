FROM almalinux/9-base:9.5-20250519
# FROM gitlab-registry.cern.ch/linuxsupport/alma9-base

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.36.00.Linux-almalinux9.5-x86_64-gcc11.5.tar.gz

WORKDIR /opt

COPY packages_req packages_opt ./

RUN dnf update -y \
 && dnf install -y epel-release \
 && dnf config-manager --set-enabled crb \
 && dnf install -y $(cat packages_req) $(cat packages_opt) wget \
 && wget https://root.cern/download/${ROOT_BIN} \
 && tar -xzvf ${ROOT_BIN} \
 && rm -f ${ROOT_BIN} \
 && echo /opt/root/lib >> /etc/ld.so.conf \
 && ldconfig \
 && dnf clean all \
 && rm -rf /var/cache/yum

ENV ROOTSYS=/opt/root
ENV PATH=$ROOTSYS/bin:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH=none

ADD https://api.github.com/repos/KirillVNaumov/AO2DToBerkeleyTreeConverter/git/refs/heads/master latest_commit
RUN git clone --depth 1 --branch master --single-branch https://github.com/KirillVNaumov/AO2DToBerkeleyTreeConverter.git \
 && cd AO2DToBerkeleyTreeConverter \
 && make BUILD=debug