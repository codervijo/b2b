#!/bin/bash
xhost +
sudo docker build -t edev1 .
sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" edev1