# Ref : https://docs.docker.com/samples/library/golang/
FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN mkdir /usr/src/app

WORKDIR /usr/src/app
COPY go1.8-entrypoint.sh /usr/local/bin

# Install utils
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git vim net-tools ssh wget

# Install Golang
RUN mkdir /root/pkgs
RUN (cd /root/pkgs; \
     wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz; \
     tar xvf go1.8.linux-amd64.tar.gz; \
     mv go /usr/local)

ENV PATH   ${PATH}:/usr/local/go/bin
ENV GOPATH /usr/src/app/go
ENV GOROOT /usr/local/go/
ENV PATH   ${PATH}:${GOROOT}/bin

RUN mkdir ${GOPATH}

ENTRYPOINT ["/usr/local/bin/go1.8-entrypoint.sh"]
