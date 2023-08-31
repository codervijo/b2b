FROM ubuntu:22.04

RUN apt-get update; apt-get clean

# Add a user for running applications.
RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

# Install x11vnc.
RUN apt-get install -y x11vnc x11-apps

# Install xvfb.
RUN apt-get install -y xvfb

# Install fluxbox.
RUN apt-get install -y fluxbox

# Install wget.
RUN apt-get install -y wget sudo

# Install wmctrl.
RUN apt-get install -y wmctrl

RUN apt-get install -y gnupg2

# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

RUN apt-get install -y zip 
RUN apt-get install -y default-jre default-jdk

#RUN useradd -ms /bin/bash devuser
RUN adduser --disabled-password --gecos '' devuser
RUN adduser devuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devuser
WORKDIR /home/devuser


#COPY bootstrap.sh /

#CMD '/bootstrap.sh'
