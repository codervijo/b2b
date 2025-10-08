# Use Ubuntu as the base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies, browser dependencies, and Python
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    locales \
    python3 \
    python3-pip \
    python3-venv

# (Removed unnecessary gstreamer and media packages)

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install uv (latest version from GitHub releases)
RUN curl -sSL https://astral.sh/uv/install.sh | bash && cp /root/.local/bin/uv /usr/local/bin

# Add uv to PATH (assumes default install path ~/.cargo/bin/uv)
ENV PATH="/root/.local/bin:$PATH"

# Install Ansible using uv
RUN uv pip install ansible

# Set working directory for your app
WORKDIR /usr/src/app

# (Optional) Clean up apt cache to reduce image size
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Default command
CMD ["pnpm", "test"]
