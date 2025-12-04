FROM ubuntu:22.04

WORKDIR /opt/herwig
ENV VIRTUAL_ENV=/opt/.venv
ENV PATH=${VIRTUAL_ENV}/bin:$PATH

COPY packages herwig-bootstrap TheP8I.in ./

RUN apt-get update -qq \
 && apt-get -y install $(cat packages) \
 && python3 -m venv ${VIRTUAL_ENV} \
 && ${VIRTUAL_ENV}/bin/pip install --no-cache-dir --upgrade pip \
 && ${VIRTUAL_ENV}/bin/pip install Cython six \
 && rm -rf /var/lib/apt/lists/* \
 #  && wget https://herwig.hepforge.org/downloads/herwig-bootstrap \
#  RUN ls \
  && chmod +x herwig-bootstrap \
  && ./herwig-bootstrap -j 15 .