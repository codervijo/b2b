FROM	ubuntu:22.04
MAINTAINER Vijo Cherian codervijo@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN     apt-get -y install curl

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

RUN     apt-get -y update && apt-get install -y curl
RUN     apt-get -y install procps net-tools ssh
RUN     apt-get -y install openssl
RUN     apt-get -y install libssl-dev pkg-config
RUN     apt-get -y install build-essential

RUN apt install -y apt-transport-https
RUN wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
RUN echo "deb https://packages.grafana.com/oss/deb stable main" |  tee /etc/apt/sources.list.d/grafana.list

RUN apt-get update && apt-get install -y grafana

#CMD	["npm", "start"]
