# Used for building glibc from current working directory
FROM ubuntu:22.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN \
	apt-get update  && \
	apt-get -y install gcc build-essential && \
	apt-get -y install gettext makeinfo gawk && \
	apt-get -y install python3 
RUN apt-get install -y git vim net-tools ssh
RUN	apt-get install -y libdbus-1-dev libbluetooth-dev
#CMD [ "/bin/bash" ]
