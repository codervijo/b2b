FROM node:20-slim

# Set up environment variables for pnpm global installs
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

# Install system dependencies and FUSE for .deb install
RUN apt-get update && \
    apt-get install -y git curl wget gnupg2 ca-certificates \
    libxss1 libgconf-2-4 libnss3 libasound2 libx11-xcb1 libxcomposite1 \
    libxrandr2 libgtk-3-0 gdebi-core

# Enable and install pnpm
RUN corepack enable && \
    corepack prepare pnpm@latest --activate

# Ensure PNPM_HOME exists and is in PATH
RUN mkdir -p $PNPM_HOME

# Install Bruno CLI globally
RUN pnpm add -g @usebruno/cli

# Download and install Bruno .deb (v2.1.0)
RUN curl -L -o /tmp/bruno.deb https://github.com/usebruno/bruno/releases/download/v2.1.0/bruno_2.1.0_amd64_linux.deb && \
    gdebi -n /tmp/bruno.deb && \
    rm /tmp/bruno.deb

# Set working directory
WORKDIR /app

# Copy source files
COPY . .

# Optionally install project dependencies
# RUN pnpm install

# Alias Bruno for convenience
RUN echo "alias bruno='bruno --no-sandbox'" >> /root/.bashrc

# Expose Vite port
EXPOSE 5173

# Default command
CMD ["pnpm", "dev"]

RUN echo "alias bruno='/opt/bruno/bruno --no-sandbox'" >> /root/.bashrc

# Expose Vite port
EXPOSE 5173

# Default command
CMD ["pnpm", "dev"]
