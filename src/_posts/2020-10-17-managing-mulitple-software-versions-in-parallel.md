---
layout: post
title: Managing Multiple Software Versions in Parallel
description: I use both Docker & asdf, they're pretty nifty!
---

Quite often as a developer I'll work on projects which require different combinations of software versions. For example, I could have a project written in Ruby 2.6 running on Postgres 9 & using Yarn 1.10, while another might be a bit more up-to-date.

Normally I try to keep things up to date, but for some projects it isn't economical to keep every project on the latest & greatest, so being able to run multiple software versions is essential.

## How I Handle It

Previously I was primary a Ruby Developer, so I moved from RVM to [rbenv](https://github.com/rbenv/rbenv), both of which were quite good.

However as I'm often using a mix of languages now, I've started using (the terribly named) [asdf](https://asdf-vm.com/#/) version manager as it supports lots of languages.

I like asdf, as it uses a [plugin](https://github.com/asdf-vm/asdf-plugins) approach to support multiple languages. This means that I can explore new languages without having to jump through hoops to get them up and going.

## What About Services Like PostgreSQL & Redis?

In the past I used to just install PostgreSQL & Redis via homebrew, which worked right up until I had a project where my local version of PostgreSQL didn't match production & I managed to ship broken code into production.

Now locally, I use [Docker Compose](https://docs.docker.com/compose/) to spin up the services I need. It's pretty nice because per a project, I can exactly match the production version of a piece of software.

Normally if I'm using Docker Compose on a project, I run everything though it (e.g. turning on my Rails server, ngrok & the worker server). That said, I normally try to configure my apps to be docker agnostic, so if I only wanted to use docker for PostgreSQL that would be OK.
