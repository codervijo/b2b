FROM ubuntu:22.04

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

# Install Rust (stable) using rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /opt/stalwart-mail

# Download the official Stalwart install script
RUN curl --proto '=https' --tlsv1.2 -sSf https://get.stalw.art/install.sh -o install.sh

# Make script executable and run it
RUN chmod +x install.sh && ./install.sh

# Create symlink for convenience
RUN ln -sf /usr/local/bin/stalwart-mail /usr/bin/stalwart-mail

# Copy config files (optional)
COPY config ./config
COPY users.toml ./config/users.toml

# Set environment variables
ENV STALWART_LOG_LEVEL=info
ENV STALWART_UI_ENABLED=true

# Expose common mail service ports
EXPOSE 25 143 587 993 4190

# Run the installed binary on container start
CMD ["/usr/bin/stalwart-mail", "--config", "/opt/stalwart-mail/config/config.toml"]
