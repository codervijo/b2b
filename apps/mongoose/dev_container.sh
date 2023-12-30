#!/bin/bash

CONTAINER=mws1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}

docker build -t ${CONTAINER} .

docker run --privileged -it --rm -v $PWD:/usr/src/${CONTAINER} -p 8000:8045 --net=host ${CONTAINER} /bin/bash
