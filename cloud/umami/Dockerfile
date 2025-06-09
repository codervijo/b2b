FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    NODE_VERSION=18.20.2 \
    PNPM_HOME="/root/.local/share/pnpm"

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git ca-certificates build-essential gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Clone Umami source
RUN git clone https://github.com/umami-software/umami.git 

# Install dependencies and build
#RUN pnpm install && pnpm build

# Default Umami port#
EXPOSE 3000

# Set up the environment variable for PostgreSQL
ENV DATABASE_URL=postgresql://umami:umami@db:5432/umami
COPY umami.env /app/.env

# Start the server with migration
CMD ["pnpm", "start-migration"]


