#!/bin/bash

B2BDIR=${HOME}/work/b2b
PARENTDIR=${B2BDIR}/apps/rust/


# Make sure b2b directory exists and is git clone of right project
[ -d ${B2BDIR} ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2
# Check if docker exists in path
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


CONTAINER=brief1

# Make dockerfile available here
if [ ! -f Dockerfile ]
then
    cp ${PARENTDIR}/Dockerfile .
fi


# Init container
sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest -t ${CONTAINER} . || sudo docker build -t ${CONTAINER} .

echo "To start rust, start with sh /root/rustup.sh"
# Start Dev container
sudo docker run -v${PWD}:/usr/src/app/  -it ${CONTAINER}  /bin/bash
