#!/bin/bash

CONTAINER=opi2
sudo docker build -t ${CONTAINER} .
sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} /bin/bash

