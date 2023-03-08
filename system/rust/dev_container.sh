#!/bin/bash

# Check if docker exists on this computer
if ! hash docker &> /dev/null
then
    echo "docker could not be found"
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt install docker-ce
    sudo usermod -aG docker ${USER}
    #exit
fi

# Make sure b2b directory exists and is git clone of right project
[ -d ./b2b ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2

CONTAINER=rust2

# Make symlink to docker for this dev environment
if [ ! -f Dockerfile ]
then
    cp b2b/system/rust/Dockerfile .
fi

# Init container
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

# Start Dev container
sudo docker run -v${PWD}:/usr/src/app/ --network=host -p3000:3535 -it ${CONTAINER}  /bin/bash
