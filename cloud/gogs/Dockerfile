FROM ubuntu:22.04

# Set Go version
ENV GO_VERSION=1.24.0

# Install system dependencies and Rust toolchain
RUN apt-get update && apt-get install -y \
  librocksdb-dev \
  libleveldb-dev \
  libsnappy-dev \
  zlib1g-dev \
  libsqlite3-dev \
  pkg-config \
  build-essential \
  curl \
  ca-certificates \
  clang \
  llvm-dev \
  libclang-dev \
  git

# Install Go
RUN curl -OL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  rm go${GO_VERSION}.linux-amd64.tar.gz

# Add Go to PATH
ENV PATH="/usr/local/go/bin:${PATH}"
# Disable toolchain download attempts
ENV GOTOOLCHAIN=local

WORKDIR /app

RUN git clone --depth 1 https://github.com/gogs/gogs.git gogs
WORKDIR /app/gogs
RUN go build -o gogs && cp gogs /usr/local/bin/
#RUN make install

WORKDIR /usr/src/app 

# Verify Go installation
RUN go version
