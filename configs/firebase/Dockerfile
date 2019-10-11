# Ref : https://docs.docker.com/samples/library/golang/
FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN mkdir /usr/src/app

WORKDIR /usr/src/app
COPY firebase-entrypoint.sh /usr/local/bin

# Install utils
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git vim net-tools ssh wget curl

# Install Golang
RUN mkdir /root/pkgs
RUN (cd /root/pkgs; \
     wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz; \
     tar xvf go1.12.9.linux-amd64.tar.gz; \
     mv go /usr/local)

# Install Node
ENV NODE_VERS v12.11.1
RUN mkdir /usr/src/app/node/
RUN wget -O- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN chmod ugo+x /root/.nvm/nvm.sh
ENV NVM_DIR /usr/src/app/node
RUN  . /root/.nvm/nvm.sh && nvm install node
ENV PATH   ${NVM_DIR}/versions/node/${NODE_VERS}/bin/:$PATH
RUN npm install -g firebase-tools

ENV PATH   ${PATH}:/usr/local/go/bin
ENV GOPATH /usr/src/app/go
ENV GOROOT /usr/local/go/
ENV PATH   ${PATH}:${GOROOT}/bin

RUN mkdir ${GOPATH}

ENTRYPOINT ["/usr/local/bin/firebase-entrypoint.sh"]
