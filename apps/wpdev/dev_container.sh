#!/bin/bash

CONTAINER=wpdev1
#sudo docker build -t ${CONTAINER} .
#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ${CONTAINER}
# echo "127.0.0.1       wpdev.lamill.io">>/etc/hosts

docker build -t ${CONTAINER} .

docker run --privileged -it --rm -v $PWD:/data  -p 80:80 ${CONTAINER} /bin/bash
