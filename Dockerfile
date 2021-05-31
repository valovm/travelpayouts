FROM ruby:2.7.2-alpine

RUN apk add --update --no-cache \
    openssl \
    tzdata \
    mariadb-dev \
    nodejs \
    git \
    build-base \
    libxslt-dev \
    less \
    bash

RUN gem install bundler

WORKDIR /app
COPY . /app/

RUN bundle install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]