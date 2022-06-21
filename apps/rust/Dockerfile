FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN		apt-get -y update && apt-get install -y curl
RUN             curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >/root/rustup.sh
RUN		apt-get -y install procps net-tools ssh
#CMD		["lua", "/usr/src/luascope/scope"]
