---
layout: post
title: Improving RSpec's Profiling by compiling assets
categories:
 – blog
published: true
meta:
  description: Compiling my test assets before running specs saved a few seconds.
  index: true
---

I've recently started profiling a lot of my RSpec tests (Mostly due to my work on [PigCI](https://pigci.com)) to help identify the tests that are weirdly slow.

Profiling in RSpec is fairly straightforward todo, you just need to run the following command and it will return the 10 most slowest tests, after running your tests in a random order:

```bash
bundle exec rspec --profile --order=random
```

## The first test anomaly

I was profiling my tests, when I noticed that is the first request test was consistently slower then it should've been. This bugged me a lot, the order the tests ran in shouldn't affect the amount of time they take.

Initially I thought the slowdown was caused by rails loading classes and such. However when I looked more closely, it was only the tests where the views had a link to an asset file (e.g. the CSS file) that were actually lagging. So I concluded it was probably the assets being compiled which caused the lag I was experiencing.

## The Solution

I really wanted to solve this issue, and the fix was actually pretty easy. If I just precompiled the assets before running the profiler, I would get much more accurate results. So now before running the RSpec profiler I run:

```bash
bundle exec rake assets:precompile RAILS_ENV=test
```

This makes the profiling results way more consistent.
