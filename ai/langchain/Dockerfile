# Use an official Python image as base
FROM python:3.12-slim as base

# Set environment variables
ENV POETRY_VERSION=1.8.2 \
    POETRY_VIRTUALENVS_CREATE=false \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl build-essential git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set working directory
WORKDIR /app

# Copy project files (adjust if using different layout)
COPY pyproject.toml poetry.lock* ./

# Install Python dependencies
RUN poetry install --no-interaction --no-ansi

# Copy the rest of the app
COPY . .

# Expose port (if using a web server or FastAPI, for example)
EXPOSE 8000

# Default command (adjust if needed)
CMD ["python", "main.py"]
