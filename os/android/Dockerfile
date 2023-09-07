# Dockerfile to build linux kernel for x86
FROM ubuntu:22.04
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN apt-get update
#RUN apt-get upgrade -y
#RUN apt-get install -y vim
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y git net-tools ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ncurses-dev make gcc bc libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y flex bison
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf automake libtool


# Install some dependencies
RUN dpkg --add-architecture i386 && apt-get update \
    && apt-get install -y expect wget unzip \
    libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install java
RUN apt-get install -y openjdk-8-jdk-headless

# Install other utilities
RUN apt-get install -y vim git net-tools ssh

# Install gradle
RUN apt-get install -y gradle

# Install the Android SDK
RUN cd /opt && wget --output-document=android-sdk.zip --quiet \
    https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip android-sdk.zip -d /opt/android-sdk && rm -f android-sdk.zip

# Setup environment
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Install SDK elements. This might change depending on what your app needs
# I'm installing the most basic ones. You should modify this to install the ones
# you need. You can get a list of available elements by getting a shell to the
# container and using `sdkmanager --list`
RUN echo yes | sdkmanager "platform-tools" "platforms;android-28"

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

ENV YACC "bison -y"
ENV LEX  "flex"

#COPY linux-stable /usr/src/linux
