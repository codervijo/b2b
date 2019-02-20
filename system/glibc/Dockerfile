# Used for building glibc from current working directory
FROM ubuntu:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

COPY glibc /usr/src/glibc/
#WORKDIR /usr/src/glibc
RUN \
	apt-get update  && \
	apt-get -y install gcc build-essential && \
	apt-get -y install gettext makeinfo gawk && \
	apt-get -y install python3 python && \
        /bin/bash
RUN 	apt-get -y install git vim net-tools ssh
#CMD [ "/bin/bash" ]
