FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  ca-certificates \
  build-essential \
  openssl \
  && rm -rf /var/lib/apt/lists/*

# Install Volta (Node & pnpm will be managed via package.json)
ENV VOLTA_HOME=/root/.volta
ENV PATH=$VOLTA_HOME/bin:$PATH
RUN curl https://get.volta.sh | bash

# Use Volta for Node + pnpm install (versions will be picked from package.json)
SHELL ["/bin/bash", "-c"]
RUN source ~/.bashrc && \
    volta install node && \
    volta install pnpm

# Set working directory
WORKDIR /app

# Clone HeyForm repo
RUN git clone https://github.com/heyform/heyform.git .

# Install dependencies using pnpm
RUN pnpm install

# Build frontend and backend (includes Vite for frontend)
RUN pnpm build

# Set environment variables (override in production)
ENV APP_HOMEPAGE_URL=http://localhost:8000 \
    SESSION_KEY=devsessionkey1234567890 \
    FORM_ENCRYPTION_KEY=devformkey1234567890123456789012345678 \
    MONGO_URI=mongodb://localhost:27017/heyform \
    REDIS_HOST=localhost \
    REDIS_PORT=6379

EXPOSE 8000

WORKDIR /app/packages/server

# Run the backend
CMD ["pnpm", "start"]
