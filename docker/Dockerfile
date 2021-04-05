FROM ruby:3.0

ENV INSTALL_DIR /usr/install
ENV APP_DIR /coocre_backend

COPY ./Gemfile $INSTALL_DIR/
COPY ./Gemfile $APP_DIR/
COPY ./Gemfile.lock $INSTALL_DIR/
COPY ./Gemfile.lock $APP_DIR/
COPY ./.pryrc /root/

WORKDIR $INSTALL_DIR

ENV PACKAGES 'build-essential nodejs vim less zsh shared-mime-info'
RUN set -x \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y $PACKAGES \
    && apt-get clean \
    && gem update --system \
    && bundle install

RUN echo "\
export PATH=$PATH:~/.yarn/bin/ \n\
alias rs='rake tmp:cache:clear; bundle exec rails s -p 3100 -b 0.0.0.0' \n\
alias rc='bundle exec rails c' \n\
" >> /root/.zshrc

WORKDIR $APP_DIR

RUN set -x \
  && ls -al \
  && rm Gemfile.*
