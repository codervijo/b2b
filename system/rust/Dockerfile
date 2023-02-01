FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN apt-get -y install nodejs npm
RUN apt-get -y install build-essential curl

# Get Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
ENV PATH="/root/.cargo/bin:${PATH}"

RUN mkdir /usr/src/app

WORKDIR /usr/src/app


#CMD	["npm", "start"]
