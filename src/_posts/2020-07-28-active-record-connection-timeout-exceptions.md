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

The fix was to update my [`config/database.yml`](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/config/database.yml) to be:

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
