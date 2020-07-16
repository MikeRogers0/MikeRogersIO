---
layout: post
title: How to Speed Up Heroku CI via In Dyno Databases
description: My tests were feeling very slow in Heroku CI, I got a 2x speedup by changing one line of code.
---

Heroku is a fantastic service if you're looking for a place to put your Ruby on Rails apps. In 2017 they release a CI service which I've found to be pretty low cost.

Quite recently I was working on a project that used Heroku CI to run it's test suite before deploying. However, I noticed that the tests were taking a long time to run. On a given day they'd take anywhere from 40 minutes to 20 minutes.

For me, a test suite taking longer than the time it takes to make a cup of coffee is a bad test suite, so I got digging into what was going on.

## The cause of the slowdown

A slow test suite isn't great, but big fluctuations are a worry. Initially I thought it might have been the app making unnecessary calls to a 3rd party service. However, it turned out to be something much more simple to fix.

Heroku CI is designed to match your app environment as closely as possible, this includes a database on a separate machine. This meant every database call would have to go from the test dyno, into the cloud and then back again.

This meant if the Heroku CI network was carrying a lot of traffic, the test suite would start slowing down.

## The fix (In-Dyno Databases)

I found a brilliant article from Heroku on [how to host your database on the same dyno your tests are running on](https://devcenter.heroku.com/articles/heroku-ci-in-dyno-databases), which suggested I update my `app.json` file to replace the `heroku-postgresql` addon with the `heroku-postgresql:in-dyno` addon. So my `environments` attribute, now looked like:

```json
{
  "environments": {
    "test": {
      "addons": ["heroku-postgresql:in-dyno", "heroku-redis:in-dyno"]
    }
  }
}
```

After making the change, my test suite ran in 10 minutes! Fantastic!
