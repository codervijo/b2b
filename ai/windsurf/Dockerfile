# Start with Debian 12 (compatible base)
FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    libgtk-3-0 \
    libx11-6 \
    libxext6 \
    libxss1 \
    libnss3 \
    libasound2 \
    libxkbfile1 \
    libsecret-1-0 \
    libgbm1 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Add this line to your existing apt install block
RUN apt-get update && apt-get install -y \
    x11-apps \
    # (your other packages)
    && rm -rf /var/lib/apt/lists/*

# Add Windsurf GPG key and repo
RUN curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" \
      | gpg --dearmor -o /usr/share/keyrings/windsurf-archive-keyring.gpg && \
    echo \
      "deb [signed-by=/usr/share/keyrings/windsurf-archive-keyring.gpg arch=amd64] \
      https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" \
      > /etc/apt/sources.list.d/windsurf.list

# Install Windsurf
RUN apt-get update && apt-get install -y windsurf && \
    rm -rf /var/lib/apt/lists/*


# Create a non-root user for running GUI apps
RUN useradd -m developer
USER developer
ENV HOME=/home/developer
RUN echo 'export DISPLAY=:0' >> /home/developer/.bashrc
WORKDIR $HOME

# Entry point to launch Windsurf
CMD ["windsurf", "--no-sandbox"]
