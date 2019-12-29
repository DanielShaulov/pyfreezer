FROM centos:6

ARG VERSION=3.8.1

RUN yum update -y --skip-broken && yum install -y \
    yum-utils curl \
    https://repo.ius.io/ius-release-el6.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && yum-builddep -y python36u

# Regular compilation of python from sources
RUN curl -L https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
RUN tar -xf Python-${VERSION}.tgz
COPY frozenmain.c Python-${VERSION}/Python/frozenmain.c
RUN cd Python-${VERSION} && ./configure --enable-optimizations
RUN cd Python-${VERSION} && make -j$(nproc)
RUN Python-${VERSION}/python -m ensurepip

# Prepare extensions directory with all objects that usually end up in *.so modules
RUN mkdir ext
RUN find Python-${VERSION} -type d -name Modules | xargs -i{} bash -c "cp -r {}/* ext/"
COPY Setup ext/Setup

COPY freeze.sh .

ENTRYPOINT ["/freeze.sh"]
