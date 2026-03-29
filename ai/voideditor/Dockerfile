# Use Node.js 20 on Debian Bullseye
FROM node:20-bullseye AS builder

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential g++ libx11-dev libxkbfile-dev \
    libsecret-1-dev libkrb5-dev python-is-python3 git curl pkg-config && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory and clone
WORKDIR /workspace
RUN git clone https://github.com/voideditor/void.git .

# Install global build tools
RUN npm install -g node-gyp

# Install dependencies (plain install first, before electron native rebuild)
RUN npm ci

# Build React components using root script (tools are in root node_modules)
RUN npm run buildreact

# Now set electron native module build env and rebuild native deps
ENV npm_config_runtime=electron
ENV npm_config_target=34.3.2
ENV npm_config_disturl=https://electronjs.org/headers

RUN npm rebuild

# Build the app — outputs to /VSCode-linux-x64/ (parent of source dir)
RUN npm run gulp vscode-linux-x64

# Runtime stage
FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgtk-3-0 libx11-6 libxkbfile1 libsecret-1-0 libkrb5-3 \
    libasound2 libxss1 libxtst6 libnss3 libgbm1 \
    libxrandr2 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    libdrm2 libxcomposite1 libxdamage1 libxfixes3 libxext6 \
    libx11-xcb1 libxcb-dri3-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/void
COPY --from=builder /VSCode-linux-x64/ /opt/void/

# Create a non-root user and fix chrome-sandbox permissions
RUN useradd -m voiduser && \
    chown -R voiduser:voiduser /opt/void && \
    chown root:root /opt/void/chrome-sandbox && \
    chmod 4755 /opt/void/chrome-sandbox

USER voiduser

ENTRYPOINT ["./void", "--no-sandbox"]
