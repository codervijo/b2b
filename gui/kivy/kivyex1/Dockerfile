FROM ubuntu:18.04
RUN apt-get update && \
	apt-get install -y python-setuptools python-pygame python-opengl \
  	python-enchant python-dev build-essential python-pip libgl1-mesa-dev \
  	libgles2-mesa-dev zlib1g-dev
RUN apt-get install -y python3-kivy
RUN pip install kivy
RUN pip install kivy-examples
# /usr/local/share/kivy-examples/demo/pictures
#CMD ["/usr/bin/xeyes"]