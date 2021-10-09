FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get update && apt-get install -y lua-socket lua-sec
RUN	apt-get install -y procps net-tools ssh
RUN	apt-get install -y curl
RUN	apt-get install -y build-essential make gcc libreadline-dev
RUN	curl -R -O http://www.lua.org/ftp/lua-5.4.2.tar.gz
RUN	tar zxvf lua-5.4.2.tar.gz && cd lua-5.4.2 && make all test install

ADD		. /usr/src/luascope
CMD		["lua", "/usr/src/luascope/scope"]
