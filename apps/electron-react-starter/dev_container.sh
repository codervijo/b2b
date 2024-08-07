#!/bin/bash

# Ensure the B2B directory exists and is the correct project
current_dir=$(pwd)
root_dir=$(dirname $(dirname "$current_dir"))
root_dirname=$(basename "$root_dir")
if [ "$root_dirname" == "b2b" ]; then
  echo "Running inside b2b"
else
  [ -d ./b2b ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2
fi

CONTAINER=ele4

# Build the Docker image
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Allow Docker containers to connect to the X server
xhost +local:docker

# Start the Docker container with X11 forwarding
sudo docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${PWD}:/usr/src/app/ \
    -p 4000:7454 \
    ${CONTAINER} \
    /bin/bash
