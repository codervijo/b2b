#!/bin/bash

# TODO skip the check if we are inside the b2b GIT
# Make sure b2b directory exists and is git clone of right project
[ -d ./b2b ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2

CONTAINER=el1

# Make symlink to docker for this dev environment
#cp b2b/apps/react/Dockerfile .

# Init container
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Start Dev container
sudo docker run -v${PWD}:/usr/src/app/ -p3000:3434 -it ${CONTAINER}  /bin/bash
