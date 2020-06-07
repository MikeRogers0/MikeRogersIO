FROM ruby:2.7.1-alpine AS development

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

# Install the Essentials
ENV BUILD_DEPS="curl tar wget linux-headers bash" \
    DEV_DEPS="ruby-dev build-base postgresql-dev zlib-dev libxml2-dev libxslt-dev readline-dev tzdata git nodejs vim yarn libsass"

RUN apk add --update --upgrade $BUILD_DEPS $DEV_DEPS
RUN rm -rf /var/cache/apk/*

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Set up environment
ENV PATH /usr/src/app/bin:$PATH

# Add some helpers to reduce typing when inside the containers
RUN echo 'alias bx="bundle exec"' >> ~/.bashrc

# Set ruby version
COPY .ruby-version /usr/src/app

# Configure Bundler
RUN gem update --system
RUN bundle config --global silence_root_warning 1

EXPOSE 3001
CMD ["bundle", "exec", "middleman", "server", "-p", "3001"]

FROM development AS production

# Install Ruby Gems
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle check || bundle install --jobs=$(nproc)

# Install Yarn Libraries
COPY package.json /user/src/app
COPY yarn.lock /user/src/app
RUN yarn install --check-files

# Copy the rest of the app
COPY . /usr/src/app

# Compile the assets
RUN RAILS_ENV=production RACK_ENV=production NODE_ENV=production bundle exec middleman build
