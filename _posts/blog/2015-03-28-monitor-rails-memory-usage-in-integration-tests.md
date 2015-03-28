---
layout: post
title: Monitor Rails memory usage during acceptance tests
categories:
 – blog
published: true
meta:
  description: I had a memory leak in my Rails app and tracked it down using Oink.
  index: true
---

Receiving an alert that your web app has exceeded its memory usage is no fun, but a few weeks ago I was lucky enough to be woken up to such alerts after a late deploy. The TL;DR: was I had added a bunch of new gems into my rails app and not adjusted the amount of unicorn workers to reflect the extra memory usage. A classic schoolboy error.

This got me thinking that it was crazy to not have been at least monitoring the memory usage increase as part of CI, so I'd know before I deployed the change in the base line memory usage.

## Finding the tool for the job

I went looking for something similar to [simplecov](https://github.com/colszowka/simplecov), but for memory. Unfortunately I couldn't find anything that fitted my needs out of the box.

However I did find [Oink](https://github.com/noahd1/oink), a gem that creates a log of memory usage and then parses that log to generate a report. This handled a a big part of what I needed, so I decided I'll cobble the rest together and see where I end up.

### Setting up Oink

I set up Oink to only log memory while I was running my test suite. I done this by setting up an an initializer ( `config/initializers/oink.rb` ).

{% gist 1da6a53cd0d626dbde5f oink.rb %}

Next I only wanted the Oink results from the last run of the test suite, so before each test I cleared all the logs via the `spec/rails_helper.rb` file.

Then once the tests had finished running, I called the terminal command from Rails with a low threshold, this returned the memory usage of each action.

{% gist 1da6a53cd0d626dbde5f rails_helper.rb %}


### The output

This is the output I had after running my test suite.

{% gist 1da6a53cd0d626dbde5f example_output.txt %}

Pretty handy right?

## How I've been using this

The way I've been keeping an eye on memory usage with this setup is a little crude, but I've been comparing the memory usage change between my master branch and the feature branch before merging.

So far it has been pretty handy to help me catch a few times where I implemented a Gem poorly, furthermore it also helped me track down a few of the more memory loving bits of code.

## Going forward

This setup isn't great (I cobbled it together in an hour trying to find a memory leak), but I think trying to spot memory bloat/leaks before code gets into production is important.  

What I'd like to do is build this as a Gem, where I can simply declare a maximum amount of memory the app is allowed to use during an acceptance test, and if the test goes over that amount the test should fail. If you think that sounds like a good idea, please [@me on Twitter](https://twitter.com/MikeRogers0) and I'll try to get something organised. 
