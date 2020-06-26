---
layout: post
title: HEYs Gemfile
categories:
 – blog
published: true
meta:
  description: DHH posted HEY's Gemfile, here's a review of it.
  index: true
---

I love digging through other peoples Rails apps, it can be super insightful seeing how other people approach their apps.

DHH [tweeted about they HEY stack](https://twitter.com/dhh/status/1275901955995385856), including the [Gemfile](https://gist.github.com/dhh/782fb925b57450da28c1e15656779556) which gave us a pretty good insight into how HEY has been put together.

Jumping in, here are my thoughts on the various gems they used :D

### MySQL over PostgreSQL

This surprised the most, I've not encountered a Rails project that doesn't use PostgreSQL for years. I'm not alone, in 2018 [85% of Rails developers](https://rails-hosting.com/2018/) preferred PostgreSQL.

DHH does mention they use [Vitess](https://vitess.io/) for sharding, so this choice could have been because it's easier to move between Clouds & plays nicely with Kubernetes.

### Haybales

I'm excited about this, in April Basecamp blogged about [how they use Kubernetes](https://m.signalvnoise.com/seamless-branch-deploys-with-kubernetes/), which reminded me a lot of my Heroku Pipeline setup.

I'm speculating a lot, but I suspect the `haybales` gem is a replacement for `capistrano` or at least some guidance in how to deploy to Kubernetes.

### Resque over Sidekiq

Both Resque & Sidekiq are both good choices for handing background tasks, both have wrappers within the Rails core for ActiveJob. That said, [historically Sidekiq](https://rails-hosting.com/2018/) has had greater market share.

While I've only really used Sidekiq in production, I think it could be a good time to invest in Resque as if Basecamp are using it, it'll probably gain in popularity.

### resque-scheduler & resque-web

Like Sidekiq, Resque has gems which allows for setting up a Web UI & storing scheduled tasks in your codebase via a YAML file.

### Elasticsearch

There are a bunch of ways to make searching your database in (Solr, [pg_search](https://github.com/Casecommons/pg_search) & [ransack](https://github.com/activerecord-hackery/ransack) come to mind).

I'd imagine they've used Elasticsearch because it's better at full text search then a complex SQL query.

## Frontend

### SASSC & Webpacker

I didn't expected to see sprockets or SASS at all in HEY at all. Looking at their CSS, it looked like they had fully embraced CSS Variables and I somewhat expected them to say "We're using PostCSS".

### Turbo

We know that a new Turbolinks is in the works, so this is probably it. I've been pretty impressed with some of the [things people are finding](https://dev.to/borama/a-few-sneak-peeks-into-hey-com-technology-iii-turbolinks-frames-5e4a) it helps with.

It looks like we might have a super-low effort way of making webpages feel realtime, which should be really fun!

## Security

### pwned - Better password security

This was one coolest gems I'm planning to start using right away! [pwned](https://github.com/philnash/pwned) let's you check if a password is in the [Have I Been Pwned: Pwned Passwords Database](https://haveibeenpwned.com/Passwords), this means you can check if a user is using an unsecure password.

This means we can nicely encourage users to use better passwords within our apps. Awesome stuff!

### No Devise?

When I was digging through their login screen, I was pretty convinced I was looking at something powered by [Devise](https://github.com/heartcombo/devise).

I've always been super wary of custom rolling my own user authentication system as I'd rather put my faith in something battle tested by thousands of other developers. That said, HEY is a very experienced set of developers so I can imagine they know their stuff & wanted to control the experience more.

### active_record_encryption

When I needed to encrypted API credentials in a database, the options were pretty few & far between (lots of gems hadn't been updated in years!).

I had been using [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted) to handle encrypting fields in the database. It looks like for HEY, they've made their own gem to handle it.

## Other stuff

### geared_pagination

Pagination is really tricky, most the gems out there ([kaminari](https://github.com/kaminari/kaminari) & [will_paginate](https://github.com/mislav/will_paginate)) are designed to only show the same amount of items per a page. So unless you want to do lots of extra code, you're stuck.

I really want to use [geared_pagination](https://github.com/basecamp/geared_pagination) in future projects. It allows you to comfortably vary the amount of objects per a page, based on a ratio. It looks to only support ActiveRecord, but it's pretty handy regardless.

### Braintree over Stripe

It looks like they've made their own gem (`queenbee`) for Braintree to handle subscriptions. I did expect them to use Stripe for payments, as it has a few up-to-date Ruby gem.

## Code Management

### Sentry

I use [Sentry](https://sentry.io/welcome/) for tracking all my apps (It integrates nicely with Slack/Email), so it's quite neat to know they're using the same service for logging exceptions.

### Instrumentation & Profiling

I always add [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) in development to help monitor for N+1s and such. Their Gemfile suggests they use it & a few others in production.

### Linters

I love linters, I think they're a brilliant way to progress as a developer & help keep standards high (along with find the odd short coming with my code).

It's quite cool to see they only use a few linters and most are focused on security & performance.

## Testing

### Not using RSpec

Personally I prefer to use [RSpec](https://github.com/rspec/rspec-rails) to test my Ruby apps as I find it more expressive. But it's quite cool to see they only require a few fairly common gems ([mocha](https://github.com/freerange/mocha), [webmock](https://github.com/bblimke/webmock) & [vcr](https://github.com/vcr/vcr)) on top of the default Rails testing stuff.
