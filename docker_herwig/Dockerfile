FROM ubuntu:22.04

WORKDIR /opt/herwig73
ENV VIRTUAL_ENV=/opt/.venv
ENV PATH=${VIRTUAL_ENV}/bin:$PATH

COPY packages packages

RUN apt-get update -qq \
 && apt-get -y install $(cat packages) \
 && python3 -m venv ${VIRTUAL_ENV} \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir --upgrade pip \
 && ${VIRTUAL_ENV}/bin/pip install Cython six \
 && rm -rf /var/lib/apt/lists/* \
 && wget https://herwig.hepforge.org/downloads/herwig-bootstrap \
 && chmod +x herwig-bootstrap \
 && ./herwig-bootstrap -j 4 .