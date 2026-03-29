FROM ubuntu:22.04

# Set environment variables
ENV APISIX_VERSION=3.2.0
ENV LUA_VERSION=5.1

# Install necessary dependencies
RUN apt-get update -y && \
    apt-get install -y \
    git \
    wget \
    tar \
    luarocks \
    etcd \
    curl \
    libpcre3-dev \
    libssl-dev \
    perl \
    make \
    unzip

RUN apt-get install -y gawk build-essential 
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y zlib1g zlib1g-dev
RUN apt-get install -y sudo

# Install APISIX using Luarocks
#RUN luarocks install --lua-version=${LUA_VERSION} https://github.com/apache/apisix/archive/apisix-${APISIX_VERSION}.tar.gz

# Set up etcd (required by APISIX for storing configuration)
RUN apt-get install -y etcd

# Copy APISIX configuration files (you may create them locally)
COPY conf /usr/local/apisix/conf

# Expose necessary ports
EXPOSE 9080 9443
WORKDIR /usr/src/app
# Run APISIX (modify the entrypoint as per your need)
#ENTRYPOINT ["apisix", "start"]
