#!/bin/bash

GIT_TOP_DIR=$(git rev-parse --show-toplevel)
test "${PWD##/${GIT_TOP_LEVEL}/}" != "${PWD}"
# Make sure b2b directory exists and is git clone of right project
[ -d ./b2b ] || [ "${PWD##/${GIT_TOP_LEVEL}/}" == "${PWD}" ] || (echo "B2B GIT repo not found, exiting"; exit 77); [ "$?" -eq 77 ]  && exit 2

CONTAINER=android2

# Make symlink to docker for this dev environment
#ln -sf b2b/apps/react-native/Dockerfile .

# ToDo ;; use docker inspect instead
if [[ "$(sudo docker images -q ${CONTAINER}:latest 2>/dev/null)" == "" ]];
then
    # Init container
    sudo docker build --tag ${CONTAINER}:latest --cache-from ${CONTAINER}:latest .
fi

# Start Dev container
sudo docker run --privileged --network=host -p19000:19000 -p19001:19001 -p19002:19002 -p19006:19006 -v${PWD}:/usr/src/app/${CONTAINER} -it ${CONTAINER}:latest  /bin/bash

#docker pull kerbe/expo
#docker run -it --rm -p 19000:19000 -p 19001:19001 -p 19002:19002 -v "$PWD:/app" \
#-e REACT_NATIVE_PACKAGER_HOSTNAME=192.168.1.101 \
#-e EXPO_DEVTOOLS_LISTEN_ADDRESS=0.0.0.0 \
#--name=expo kerbe/expo start


# Resources
# https://andresand.medium.com/android-emulator-on-docker-container-f20c49b129ef