FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update -qq && apt-get install -y nginx
RUN apt-get install -y git vim net-tools ssh wget

RUN mkdir /usr/src/app
RUN mkdir -p /root/pkgs

WORKDIR /usr/src/app

ARG  SITEURL=lamill.io
ENV  SITEURL=${SITEURL}
COPY slb-entrypoint.sh /usr/local/bin
COPY lamill.io   /etc/nginx/sites-available
COPY lamill.io   /etc/nginx/sites-enabled
RUN  touch       /root/imgb4install

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/slb-entrypoint.sh"]
