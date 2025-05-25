# Use Ubuntu as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    libnss3 \
    libatk-bridge2.0-0 \
    libxss1 \
    libasound2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libgbm-dev \
    libgtk-3-0 \
    fonts-liberation \
    xdg-utils \
    libu2f-udev \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js and pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    corepack enable && corepack prepare pnpm@latest --activate

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and pnpm-lock.yaml
COPY package.json ./

# Copy remaining app files
COPY . .

RUN SHELL=/bin/bash pnpm setup
ENV PATH="$(pnpm bin -g):$PATH"

# Install Playwright browsers and dependencies
RUN pnpm install
RUN pnpm exec playwright install --with-deps

# Default command (you can override it at runtime)
CMD ["pnpm", "test"]
