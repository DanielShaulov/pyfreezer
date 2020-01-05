FROM ubuntu:bionic-20191202

ENV DEBIAN_FRONTEND=noninteractive

ARG VERSION=3.8.1

RUN apt-get update && apt-get install -y \
    build-essential \
    zlib1g-dev \
    libbz2-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libffi-dev \
    uuid-dev \
    tk8.5-dev \
    curl

# Regular compilation of python from sources
RUN curl -L https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
RUN tar -xf Python-${VERSION}.tgz
RUN mv Python-${VERSION} pysrc
RUN cd pysrc && ./configure --enable-optimizations
COPY funcs_to_remove .
RUN cat funcs_to_remove | xargs -I{} sed -i '/have_{} /Id' pysrc/pyconfig.h
COPY frozenmain.c pysrc/Python/frozenmain.c
RUN cd pysrc && make -j$(nproc)
RUN pysrc/python -m ensurepip

# Prepare extensions directory with all objects that usually end up in *.so modules
RUN mkdir ext
RUN find pysrc -type d -name Modules | xargs -i{} bash -c "cp -r {}/* ext/"
COPY Setup ext/Setup

COPY overrides.c .
COPY freeze.sh .

ENTRYPOINT ["/freeze.sh"]
