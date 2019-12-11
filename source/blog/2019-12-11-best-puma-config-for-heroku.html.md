---
layout: post
title: My puma configuration for Heroku
categories:
 – blog
published: true
meta:
  description: Workers, threads? What is the best setup?
  index: true
---

Configuration the amount of workers & threads is a bit of a dark art. Usually try to optimise my apps configuration to use 60% of the Heroku dynos memory, then I just scale up the amount of dynos I'm using depending on traffic.

## TL;DR

I use the Ruby on Rails [default puma configuration](https://github.com/rails/rails/blob/0ee449790b7bd499d26f79228d628af2839f03e3/railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt) (which runs in threaded mode not clustered), then increase the amount of `RAILS_MAX_THREADS` (Normally up to 25) until ~60% of the memory is used.

Once I've reached a sweet spot, I scale up my dynos to handle the traffic.

## Should you use Clustered mode?

In you puma configuration you'll probably see a line like:

```ruby
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
```

Uncommenting this line enables clustered mode. Which create a separate process for each worker, which then should have multiple threads that handle the actual request.

I am not a proponent for using clustered mode on Heroku. In my opinion it's only for when you're running an app that can only run on a single server & you have no way to increase the amount of servers responding to requests.

I'd only consider this worth enabling enabling on the `performance-m` & `performance-l` level dynos, as it consumes a lot of initial memory.


## How many threads?

On most my new projects I've been sticking to the default rails puma configuring:

```ruby
# config/puma.rb
# From https://github.com/rails/rails/blob/0ee449790b7bd499d26f79228d628af2839f03e3/railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt
# Generated when you run `rails new AppName`

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
```

# References

https://github.com/puma/puma-heroku/blob/master/lib/puma/plugin/heroku.rb

https://github.com/heroku/barnes

https://github.com/rails/rails/blob/0ee449790b7bd499d26f79228d628af2839f03e3/railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt

https://github.com/puma/puma

https://devcenter.heroku.com/articles/dyno-types


