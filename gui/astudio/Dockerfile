FROM ubuntu:14.04
MAINTAINER Vijo Cherian codervijo@gmail.com

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y vim git unzip libglu1 libpulse-dev libasound2 libc6  libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxi6  libxtst6 libnss3 wget

RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:openjdk-r/ppa 
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

ARG GRADLE_VERSION=5.4.1
ARG ANDROID_API_LEVEL=23
ARG ANDROID_BUILD_TOOLS_LEVEL=23.0.3
ARG EMULATOR_NAME='test'

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
&& unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip \
&& mkdir /opt/gradlew \
&& /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper --gradle-version ${GRADLE_VERSION} --distribution-type all -p /opt/gradlew  \
&& /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper -p /opt/gradlew

RUN wget 'https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip' -P /tmp \
&& unzip -d /opt/android /tmp/sdk-tools-linux-4333796.zip \
&& yes Y | /opt/android/tools/bin/sdkmanager --install "platform-tools" "system-images;android-${ANDROID_API_LEVEL};google_apis;x86_64" "platforms;android-${ANDROID_API_LEVEL}" "build-tools;${ANDROID_BUILD_TOOLS_LEVEL}" "emulator" \
&& yes Y | /opt/android/tools/bin/sdkmanager --licenses \
&& echo "no" | /opt/android/tools/bin/avdmanager --verbose create avd --force --name "test" --device "pixel" --package "system-images;android-${ANDROID_API_LEVEL};google_apis;x86_64" --tag "google_apis" --abi "x86_64"

ENV GRADLE_HOME=/opt/gradle/gradle-$GRADLE_VERSION \
ANDROID_HOME=/opt/android
ENV PATH "$PATH:$GRADLE_HOME/bin:/opt/gradlew:$ANDROID_HOME/emulator:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
ENV LD_LIBRARY_PATH "$ANDROID_HOME/emulator/lib64:$ANDROID_HOME/emulator/lib64/qt/lib"


RUN wget https://dl.google.com/dl/android/studio/ide-zips/3.2.1.0/android-studio-ide-181.5056338-linux.zip -P /tmp
RUN unzip -d /opt /tmp/android-studio-ide-181.5056338-linux.zip

CMD /opt/android-studio/bin/studio.sh

ADD start.sh /

#RUN chmod +x start.sh