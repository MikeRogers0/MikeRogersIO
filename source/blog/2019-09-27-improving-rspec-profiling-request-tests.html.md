---
layout: post
title: Improving RSpec Profiling
categories:
 – blog
published: true
meta:
  description: Precompile assets 
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

Some of this slowdown was caused by rails loading everything required to serve a request, but 
