#!/bin/bash

#xhost +

CONTAINER=hugonix1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}

sudo docker build -t ${CONTAINER} .

sudo docker run --privileged -it --rm   --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $PWD:/usr/src/app  --net=host ${CONTAINER} /bin/sh
