FROM ruby:2.7.1-alpine AS development

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

# Install the Essentials
ENV BUILD_DEPS="curl tar wget linux-headers bash" \
    DEV_DEPS="ruby-dev build-base postgresql-dev zlib-dev libxml2-dev libxslt-dev readline-dev tzdata git nodejs"

RUN apk add --update --upgrade $BUILD_DEPS $DEV_DEPS

# Install Yarn
RUN apk add --update yarn

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install any extra dependencies via Aptfile
# COPY Aptfile /usr/src/app/Aptfile
# RUN apk add --update $(cat /usr/src/app/Aptfile | xargs)

ENV PATH /usr/src/app/bin:$PATH

# Set ruby version
COPY .ruby-version /usr/src/app

# Install latest bundler
RUN gem update --system && gem install bundler:2.0.2
# RUN bundle config path /usr/local/bundle
RUN bundle config --global silence_root_warning 1 && echo -e 'gem: --no-document' >> /etc/gemrc

# Install gems which regularly take a while to install
RUN gem install sassc -v 2.2.1 && gem install nokogiri -v 1.10.8

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
# RUN bundle check || bundle install --jobs=$(nproc)

# Install Yarn Libraries
COPY package.json /user/src/app
# RUN yarn install --check-files

# Copy the rest of the app
COPY . /usr/src/app

EXPOSE 3001
CMD ["bundle", "exec", "middleman", "server", "-p", "3001"]

FROM development
