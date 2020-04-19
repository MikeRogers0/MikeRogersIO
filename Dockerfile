FROM ruby:2.6.6-slim AS development

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

# Install the Essentials
RUN apt-get update -qq && apt-get install -y build-essential apt-transport-https ca-certificates gnupg2 netcat curl openssl tzdata

# Install the PostgreSQL packages
 #RUN apt-get install -y libpq-dev

# Install the nokogiri packages
RUN apt-get install -y libxml2-dev libxslt1-dev

# Add NodeJS to sources list
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Add the current apps files into docker image
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install any extra dependencies via Aptfile
# COPY Aptfile /usr/src/app/Aptfile
# RUN apt-get install -y $(cat /usr/src/app/Aptfile | xargs)

ENV PATH /usr/src/app/bin:$PATH

# Install latest bundler
RUN gem update --system && gem install bundler:2.0.2

# Install Ruby Gems
COPY .ruby-version /usr/src/app
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle check || bundle install --jobs=$(nproc)

# Install Yarn Libraries
COPY package.json /user/src/app
RUN yarn install --check-files

# Copy the rest of the app
COPY . /usr/src/app

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3001
CMD ["bundle", "exec", "middleman", "server", "-p", "3001"]

FROM development
