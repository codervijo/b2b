FROM ruby:2.5
MAINTAINER codervijo@gmail.com

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y git vim
RUN mkdir /usr/src/app

# For deployments only 
# throw errors if Gemfile has been modified since Gemfile.lock
#RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL
RUN ~/.rbenv/bin/rbenv install 2.5.1
RUN ~/.rbenv/bin/rbenv global 2.5.1

RUN gem install bundler

RUN apt-get install -y ruby-dev
RUN gem install nio4r
RUN apt-get install -y mysql-server mysql-client
RUN gem install mysql2 -v '0.4.10'

# This is to be done during "run"-time
#RUN cd /usr/src/app/chuckdapress/ && bundle install

# Set up bundle once and for all
COPY chuckdapress/Gemfile  ./
RUN bundle install
RUN gem pristine nokogiri --version 1.8.2
RUN gem pristine bindex --version 0.5.0
RUN gem install nio4r
RUN gem install websocket-driver-0.6.5
RUN gem pristine websocket-driver --version 0.6.5
RUN gem install byebug
RUN gem install ffi
RUN gem install mysql2 --version 0.4.10
RUN gem pristine pum --version 3.11.4
RUN gem pristine puma --version 3.11.4
#systemctl start mysqld
#rails server

EXPOSE 3034

COPY . /usr/src/ror

#CMD ["/bin/bash"]
