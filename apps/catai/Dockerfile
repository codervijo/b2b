FROM	debian:latest
MAINTAINER Vijo Cherian codervijo@gmail.com

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git vim wget nodejs
RUN	apt-get -y install procps net-tools ssh
RUN apt-get -y install cmake
RUN mkdir /usr/src/app

WORKDIR /usr/src/app

# Install Node
ENV NODE_VERS_MAJOR  16
ENV NODE_VERS        v${NODE_VERS_MAJOR}.2.0
RUN mkdir            /usr/src/app/node/
RUN wget -O-         https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash
RUN chmod ugo+x      /root/.nvm/nvm.sh
ENV NVM_DIR          /usr/src/app/nod
RUN  . /root/.nvm/nvm.sh && nvm install ${NODE_VERS_MAJOR} && \
	                        nvm use ${NODE_VERS_MAJOR} && \
	                        export NVM_PATH=$(nvm current); \
	                        echo "export NVM_PATH=$NVM_PATH" >> /root/.bashrc \
	                        echo "export PATH=${NVM_DIR}/versions/node/$NVM_PATH/bin/:$PATH">>/root/.bashrc
# For https://github.com/webpack/webpack/issues/14532#issuecomment-947012063
# ENV NODE_OPTIONS --openssl-legacy-provider

#RUN     npm install 
#RUN     npm install react-scripts@3.0.1 -g --silent

#CMD	["npm", "start"]
