# Millie runtime image (ADR-0005 — Docker-only, no host Python).
# Base mirrors ../../builder/Dockerfile.python so the central `make buildsh`
# dev-container flow and the `bin/millie` launcher share one runtime shape.
FROM python:3.12-slim

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        git curl make bash ca-certificates procps && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN pip install --no-cache-dir uv

# Bake dependencies (incl. dev extras) into system Python so ephemeral
# `bin/millie` runs need zero runtime resolve. Source is bind-mounted at
# /usr/src/app/src and resolved via PYTHONPATH, so code edits need no rebuild;
# only a pyproject.toml change requires one.
# uv.lock is committed on purpose and copied here, so image builds resolve to
# the same versions the operator tested against.
WORKDIR /opt/millie-build
COPY pyproject.toml uv.lock ./
RUN uv pip install --system -r pyproject.toml --extra dev

# Resolve `millie` from the bind-mounted src/ at runtime (no install, no venv).
ENV PYTHONPATH=/usr/src/app/src
# Stop `-m` prepending CWD to sys.path.
ENV PYTHONSAFEPATH=1
# The repo mounts read-only; keep every tool's scratch state off it.
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPYCACHEPREFIX=/tmp/pycache
ENV RUFF_CACHE_DIR=/tmp/ruff
ENV MYPY_CACHE_DIR=/tmp/mypy
ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app

CMD ["bash"]
