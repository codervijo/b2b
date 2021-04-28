# Dockerfile to build FUSE
FROM ubuntu:20.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update
#RUN apt-get upgrade -y
#RUN apt-get install -y vim
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y git net-tools ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ncurses-dev make gcc bc libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y flex bison
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf automake libtool
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libfuse-dev

ENV YACC "bison -y"
ENV LEX  "flex"

#COPY linux-stable /usr/src/linux
