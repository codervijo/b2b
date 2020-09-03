#!/bin/bash
xhost +
sudo docker build -t guiapp1 .
sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" guiapp1