FROM ubuntu:22.04

LABEL maintainer.name="Tucker Hwang"
LABEL maintainer.email="tucker_hwang@berkeley.edu"

ENV LANG=C.UTF-8

WORKDIR /opt

COPY packages-22.04 /opt/apps/

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install --no-install-recommends software-properties-common gnupg \
 && add-apt-repository ppa:deadsnakes/ppa \
 && apt-get update -qq \
 && apt-get -y install --no-install-recommends $(cat apps/packages-22.04) wget \
 && rm -rf /var/lib/apt/lists/* \
 && cd /opt/apps \
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

ENTRYPOINT [ "/usr/bin/bash", "-l" ]