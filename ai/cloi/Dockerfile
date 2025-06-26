FROM ubuntu:22.04

# Set noninteractive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install core tools
RUN apt-get update && apt-get install -y \
  curl \
  git \
  ca-certificates \
  build-essential \
  openssl \
  wget \
  libssl-dev \
  bash \
  && rm -rf /var/lib/apt/lists/*

# Install Volta (manages Node, pnpm, etc.)
ENV VOLTA_HOME="/root/.volta"
ENV PATH="$VOLTA_HOME/bin:$PATH"

RUN curl https://get.volta.sh | bash

# Install Node.js (22.x), pnpm, and vite using Volta
RUN bash -c "source ~/.bashrc && \
    volta install node@22 && \
    volta install pnpm && \
    volta install vite"

# Create app directory
WORKDIR /app

# Copy package manager files first to install deps before code changes
#COPY package.json pnpm-lock.yaml* ./

# Install dependencies
#RUN pnpm install

# Copy the rest of the app
COPY . .
# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl

# Optional: symlink 'python' to 'python3' and 'pip' to 'pip3'
RUN command -v python >/dev/null 2>&1 || ln -s /usr/bin/python3 /usr/bin/python && \
    command -v pip >/dev/null 2>&1 || ln -s /usr/bin/pip3 /usr/bin/pip

# Install Ollama CLI
RUN curl -fsSL https://ollama.com/install.sh | sh

# (Optional) Preload a model if desired, e.g. phi-4
#RUN ollama pull phi

# Expose port for vite dev server
#EXPOSE 5173

# Start vite dev server (can be overridden in docker-compose or CLI)
#CMD ["pnpm", "dev"]
# Remove this from Dockerfile:
# RUN ollama pull phi

# Add at runtime in entrypoint or CMD script:
#CMD ollama serve & sleep 2 && ollama pull phi && pnpm dev

# https://github.com/gabrielchasukjin/cloi
