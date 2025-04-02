# Ref : https://docs.docker.com/samples/library/golang/
FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN mkdir /usr/src/app

WORKDIR /usr/src/app
COPY go1.20-entrypoint.sh /usr/local/bin

# Install utils
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    git \
    vim \
    net-tools \
    ssh \
    wget \
    curl \
    gnupg2 \
    lsb-release

# Install Golang
RUN mkdir /root/pkgs
RUN (cd /root/pkgs; \
     wget https://dl.google.com/go/go1.20.linux-amd64.tar.gz; \
     tar xvf go1.20.linux-amd64.tar.gz; \
     mv go /usr/local)

ENV PATH   ${PATH}:/usr/local/go/bin
ENV GOPATH /usr/src/app/go
ENV GOROOT /usr/local/go/
ENV PATH   ${PATH}:${GOPATH}/bin

RUN mkdir ${GOPATH}

# Install Hugo
RUN (cd /root/pkgs; \
     wget https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_0.111.3_Linux-64bit.tar.gz; \
     tar xvf hugo_0.111.3_Linux-64bit.tar.gz; \
     mv hugo /usr/local/bin/)

# Install Node.js (via NodeSource)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install pnpm globally
RUN npm install -g pnpm

# Install Vite
RUN pnpm add -g create-vite

# Install React (this can be done later in your React project folder)
# RUN pnpm create vite my-react-app --template react

ENTRYPOINT ["/usr/local/bin/go1.20-entrypoint.sh"]
