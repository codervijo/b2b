# Base image
FROM debian:stable

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && \
    apt install -y curl git docker.io docker-compose sudo gnupg2 && \
    apt clean

# Set up workdir
WORKDIR /opt

# Clone mailcow
RUN git clone https://github.com/mailcow/mailcow-dockerized.git

WORKDIR /opt/mailcow-dockerized

# Copy a preconfigured mailcow.conf (or generate during run)
COPY mailcow.conf mailcow.conf

# Ensure permissions and setup scripts
RUN ./generate_config.sh

# Expose HTTPS port
EXPOSE 443

# Start mailcow on container start
#CMD ["docker-compose", "up", "-d"]
