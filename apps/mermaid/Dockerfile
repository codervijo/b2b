FROM	node:18
#FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN     apt-get -y install curl

RUN mkdir /usr/src/app

WORKDIR /usr/src/app


RUN     apt-get -y update && apt-get install -y curl
RUN     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/root/rustup.sh
RUN     apt-get -y install procps net-tools ssh
RUN     apt-get -y install openssl
RUN     apt-get -y install libssl-dev pkg-config
RUN     apt-get -y install build-essential
RUN apt-get -y install libxml2 libxml2-dev cmake libcurl4-openssl-dev
RUN apt-get -y install protobuf-compiler libprotobuf-dev
RUN apt-get -y install net-tools vim file
RUN /bin/bash -x /root/rustup.sh -y

RUN apt-get -y install libsoup*
#RUN apt-get -y install javascriptcoregtk-4.0 libpango* gdk-pixbuf-2.0
RUN apt-get -y install javascriptcoregtk-4.0 libpango*
RUN apt-get -y install libatk* gdk-3.0 libgdk* libgtk-3-dev
#RUN apt-get -y install webkit2gt* webkit2git-4.0

RUN apt-get update && apt-get install -y \
    libwebkit2gtk-4.0-dev \
    libgtk-3-dev \
    libgdk-pixbuf2.0-dev \
    libpango1.0-dev \
    libharfbuzz-dev \
    libatk1.0-dev \
    libcairo2-dev \
    libsoup2.4-dev \
    libjavascriptcoregtk-4.0-dev \
    libglib2.0-dev

RUN npm install -g pnpm
RUN npm install -g @tauri-apps/cli

RUN apt-get install -y libjavascriptcoregtk-4.1-dev pkg-config
RUN apt-get install -y libwebkit2gtk-4.1-dev pkg-config
RUN pkg-config --libs --cflags webkit2gtk-4.1
RUN apt-get install -y inotify-tools

#RUN     npm install 
#RUN     npm install react-scripts@3.0.1 -g --silent

#CMD	["npm", "start"]
