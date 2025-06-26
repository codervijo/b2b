FROM debian:bullseye-slim

# Install system packages
RUN apt-get update && \
    apt-get install -y \
        build-essential curl git python3-pip \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev \
        libxmlsec1-dev libffi-dev liblzma-dev ca-certificates

# ------------------------------
# Install Volta and Node.js 22.x
# ------------------------------
ENV VOLTA_HOME="/root/.volta"
ENV PATH="$VOLTA_HOME/bin:$PATH"

RUN curl https://get.volta.sh | bash && \
    /root/.volta/bin/volta install node@22 && \
    ln -s /root/.volta/bin/node /usr/local/bin/node && \
    ln -s /root/.volta/bin/npm /usr/local/bin/npm && \
    ln -s /root/.volta/bin/corepack /usr/local/bin/corepack

# ------------------------------
# Install pyenv and Python 3.12.3
# ------------------------------
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

RUN curl https://pyenv.run | bash && \
    bash -c "export PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH && \
        eval \"\$(pyenv init --path)\" && \
        eval \"\$(pyenv init -)\" && \
        pyenv install 3.12.3 && \
        pyenv global 3.12.3 && \
        ln -s \$(pyenv which python3) /usr/local/bin/python && \
        ln -s \$(pyenv which pip3) /usr/local/bin/pip"

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Install Bun (for openhands-ui)
RUN apt-get install -y unzip
RUN curl -fsSL https://bun.sh/install | bash && \
    ln -s /root/.bun/bin/bun /usr/local/bin/bun

# Clone repo and enter it
WORKDIR /app
RUN git clone https://github.com/OpenDevin/OpenDevin.git .

# Install Python dependencies (in /app)
RUN poetry config virtualenvs.create false && \
    poetry install --only main --no-root

# Install Docker CLI (client only)
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli git

RUN mkdir -p /root/.cache/pypoetry/virtualenvs
RUN touch /root/.cache/pypoetry/virtualenvs/envs.toml
RUN apt-get update && apt-get install -y netcat

CMD ["tail", "-f", "/dev/null"]
