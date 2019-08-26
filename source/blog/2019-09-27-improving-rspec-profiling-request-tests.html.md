---
layout: post
title: Improving RSpec Profiling
categories:
 – blog
published: true
meta:
  description: Compiling my test assets before running specs saved a few seconds.
  index: true
---

I've recently been profiling a lot of my RSpec tests (Mostly due to my work on [PigCI](https://pigci.com)) to help identify the tests that are weirdly slow.

To profile you rspec tests, you just need to run:

```bash
bundle exec rspec --profile --order=random
```

This will run your RSpec tests in a random order, and output the 10 most slowest tests.

## Request tests were had an anomaly

One thing I noticed was the first request test would always take a few seconds longer then compared to if it hadn't run first.

Some of this slowdown was caused by rails loading everything required to serve a request, but a good chunk of it was caused by assets being compiled.

## The fix

If each time you run the test suite it adds a few seconds out of nowhere, that sucks. So I started compiling my test assets by running:

```bash
bundle exec rake assets:precompile RAILS_ENV=test
```

This would make my profiling results a little more consistent.
