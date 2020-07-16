---
layout: post
title: Don't just [FILTER] passwords by default, filter tokens and keys!
description: Update your config.filter_parameters to have sensible defaults, so logs don't have sensitive information in them.
---

I've picked up a lot of Rails projects while being a contractor. Almost always, I can grantee that the `config/initializers/filter_parameter_logging.rb` will be pretty much untouched, and probably will have the commit message of "Initial commit".

This is a massive shame, as it's responsible for deciding which parameters are replaced with `[FILTERED]` in logs, and really should be updated to include a lot more parameters.

## My new default

Instead of hoping people remember to add sensitive parameters while developing, I work on the assumption that most apps will connect to Stripe, have an API and use Devise.

When I start or take on a project, I just replace this file to include the parameters often passed by Stripe, APIs and Devise. Like this:

```ruby
# config/initializers/filter_parameter_logging.rb
# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [
  :password,
  # Stripe
  :stripe_card_token, :stripe_publishable_key,
  # An API
  :access_token, :refresh_token,
  # Devise
  :confirmation_token
]
```

## What I'd like to see in the future

Developers manually updating the `filter_parameter_logging.rb` file is a is a good start, but if the `rails new` project template included a few more common keys, I think we'd be in a very good place.

I'd also really like to see more gems just appending their sensitive parameters to the `filter_parameters`.
