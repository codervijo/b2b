FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN apt-get -y install curl

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

# Install Node
RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV PATH $PATH:$VOLTA_HOME/bin
RUN volta install node@20.11.0

# For https://github.com/webpack/webpack/issues/14532#issuecomment-947012063
# ENV NODE_OPTIONS --openssl-legacy-provider

#RUN     npm install 
#RUN     npm install react-scripts@3.0.1 -g --silent

#CMD	["npm", "start"]
