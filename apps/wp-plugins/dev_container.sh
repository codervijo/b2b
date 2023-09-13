#!/bin/bash

CONTAINER=wpplugin1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}

docker build -t ${CONTAINER} .

docker run --privileged -it --rm -v $PWD:/data  -p 8888:38888 ${CONTAINER} /bin/bash
