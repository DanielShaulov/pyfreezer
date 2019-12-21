FROM ubuntu:18.04

RUN apt-get update && apt get install \
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
    tk8.5-dev

WORKDIR /root
RUN curl -L https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz -o Python-3.8.1.tgz
RUN tar -xf Python-3.8.1.tgz
WORKDIR /root/Python-3.8.1
COPY Setup Modules/Setup
COPY frozenmain.c Python-3.8.1/Python/frozenmain.c
RUN ./configure --enable-optimizations
RUN make
WORKDIR /root
COPY freeze.sh .

ENTRYPOINT ["/root/freeze.sh"]
