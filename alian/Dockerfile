FROM ubuntu:22.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

WORKDIR /opt

COPY packages env.sh ./

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install --no-install-recommends $(cat packages) wget \
 && rm -rf /var/lib/apt/lists/* \
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

 RUN . /etc/profile.d/z00_lmod.sh \
 && git clone --depth 1 --branch root-option --single-branch https://github.com/tch285/yasp.git \
 && ./yasp/yaspenv.sh \
 "python3 -m pip install --no-cache-dir numpy tqdm pyyaml \
 && yasp -mi bundle/hepbase --yasp-define n_cores=2\
 && module use yasp/software/modules \
 && module load yasp bundle/hepbase\
 && git clone --depth 1 --branch main --single-branch https://github.com/matplo/heppyy.git \
 && ./heppyy/install_with_yasp.sh"
ADD https://api.github.com/repos/tch285/alian/git/refs/heads/geec latest_commit
RUN ./yasp/yaspenv.sh \
  ". /opt/env.sh \
  && git clone --depth 1 --branch geec --single-branch https://github.com/tch285/alian.git \
  && ./alian/install_with_yasp.sh"
