# Dockerfile to build linux kernel for x86
FROM ubuntu:18.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update
#RUN apt-get upgrade -y
#RUN apt-get install -y vim
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y git net-tools ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ncurses-dev make bc libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y flex bison
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf automake libtool

# Poky pre-requisites
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool

RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN useradd pokyuser

ENV YACC "bison -y"
ENV LEX  "flex"

#COPY linux-stable /usr/src/linux
