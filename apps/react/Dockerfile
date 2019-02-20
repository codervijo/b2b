FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y install nodejs
RUN	apt-get -y install procps net-tools ssh
RUN     npm install react-scripts@1.1.1 -g --silent

CMD	["npm", "start"]
