#!/bin/bash

# Make sure b2b directory exists and is git clone of right project
[ -d ./b2b ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2

CONTAINER=cc1

# Make symlink to docker for this dev environment
cp b2b/apps/catai/Dockerfile .

# Init container
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Start Dev container
sudo docker run -v${PWD}:/usr/src/app/ -p4000:3554 -it ${CONTAINER}  /bin/bash
