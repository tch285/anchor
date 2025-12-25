FROM ubuntu:22.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

# ARG ROOT_BIN=root_v6.32.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz
ARG SHERPA_VER=3.0.3
ARG SHERPA_BR=3-0-x
ARG OPENLOOPS_VER=OpenLoops-2.1.5
ARG PYTHIA_VER=8315
ARG HEPMC_VER=3.2.6
ARG WORKDIR=/opt

WORKDIR ${WORKDIR}

COPY packages ./

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install --no-install-recommends $(cat packages) \
 && rm -rf /var/lib/apt/lists/* \
 && wget https://gitlab.com/openloops/OpenLoops/-/archive/${OPENLOOPS_VER}/OpenLoops-${OPENLOOPS_VER}.tar.gz \
 && tar zxvf OpenLoops-${OPENLOOPS_VER}.tar.gz \
 && rm OpenLoops-${OPENLOOPS_VER}.tar.gz \
 && mv OpenLoops-${OPENLOOPS_VER} OpenLoops \
 && cd OpenLoops \
 && ./scons \
 && ./openloops libinstall ppjj ppjjj compile_extra=1 -j3 \
 && cd ${WORKDIR}  \
 && wget http://hepmc.web.cern.ch/hepmc/releases/HepMC3-${HEPMC_VER}.tar.gz \
 && tar -xzf HepMC3-${HEPMC_VER}.tar.gz \
 && rm HepMC3-${HEPMC_VER}.tar.gz \
 && cd HepMC3-${HEPMC_VER} \
 && mkdir hepmc3-build \
 && cd hepmc3-build \
 && cmake -DCMAKE_INSTALL_PREFIX=${WORKDIR}/HepMC3   \
       -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF            \
       -DHEPMC3_ENABLE_PROTOBUFIO:BOOL=OFF        \
       -DHEPMC3_ENABLE_TEST:BOOL=OFF              \
       -DHEPMC3_INSTALL_INTERFACES:BOOL=OFF        \
       -DHEPMC3_BUILD_STATIC_LIBS:BOOL=OFF        \
       -DHEPMC3_BUILD_DOCS:BOOL=OFF     \
       -DHEPMC3_ENABLE_PYTHON:BOOL=OFF   \
       -B . -S .. \
 && make \
 && make install \
 && cd ${WORKDIR} \
 && rm -rf HepMC3-${HEPMC_VER} \
 && wget https://pythia.org/download/pythia83/pythia${PYTHIA_VER}.tgz \
 && tar xvfz pythia${PYTHIA_VER}.tgz \
 && rm pythia${PYTHIA_VER}.tgz \
 && cd pythia${PYTHIA_VER} \
 && ./configure --prefix=${WORKDIR}/pythia8\
 && gmake -j20 \
 && gmake install \
 && cd ${WORKDIR} \
 && rm -rf pythia${PYTHIA_VER} \
#  && git clone --single-branch -b rel-${SHERPA_BR} https://gitlab.com/sherpa-team/sherpa.git \
 && wget https://gitlab.com/sherpa-team/sherpa/-/archive/v${SHERPA_VER}/sherpa-v${SHERPA_VER}.tar.gz \
 && tar xvzf sherpa-v${SHERPA_VER}.tar.gz && rm sherpa-v${SHERPA_VER}.tar.gz && mv sherpa-v${SHERPA_VER} sherpa\
 && cd sherpa \
 && mkdir sherpa-build \
 && cd sherpa-build \
 && cmake -LA -S .. -B . \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DSHERPA_ENABLE_INSTALL_LHAPDF=ON \
          -DSHERPA_ENABLE_GZIP=ON \
          -DOPENLOOPS_DIR=${WORKDIR}/OpenLoops \
          -DHepMC3_DIR=${WORKDIR}/HepMC3 \
          -DPYTHIA8_DIR=${WORKDIR}/pythia8 \
 && cmake --build . -j 20 \
 && cmake --install . \
 && cd ${WORKDIR} \
 && rm -rf sherpa

COPY ahadic /opt/files/ahadic
COPY lund /opt/files/lund