FROM	node:16
#FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN     apt-get -y install curl

RUN wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
RUN tar -xvf prometheus-2.46.0.linux-amd64.tar.gz
RUN mkdir /usr/src/app

WORKDIR /usr/src/app

#CMD	["npm", "start"]
