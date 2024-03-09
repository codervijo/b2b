FROM ubuntu:22.04
RUN apt-get update && \
	apt-get install -y build-essential
RUN apt-get install -y qemu binfmt-support qemu-user-static

RUN apt-get install -y git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# /usr/local/share/kivy-examples/demo/pictures
#CMD ["/usr/bin/xeyes"]
