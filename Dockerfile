FROM ruby:2.7

ENV APP_DIR /usr/src/api

WORKDIR $APP_DIR

COPY ./Gemfile $APP_DIR/
COPY ./Gemfile.lock $APP_DIR/

COPY ./.pryrc /root/
RUN echo "\
export PATH=$PATH:~/.yarn/bin/ \n\
alias rs='rake tmp:cache:clear; bundle exec rails s -p 3100 -b 0.0.0.0' \n\
alias rc='bundle exec rails c' \n\
alias rubo='bundle exec rubocop -c .my_rubocop.yml' \n\
alias wp='bin/webpack-dev-server' \n\
" >> /root/.zshrc

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim zsh

RUN bundle install --path=vendor/bundle
