FROM ubuntu:22.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.36.00.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

WORKDIR /opt

COPY packages requirements.txt /opt/apps/

ENV VIRTUAL_ENV=/opt/.venv
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
 && cd .. \
 && echo "3.0.5" > /opt/apps/RooUnfold/build/version.txt \
 && wget https://sourceforge.net/projects/lmod/files/lua-5.1.4.9.tar.bz2 \
 && tar xf lua-5.1.4.9.tar.bz2 \
 && rm -f lua-5.1.4.9.tar.bz2 \
 && cd lua-5.1.4.9 \
 && ./configure --prefix=/opt/apps/lua/5.1.4.9 \
 && make && make install \
 && cd /opt/apps/lua; ln -s 5.1.4.9 lua \
 && ln -s /opt/apps/lua/lua/bin/lua /usr/local/bin \
 && ln -s /opt/apps/lua/lua/bin/luac /usr/local/bin \
 && cd /opt/apps \
 && wget https://sourceforge.net/projects/lmod/files/Lmod-8.7.tar.bz2 \
 && tar xfvj Lmod-8.7.tar.bz2 \
 && rm -f Lmod-8.7.tar.bz2 \
 && cd Lmod-8.7 \
 && ./configure --prefix=/opt/apps \
 && make install \
 && ln -s /opt/apps/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh

RUN git clone --depth 1 --branch docker --single-branch https://github.com/tch285/heppy.git \
 # && ./heppy/external/roounfold/build.sh \
 && ./heppy/external/fastjet/build.sh \
 && ./heppy/external/lhapdf6/build.sh \
 && ./heppy/external/hepmc2/build.sh \
 && ./heppy/external/hepmc3/build.sh \
 && ./heppy/external/pythia8/build.sh \
 && ./heppy/cpptools/build.sh
ADD https://api.github.com/repos/tch285/pyjetty/git/refs/heads/ceec latest_commit
RUN . /etc/profile.d/z00_lmod.sh \
 && module use /opt/heppy/modules \
 && module load heppy \
 && git clone --depth 1 --branch ceec --single-branch https://github.com/tch285/pyjetty.git \
 && ./pyjetty/cpptools/build.sh --tenngen --tglaubermc
COPY entrypoint.sh /opt
ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "/bin/bash", "-i"]