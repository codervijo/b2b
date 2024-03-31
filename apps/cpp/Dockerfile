FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y  python3 build-essential python-pip

RUN apt-get install -y \
    make \
    automake \
    autotools-dev \
    libedit-dev \
    libjemalloc-dev \
    libncurses-dev \
    libpcre2-dev \
    libtool \
    pkg-config \
    python3-docutils \
    python3-sphinx \
    cpio

RUN apt-get install -y git graphviz autoconf-archive vim
RUN apt-get install -y cscope gdb
RUN apt-get install -y splint valgrind