#!/bin/bash

CONTAINER=lw1

# Allow local docker containers to access X11 (on host)
xhost +local:docker

# Build the Docker image
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Start the container with X11 support
sudo docker run \
  -v ${PWD}:/usr/src/app/ \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  --env QT_X11_NO_MITSHM=1 \
  --device /dev/fuse \
  --cap-add SYS_ADMIN \
  --network=host \
  -p 6173:5173 \
  -it ${CONTAINER} /bin/bash


