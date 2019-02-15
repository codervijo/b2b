FROM ruby:2.5
MAINTAINER codervijo@gmail.com

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /usr/src/app
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

#COPY Gemfile Gemfile.lock ./
#RUN bundle install

COPY . /usr/src/ror

#CMD ["/bin/bash"]
