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

I use the Ruby on Rails [default puma configuration](https://github.com/rails/rails/blob/0ee449790b7bd499d26f79228d628af2839f03e3/railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt) (which runs in threaded mode not clustered), then increase the amount of `RAILS_MAX_THREADS` (Normally up to 18) until ~60% of the memory is used.

Once I've reached a sweet spot, I scale up my small dynos to handle the traffic.

## Find out about your server

https://devcenter.heroku.com/articles/dynos#process-thread-limits - 256 total processes + threads max. So 1 worker could have 255 threads, but 2 workers at most can have 127 threads.

> heroku run "cat /proc/cpuinfo"

At the time of writing, Heroku hobby servers use [Intel® Xeon® Processor E5-2670 v2](https://ark.intel.com/content/www/us/en/ark/products/75275/intel-xeon-processor-e5-2670-v2-25m-cache-2-50-ghz.html) which have 10 cores, with each core allowing for up to 20 threads.

Each core can run a worker, and each worker can have the amount of threads the CPU offers. After that point the CPU will start doing magic to queue requests.

## What are workers & should you use Clustered mode?

> Should match the number of CPU cores you have available. However, I don't enable it instead opting for using more dynos.
> It increases memory.

In you puma configuration you'll probably see a line like:

```ruby
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
```

Uncommenting this line enables clustered mode. Which create a separate process for each worker, which then should have multiple threads that handle the actual request.

I am not a proponent for using clustered mode on Heroku. In my opinion it's only for when you're running an app that can only run on a single server & you have no way to increase the amount of servers responding to requests.

I'd only consider this worth enabling enabling on the `performance-m` & `performance-l` level dynos, as it consumes a lot of initial memory.

## How many threads?

> Amount of threads each CPU offers.
> Increases CPU usage.

https://devcenter.heroku.com/articles/dynos#process-thread-limits - 256 threads.

```
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
```

Getting the amount of threads just right is where the fun starts! A thread is the thing that will actually handle the request, so you want as many as possible.

To figure out the most threads your app can achieve until it runs out of memory, you'll need to increase the number of `RAILS_MAX_THREAD` a little, monitor over 24 hours then repeat.

Your configuration does have the option for setting `RAILS_MIN_THREADS`, I don't set this.

## Testing your configuration

To gauge how much traffic a page can realistically take, you can also run [Apache Benchmark](https://www.petefreitag.com/item/689.cfm) to send a bunch of traffic at your dyno to see how it performs:

```
ab -n 100 -c 10 https://your-app.herokuapp.com/
```

This will perform 100 requests at your dyno, performing 10 at a time.

### Barnes

https://github.com/heroku/barnes

Get more insights into your app without to much setup.


## Other notes below.

The amount of threads will vary based on the size of your application, it can 


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

https://devcenter.heroku.com/articles/dyno-types

https://github.com/puma/puma-heroku/blob/master/lib/puma/plugin/heroku.rb


https://github.com/rails/rails/blob/0ee449790b7bd499d26f79228d628af2839f03e3/railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt

https://github.com/puma/puma

https://devcenter.heroku.com/articles/dyno-types

https://github.com/puma/puma-heroku/issues/4
