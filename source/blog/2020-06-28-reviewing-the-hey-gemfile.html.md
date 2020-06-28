---
layout: post
title: Reviewing The HEY Gemfile
categories:
 – blog
published: true
meta:
  description: DHH posted the HEY Gemfile, here are some notes I made about it.
  index: true
---

I love digging through other peoples Ruby on Rails apps, seeing how other people approach their code is very insightful.

When DHH [tweeted about they HEY stack](https://twitter.com/dhh/status/1275901955995385856), including the [Gemfile](https://gist.github.com/dhh/782fb925b57450da28c1e15656779556) I was hyped! It's really interesting to see what tools helped build a high scale application.

As I went through, I made a few notes and I thought I should share the main things that interested me.

## MySQL Database & Elasticsearch

This surprised me the most, I've not encountered a Rails project that doesn't use PostgreSQL for years. I'm not alone, in 2018 [85% of Rails developers](https://rails-hosting.com/2018/) preferred PostgreSQL, more recently [on /r/rails](https://www.reddit.com/r/rails/comments/h9tsrj/mysql_vs_postgresql_for_production/) I couldn't see anyone recommending MySQL.

From what I gather, this choice was influenced by two main choices:

1. Basecamp uses MySQL on all their other products, so the team is familiar with it.
2. DHH mentioned they use [Vitess](https://vitess.io/) for sharding MySQL. So they have an approach for scaling it.

Hopefully they'll release some more information about this choice & how it compares at scale.

Like a lot of other projects with a search, they've used [Elasticsearch](https://github.com/elastic/elasticsearch-rails) over searching the database directly. On my projects I normally lean on [pg_search](https://github.com/Casecommons/pg_search) & [ransack](https://github.com/activerecord-hackery/ransack) for as long as I can, then make the move to Elasticsearch when I need a better full text search. As they're searching lots of different models, this is a fairly expected choice.

## Resque for Active Job & Scheduled Tasks

Historically Sidekiq has had [greater market share](https://rails-hosting.com/2018/) and I've read [that developers are moving from Resque to Sidekiq](https://dev.to/molly_struve/switching-from-resque-to-sidekiq-3b04). As a result, I've always thought that Sidekiq was the preferred choice for running background tasks, so seeing HEY is using Resque is neat.

I've not used Resque on a project yet, but I'm curious to give it a try. I can imagine if Basecamp are using it, it could gain in popularity. Plus grand scheme of things because Active Job makes it so easy to switch between worker gems, it's really like comparing apples & pears.

It is kind of cool to see they're using [resque-scheduler](https://github.com/resque/resque-scheduler), which means they're storing scheduled jobs in a YAML file within their codebase. I've used [sidekiq-cron](https://github.com/ondrejbartas/sidekiq-cron) on my projects, so it's pretty easy to switch between the two gems.

## AWS & Kubernetes

I've become a huge fan of using docker containers for my Ruby on Rails apps this year. As soon as I started using them, I wanted to use them for everything.

In April 2020 Basecamp blogged about [how they use Kubernetes](https://m.signalvnoise.com/seamless-branch-deploys-with-kubernetes/), which reminded me of the Heroku Pipeline, where it's super easy to deploy review & production apps.

I'm speculating a lot, but I suspect the `haybales` gem is a replacement for `capistrano` or at least some guidance in how to deploy to Kubernetes. I'd really like to see some advances to the "getting your app online" side of Rails, I feel like it's one of the current aspects of Rails without clear guidance, as a result developers end up doing some really odd things.

## Frontend

There has been a lot of written about the [changes coming to Turbolinks](https://dev.to/borama/a-few-sneak-peeks-into-hey-com-technology-iii-turbolinks-frames-5e4a). It appears to offer some quite nice ways to create a rich HTML experience without much JavaScript overhead. Which should be great!

I was a little surprised to see Sprockets & SASS was still present within the Gemfile. I somewhat expected them to say "We used PostCSS over SASS now", or even "We used plain CSS" now that CSS Variables make that such an appealing option.

## Testing

I've always been a fan of using [RSpec](https://github.com/rspec/rspec-rails) to test my code as I've found it more expressive, but it's no surprise that HEY is tested using the Rails default testing framework (Minitest).

I did find it kind of cool that the gems [mocha](https://github.com/freerange/mocha), [webmock](https://github.com/bblimke/webmock) & [vcr](https://github.com/vcr/vcr) (Which are pretty much in all my projects) are also being used. It's fairly validating to know we don't need a lot of gems to test our code, and for mocking API endpoints we all use the same gems.

## Code Insights

It was impressive to see the amount of gems they use to get more insight into their codebase. Between using [Sentry](https://sentry.io/welcome/) for tracking exceptions, [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) (I think in production) for seeing where rendering time was spent, along with the other profiling & logging gems, it's been quite positive to see they're clearly aiming to write high performance code.

It was also quite cool to see that they're using linters such as [rubocop](https://github.com/rubocop-hq/rubocop) to help monitor their codebase.

## Other Handy Gems

The coolest gem I didn't know about & want to start using right away is [pwned](https://github.com/philnash/pwned). It lets you check if a password is in the [Have I Been Pwned: Pwned Passwords Database](https://haveibeenpwned.com/Passwords), this means you can check if a user is using an unsecure password & help them use something better.

The [geared_pagination](https://github.com/basecamp/geared_pagination) they've released is a massive time saver. Previously I've used messy code on top of [kaminari](https://github.com/kaminari/kaminari) or [will_paginate](https://github.com/mislav/will_paginate) to dynamically adjust the number of items on the first page of a collection. Having a gem to handle that makes me a very happy developer.

A few months ago I needed to encrypt API credentials that were being stored in the database, the options were pretty few & far between (lots of gems hadn't been updated in years!). I ended up using [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted), though it looks like HEY has made their own gem (`active_record_encryption`) to handle this.
