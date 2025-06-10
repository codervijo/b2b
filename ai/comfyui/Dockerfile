FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    NODE_VERSION=18.20.2 \
    PNPM_HOME="/root/.local/share/pnpm"

# Install all needed system tools and languages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    build-essential \
    gnupg \
    ffmpeg \
    libgl1 \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create app directory as root and clone ComfyUI
WORKDIR /usr/src/app
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Create a non-root user
RUN useradd -ms /bin/bash comfy

# Switch to comfy user
USER comfy
WORKDIR /usr/src/app/ComfyUI
RUN pip3 install --upgrade pip && \
    pip3 install --user -r requirements.txt
WORKDIR /home/comfy

# Set working directory to symlinked ComfyUI
WORKDIR /home/comfy/ComfyUI

# Expose port
EXPOSE 8188

# Run ComfyUI
CMD ["python3", "main.py", "--listen", "0.0.0.0"]
