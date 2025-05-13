FROM debian:stable

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    bash \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean

# Create and activate a virtual environment, install aider
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install aider-chat

# Make venv Python and pip globally available (optional)
ENV PATH="/opt/venv/bin:$PATH"

RUN curl -LsSf https://aider.chat/install.sh | sh
RUN python3 -m pip install pipx  # If you need to install pipx
RUN pipx install aider-chat

# Set up app directory
WORKDIR /usr/src/app

