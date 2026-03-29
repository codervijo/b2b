FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  curl \
  git \
  ca-certificates \
  build-essential \
  bash \
  && rm -rf /var/lib/apt/lists/*

# Install Volta for Node.js management
ENV VOLTA_HOME="/root/.volta"
ENV PATH="$VOLTA_HOME/bin:$PATH"

RUN curl https://get.volta.sh | bash

# Install Node.js LTS
RUN bash -c "source ~/.bashrc && volta install node@lts"

# Install codex CLI globally
RUN bash -c "source ~/.bashrc && npm install -g @openai/codex"

WORKDIR /workspace
