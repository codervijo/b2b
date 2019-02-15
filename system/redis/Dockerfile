FROM	debian:latest
RUN		apt-get -y update
RUN		apt-get install -y apt-utils
RUN		apt-get install -y redis-tools
RUN		apt-get install -y redis-server
RUN		apt-get install -y net-tools procps
#RUN  apt-get install -y golang
COPY	redis.conf /etc/redis/redis.conf
CMD		[ "redis-server", "/etc/redis/redis.conf" ]

EXPOSE	6379
