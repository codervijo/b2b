# Used for building & testing wget from current working directory
FROM ubuntu:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

#COPY Apr17 /usr/src/wget/ --> USE -v for sharing directories.
#WORKDIR /usr/src/glibc
#TODO Lot more packages needed 
# For Wget2 : sudo apt install -y libtool
RUN \
	apt-get update  && \
	apt-get -y install gcc build-essential && \
	apt-get -y install vim \
	apt-get -y install gettext gawk && \
	apt-get -y install python3 python git && \
	apt-get -y install autoconf automake pkg-config && \
	apt-get -y install autopoint texinfo flex && \
	apt-get -y install gperf && \
	apt-get -y install gnutls-dev && \
	/bin/bash
CMD [ "/bin/bash" ]
