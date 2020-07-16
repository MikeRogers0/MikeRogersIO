---
layout: post
title: Monitor Rails memory usage during acceptance tests
description: I had a memory leak in my Rails app and tracked it down using Oink.
---

Receiving an alert that your web app has exceeded its memory usage is no fun, but a few weeks ago I was lucky enough to be woken up to such alerts after a late deploy. The TL;DR: was I had added a bunch of new gems into my rails app and not adjusted the amount of unicorn workers to reflect the extra memory usage. A classic schoolboy error.

This got me thinking that it was crazy to not have been at least monitoring the memory usage increase as part of CI, so I'd know before I deployed the change in the base line memory usage.

## Finding the tool for the job

I went looking for something similar to [simplecov](https://github.com/colszowka/simplecov), but for memory. Unfortunately I couldn't find anything that fitted my needs out of the box.

However I did find [Oink](https://github.com/noahd1/oink), a gem that creates a log of memory usage and then parses that log to generate a report. This handled a a big part of what I needed, so I decided I'll cobble the rest together and see where I end up.

### Setting up Oink

I set up Oink to only log memory while I was running my test suite. I done this by setting up an an initializer ( `config/initializers/oink.rb` ).

```ruby
# This can be added to either:
# config/environments/test.rb
# config/initializers/oink.rb
Rails.application.middleware.use Oink::Middleware if Rails.env.test?
```

Next I only wanted the Oink results from the last run of the test suite, so before each test I cleared all the logs via the `spec/rails_helper.rb` file.

Then once the tests had finished running, I called the terminal command from Rails with a low threshold, this returned the memory usage of each action.

```ruby
RSpec.configure do |config|
  config.before(:suite) do
    `rake log:clear LOGS=oink`
  end

  config.after(:suite) do
    puts ""
    puts `oink --threshold=1 log/oink.log`
  end
end
```

### The output

This is the output I had after running my test suite.

```bash
$ rspec
....................................................................................................
---- MEMORY THRESHOLD ----
THRESHOLD: 1 MB

-- SUMMARY --
Worst Requests:
1. Mar 27 14:14:13, 18432 KB, home#index
2. Mar 27 14:14:12, 16384 KB, contact_us#create
3. Mar 27 14:14:08, 6072 KB, contact_us#create
4. Mar 27 14:14:25, 4204 KB, farms#create
5. Mar 27 14:14:05, 3096 KB, devise/sessions#new
6. Mar 27 14:14:30, 2048 KB, farms#index
7. Mar 27 14:14:07, 1092 KB, active_admin/dashboard#index

Worst Actions:
2, contact_us#create
1, home#index
1, devise/sessions#new
1, active_admin/dashboard#index
1, farms#create
1, farms#index

Aggregated Totals:
Action                             	Max     Mean	Min	Total	Number of requests
contact_us#create                  	16384   11228	6072	22456	2
home#index	                        18432	18432	18432	18432	1
farms#create                  	   	4204	4204	4204	4204	1
devise/sessions#new                	3096	3096	3096	3096	1
farms#index                   	  	2048	2048	2048	2048	1
active_admin/dashboard#index       	1092	1092	1092	1092	1


Finished in 1 minute 26.49 seconds (files took 4.86 seconds to load)
120 examples, 0 failures
Coverage report generated for RSpec to /Users/MikeRogers/Workspace/ExampleApp/coverage. 1528 / 1528 LOC (100%) covered.
```

Pretty handy right?

## How I've been using this

The way I've been keeping an eye on memory usage with this setup is a little crude, but I've been comparing the memory usage change between my master branch and the feature branch before merging.

So far it has been pretty handy to help me catch a few times where I implemented a Gem poorly, furthermore it also helped me track down a few of the more memory loving bits of code.

## Going forward

This setup isn't great (I cobbled it together in an hour trying to find a memory leak), but I think trying to spot memory bloat/leaks before code gets into production is important.  

What I'd like to do is build this as a Gem, where I can simply declare a maximum amount of memory the app is allowed to use during an acceptance test, and if the test goes over that amount the test should fail. If you think that sounds like a good idea, please [@me on Twitter](https://twitter.com/MikeRogers0) and I'll try to get something organised. 
