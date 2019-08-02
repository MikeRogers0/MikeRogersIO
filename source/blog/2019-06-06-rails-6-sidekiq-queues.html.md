---
layout: post
title: Rails 6 Sidekiq Queues
categories:
 – blog
published: true
meta:
  description: Rails 6 has new queues for ActiveStorage & ActionMailbox.
  index: true
---

If you're using Sidekiq with Rails 6 you may find that Rails 6 ships with non-default queue names for things like ActiveStorage and ActiveMailbox.

It's a little hard to find the documentation for the new queue names, but the new ones are:

```
action_mailbox_routing
action_mailbox_incineration
active_storage_analysis
active_storage_purge
```

If you're using sidekiq update your `config/sidekiq.yml` to look a little bit like:

```yml
---
:verbose: false
:concurrency: 1
:max_retries: 3

# Set timeout to 8 on Heroku, longer if you manage your own systems.
:timeout: 8

# Sidekiq will run this file through ERB when reading it so you can
# even put in dynamic logic, like a host-specific queue.
# http://www.mikeperham.com/2013/11/13/advanced-sidekiq-host-specific-queues/
:queues:
  - critical
  - mailers
  - default
  - action_mailbox_routing
  - action_mailbox_incineration
  - active_storage_analysis
  - active_storage_purge
  - low
```

If you're looking for where these are defined, you can see them defined in Rails by calling:

```ruby
ActiveStorage.queues
ActionMailbox.queues[:routing]
ActionMailbox.queues[:incineration]
```
