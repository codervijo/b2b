FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    gzip && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y build-essential git

WORKDIR /usr/src/app
#RUN git clone git@github.com:apache/guacamole-server.git
#RUN git clone git@github.com:apache/guacamole-client.git

# Command to run Prometheus
#CMD ["./prometheus", "--config.file=./prometheus.yml"]
