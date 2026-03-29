FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  ca-certificates \
  git \
  gnupg \
  wget \
  libsqlite3-dev \
  zlib1g-dev \
  pkg-config \
  clang \
  llvm-dev \
  libclang-dev \
  libleveldb-dev \
  librocksdb-dev \
  libsnappy-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Install Volta (Node version manager)
# -------------------------------
ENV VOLTA_HOME="/root/.volta"
ENV PATH="$VOLTA_HOME/bin:$PATH"

RUN curl https://get.volta.sh | bash

# Install Node.js and npm via Volta (you can pin versions as needed)
RUN /root/.volta/bin/volta install node@18 npm@latest

# Set working directory
WORKDIR /app

# Default command (override as needed in your Docker Compose or CLI)
CMD [ "node" ]
