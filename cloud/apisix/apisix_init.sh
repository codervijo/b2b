#!/bin/bash

# Set the directory where the APISIX repo will be cloned
APISIX_DOCKER_DIR="apisix-docker"
APISIX_DIR="apisix"

# Check if the directory already exists
if [ ! -d "$APISIX_DOCKER_DIR" ]; then
  echo "Cloning APISIX Docker repository..."
  git clone https://github.com/apache/apisix-docker.git
else
  echo "APISIX Docker repository already exists, skipping clone."
fi

# Check if the directory already exists
if [ ! -d "$APISIX_DIR" ]; then
  echo "Cloning APISIX repository..."
  git clone https://github.com/apache/apisix.git
else
  echo "APISIX repository already exists, skipping clone."
fi

# Install OpenResty, which is required by APISIX
wget https://openresty.org/download/openresty-1.21.4.1.tar.gz
tar -xvzf openresty-1.21.4.1.tar.gz
(cd openresty-1.21.4.1 && ./configure && make && make install)
echo 'export PATH=$PATH:/usr/local/openresty/nginx/sbin' >> ~/.bashrc
source ~/.bashrc
export PATH=$PATH:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin/

# build apisix
# TODO

# Run the APISIX quickstart script
echo "Running the APISIX quickstart script..."
curl -sL https://run.api7.ai/apisix/quickstart | sh
