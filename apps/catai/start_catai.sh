#!/bin/bash

source ~/.nvm/nvm.sh
nvm install node
npm install -g catai
catai install meta-llama
catai install meta-llama-3-8b-q4_k_m
#catai up
ifconfig
while true; do
    catai up
done