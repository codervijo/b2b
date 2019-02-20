FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN		apt-get -y update && apt-get -y install lua5.1 lua-socket lua-sec
RUN		apt-get -y install procps net-tools
ADD		. /usr/src/luascope
CMD		["lua", "/usr/src/luascope/scope"]
