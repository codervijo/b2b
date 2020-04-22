# Ref : https://docs.docker.com/samples/library/golang/
FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN mkdir /usr/src/app

WORKDIR /usr/src/app
COPY sante-entrypoint.sh /usr/local/bin

# Install utils
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git vim net-tools ssh wget
RUN apt-get install -y python

# Install Golang
RUN mkdir /root/pkgs
RUN (cd /root/pkgs; \
     wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz; \
     tar xvf go1.12.9.linux-amd64.tar.gz; \
     mv go /usr/local)


# Install youtube-dl
RUN wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
RUN hash -r

ENV PATH   ${PATH}:/usr/local/go/bin
ENV GOPATH /usr/src/app/go
ENV GOROOT /usr/local/go/
ENV PATH   ${PATH}:${GOPATH}/bin

RUN mkdir ${GOPATH}

# Go Dependencies
RUN go get github.com/urfave/cli

ENTRYPOINT ["/usr/local/bin/sante-entrypoint.sh"]
