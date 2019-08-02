---
layout: post
title: Setting up Heroku release tasks for Ruby on Rails
categories:
 – blog
published: true
meta:
  description: Run migrations, clear caches and other things without downtime when deploying.
  index: true
---

When I first started deploying my sites to Heroku, I'd have to run migrations. After a bit of code hammering, I was pretty happy to push my code, then run migrations in a one off dyno (`heroku run rails db:migrate`), then maybe restart my dynos (`heroku restart`).

Then I was shown release tasks and it blew my cotton socks off!

## What are release tasks?!

Release tasks run after your app has been built, but just before it goes out to the web. If any of your tasks fail, the deploy will be cancelled, keeping the old version of your app in place.

This is awesome! It means you can have zero downtime deploys.

## Creating release tasks

When you deploy, Heroku looks for a `release` command in your Procfile. So if you'd like to run migrations on every deploy, you can update your `Procfile` to have this line:

```
release: bundle exec rails db:migrate
```

However, I like to store my commands in a shell script, then have them run only if they're enabled by environmental variables.

To do this as well, create a `release-tasks.sh` file, and make sure it has executable permissions:

```bash
touch release-tasks.sh && chmod 0777 release-tasks.sh
```

Then append this line to your `Procfile`:

```
release: bash ./release-tasks.sh
```

## Running tasks based on environmental variables

It's pretty advantageous to be able to control which commands are able to run based on your environment setup, e.g. you might want to notify external APIs of a production deploy, but not when you've built a review app. Alternatively you might just not want to seed production.

To do this, you can set a "Config Variable" (environmental variable) in your Heroku app settings, with the name `RUN_MIGRATIONS_DURING_RELEASE` with the value of `true`. Then when that variable is true, you can ask your `release-tasks.sh` to run a command around that.

Here is my current `release-tasks.sh` file which I normally add to my Rails 5 projects:

```bash
#!/bin/bash

echo "Running Release Tasks"

if [ "$RUN_MIGRATIONS_DURING_RELEASE" == "true" ]; then
  echo "Running Migrations"
  bundle exec rails db:migrate
fi

if [ "$SEED_DB_DURING_RELEASE" == "true" ]; then
  echo "Seeding DB"
  bundle exec rails db:seed
fi

if [ "$CLEAR_CACHE_DURING_RELEASE" == "true" ]; then
  echo "Clearing Rails Cache"
  bundle exec rails r "Rails.cache.clear"
fi

echo "Done running release-tasks.sh"
```
