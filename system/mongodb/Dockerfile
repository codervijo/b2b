FROM ubuntu:18.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update

# Install some dependencies
RUN 	apt-get install -y vim git net-tools ssh

# Install mongodb
RUN 	apt-get install -y mongodb
COPY 	mongodb.conf /etc/mongodb.conf

VOLUME 	["/data/db/mongo1"]

#WORKDIR /data
EXPOSE 27017
CMD ["mongod", "--smallfiles"]