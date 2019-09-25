#!/bin/bash
sudo docker build -tfbase11 .
sudo docker run -p 9005:9005 -it fbase11  /bin/bash