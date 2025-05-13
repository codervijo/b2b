FROM ubuntu:22.04

# Set noninteractive mode to avoid tzdata prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    lsb-release \
    software-properties-common

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Expose Ollama's default API port
EXPOSE 11434

# Start the Ollama server
CMD ["ollama", "serve"]
