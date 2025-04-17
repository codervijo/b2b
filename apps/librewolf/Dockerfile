FROM debian:stable

# Set up environment variables for pnpm global installs
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

# Install system dependencies and FUSE for .deb install
RUN apt-get update && \
    apt-get install -y git curl wget gnupg2 ca-certificates \
    libxss1 libgconf-2-4 libnss3 libasound2 libx11-xcb1 libxcomposite1 \
    libxrandr2 libgtk-3-0 gdebi-core

RUN apt update && apt install extrepo -y
RUN extrepo enable librewolf
RUN apt update && apt install librewolf -y

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
