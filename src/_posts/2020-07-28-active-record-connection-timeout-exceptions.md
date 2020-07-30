---
layout: post
title: Fixing ActiveRecord::ConnectionTimeoutError exceptions
description: I started seeing errors like ActiveRecord::ConnectionTimeoutError & Rack::Timeout::RequestTimeoutException, here is how I sorted it.
---

I recently started seeing errors like:

```
ActiveRecord::ConnectionTimeoutError
could not obtain a connection from the pool within 5.000 seconds (waited 5.000 seconds); all pooled connections were in use
```

and

```
Rack::Timeout::RequestTimeoutException
Request waited 6ms, then ran for longer than 15000ms 
```

When looking at my database, I had 5/20 connections in use, so I had plenty of capacity. After a bit of research, I found out I had misconfigured my Ruby On Rails apps database settings.

## Missing config/database.yml

I've always used the `DATABASE_URL` over setting details in the `config/database.yml`, however this meant the connection pool was stuck at the [default size of 5](https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/ConnectionPool.html). This meant when a had a puma worker with 18 threads, and I received 18 requests at the same time only 5 of them could make connections to the database, resulting in the exception.

The first fix was to update my [`config/database.yml`](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/config/database.yml) to be:

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  url: <%= ENV['DATABASE_URL'] %>

development:
  <<: *default
  database: App_development

test:
  <<: *default
  database: App_test

production:
  <<: *default
```

This compliments my [config/puma.rb](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/config/puma.rb) configuration where the maximum amount of threads matches the connection pool size.

## Explicit `$PORT` in Procfile

Matching the connection pool size to the threads solved fixed my `ActiveRecord::ConnectionTimeoutError` exceptions, however I was still seeing a few timeouts (Along with a few "H20 - App boot timeout" errors from Heroku).

This was weird as my app would boot up locally within 5 seconds. After watching a deploy go out, I noticed the log lines:

```
heroku/web.1 State changed from starting to down
heroku/web.1 State changed from down to starting
heroku/web.1 Starting process with command `bundle exec rails s`
app/web.1 agentmon setup took 2 seconds
app/web.1 agentmon: Listening on :49331...
app/web.1 => Booting Puma
app/web.1 => Rails 6.0.3.2 application starting in production
app/web.1 => Run `rails server --help` for more startup options
heroku/web.1 Stopping all processes with SIGTERM
app/web.1 agentmon: Got signal terminated. Shutting down.
app/web.1 I, [2020-07-29T14:30:19.972943 #4]  INFO -- : Raven 3.0.0 ready to catch errors
app/web.1 Puma starting in single mode...
app/web.1 * Version 4.3.5 (ruby 2.7.1-p83), codename: Mysterious Traveller
app/web.1 * Min threads: 10, max threads: 14
app/web.1 * Environment: production
app/web.1 * Listening on tcp://0.0.0.0:6544
```

So weirdly the `PORT` environment variable (Which Heroku binds its load balancer to) was being overwritten somewhere. Really bazaar behaviour, but easily sorted.

I updated my `Procfile` to include a reference to the `$PORT` environmental variable for my web declaration, e.g:

```
release: bash bin/release-tasks.sh
web: bundle exec rails s -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml
```

Previously I just had `bundle exec rails s`. Updating the LOC ended up totally solving the H20 & timeouts exceptions I was seeing.
