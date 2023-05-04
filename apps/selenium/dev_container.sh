#!/bin/bash
xhost +

CONTAINER=seleniumchrome2
sudo docker build -t ${CONTAINER} .
#sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} /bin/bash
#sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} google-chrome-stable --no-sandbox
sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} /bin/bash

