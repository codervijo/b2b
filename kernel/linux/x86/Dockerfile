# Dockerfile to build Linux kernel
FROM ubuntu:18.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt update
RUN apt upgrade -y
RUN apt-get install -y vim
RUN apt-get install -y git net-tools ssh
RUN apt-get install -y ncurses-dev make gcc bc libssl-dev
RUN apt-get install -y flex bison
RUN apt-get install -y autoconf automake libtool

ENV YACC "bison -y"
ENV LEX  "flex"

#COPY linux-stable /usr/src/linux
