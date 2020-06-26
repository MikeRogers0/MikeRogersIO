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

## MySQL over Postgres

Vitess

## Turbo

New turbolinks gem maybe?

## pwned - Better password security

## No Devise?

They custom rolled their own users stuff?

## Resque over Sidekiq

Weird.

## resque-scheduler & resque-web

Kind of cool, should mean crons are in the repos

## elasticsearch - Search

Better then Solr

## sentry

Loads of options for tracking errors, Sentry has been a fav of mine so woop!

## Instrumentation & Profiling

No NewRelic - yay

## Braintree over stripe

It looks like they've updated the queenbee gem to handle billing.

## geared_pagination

Just a really cool gem.

## active_record_encryption

Over attr_encrypted?! 

## Linters

Weird they've not got down with using github actions for these yet.

## haybales

https://m.signalvnoise.com/seamless-branch-deploys-with-kubernetes/

## Not using RSpec

LAME.
