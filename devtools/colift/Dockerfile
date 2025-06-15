FROM ubuntu:22.04

ENV GOVERSION=1.24.0

RUN apt-get update && apt-get install -y \
    git graphviz autoconf-archive vim \
    cscope gdb \
    splint valgrind \
    python3-pip \
    curl ca-certificates wget

# Remove old Go versions
RUN apt-get remove -y golang* && apt-get autoremove -y

# Install Go from official binary
RUN wget https://go.dev/dl/go${GOVERSION}.linux-amd64.tar.gz -O /tmp/go.tgz && \
    tar -C /usr/local -xzf /tmp/go.tgz && \
    rm /tmp/go.tgz

ENV GOROOT=/usr/local/go
ENV PATH=${GOROOT}/bin:$PATH

RUN go version

WORKDIR /usr/src/app