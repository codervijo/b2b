#!/bin/bash
xhost +

CONTAINER=chrsome-sa-1
sudo docker build -t ${CONTAINER} .
#sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} /bin/bash
sudo docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/src ${CONTAINER} google-chrome-stable --no-sandbox
