FROM rust:1.72-slim-bullseye

# Install required packages for build and curl
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libssl-dev \
    ca-certificates \
    curl \
    psutils \
    procps \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/stalwart

# Download the official Stalwart install script
RUN curl --proto '=https' --tlsv1.2 -sSf https://get.stalw.art/install.sh -o install.sh

# Make script executable and run it
RUN chmod +x install.sh && ./install.sh

# The install script builds and installs the binary to /usr/local/bin
# For consistency, create a symlink to /usr/bin if you want
RUN ln -sf /usr/local/bin/stalwart-mail /usr/bin/stalwart-mail

# Copy config files (optional)
COPY config ./config
COPY users.toml ./config/users.toml

# Set environment variables
ENV STALWART_LOG_LEVEL=info
ENV STALWART_UI_ENABLED=true

# Expose mail service ports
EXPOSE 25 143 587 993 4190

# Run the installed binary on container start
CMD ["/usr/bin/stalwart-mail"]

