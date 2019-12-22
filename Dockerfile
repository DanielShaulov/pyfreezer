FROM ubuntu:18.04

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

WORKDIR /root
RUN curl -L https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
RUN tar -xf Python-${VERSION}.tgz
WORKDIR /root/Python-${VERSION}
COPY Setup Modules/Setup
COPY frozenmain.c Python/frozenmain.c
RUN ./configure --enable-optimizations
RUN make -j$(nproc)
WORKDIR /root
COPY freeze.sh .

ENTRYPOINT ["/root/freeze.sh"]
