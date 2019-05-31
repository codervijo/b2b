FROM debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update -qq && apt-get install -y haproxy rsyslog
RUN apt-get install -y git vim net-tools ssh wget

RUN mkdir /usr/src/app
RUN mkdir -p /root/pkgs

WORKDIR /usr/src/app

ARG  SITEURL=lamill.io
ENV  SITEURL=${SITEURL}
RUN  touch       /root/imgb4install
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY haproxy-entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/haproxy-entrypoint.sh"]
