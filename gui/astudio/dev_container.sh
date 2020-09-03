#!/bin/bash
xhost +

CONTAINER=as1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}

docker build \
--build-arg GRADLE_VERSION=5.4.1 \
--build-arg ANDROID_API_LEVEL=23 \
--build-arg ANDROID_BUILD_TOOLS_LEVEL=23.0.3 \
--build-arg EMULATOR_NAME=test \
-t ${CONTAINER} .

docker run --privileged -it --rm -v $PWD:/data  --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER} bash -c ". /start.sh && gradlew build -p /data && /opt/android-studio/bin/studio.sh"