# Start from an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to prevent user interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update -y && \
    apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    ca-certificates \
    openssl \
    libpcre3 \
    libpcre3-dev \
    zlib1g-dev \
    build-essential \
    luarocks

# Install Kong's public signing key and repository
#RUN echo "deb [trusted=yes] https://download.konghq.com/gateway-3.x-ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/kong.list && \
#    curl -fsSL https://download.konghq.com/gateway-3.x-ubuntu/gpg | apt-key add -

# Install Kong
#RUN apt-get update -y && \
#    apt-get install -y kong
RUN apt-get install -y gawk build-essential 
RUN apt-get install -y libpcre3 libpcre3-dev
RUN apt-get install -y zlib1g zlib1g-dev
RUN apt-get install -y sudo git

# Expose ports for Kong (8000, 8443 for HTTP/HTTPS; 8001, 8444 for Admin API HTTP/HTTPS)
EXPOSE 8000 8443 8001 8444
WORKDIR /usr/src/app

# Copy the custom entry script
#COPY dev_container.sh /usr/src/app/dev_container.sh

# Start Kong as the default command
#CMD ["/bin/bash", "/usr/src/app/dev_container.sh"]
