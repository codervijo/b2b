FROM ubuntu:22.04

ENV DEBIAN_FRONTEND interactive

RUN apt-get update && \
	apt-get install -y build-essential make cmake git wget

RUN apt-get install -y net-tools pkg-config libtool gcc
#RUN apt-get install -y qemu binfmt-support qemu-user-static
# /usr/local/share/kivy-examples/demo/pictures
#CMD ["/usr/bin/xeyes"]
