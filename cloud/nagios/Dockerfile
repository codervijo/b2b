FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    gzip && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev && \
    apt-get install -y openssl libssl-dev

RUN mkdir /nagios
WORKDIR /nagios
RUN wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz
RUN tar xzf nagioscore.tar.gz

RUN cd nagioscore-nagios-4.4.14/ && ./configure && make all
#RUN make install-groups-users && usermod -a -G nagios apache


# Command to run Prometheus
#CMD ["./prometheus", "--config.file=./prometheus.yml"]
