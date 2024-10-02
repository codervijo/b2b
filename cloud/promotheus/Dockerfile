# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PROMETHEUS_VERSION=2.47.0

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    gzip && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for Prometheus
RUN mkdir /prometheus

# Download and extract Prometheus
RUN wget -q https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar -xzf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz --strip-components=1 -C /prometheus && \
    rm prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Set the environment variable for Prometheus
ENV PROMETHEUS_HOME=/prometheus

# Expose Prometheus port
EXPOSE 9090

# Copy the Prometheus configuration file (if any)
# COPY prometheus.yml /prometheus/prometheus.yml

# Set the working directory
WORKDIR /prometheus

# Command to run Prometheus
CMD ["./prometheus", "--config.file=./prometheus.yml"]
