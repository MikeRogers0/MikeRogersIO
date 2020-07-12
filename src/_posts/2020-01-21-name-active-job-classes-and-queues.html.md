---
layout: post
title: How to name Active Job Classes and Queues
categories:
 – blog
published: true
meta:
  description: Strategies for name spacing Active Job queues & class names.
  index: true
---

TL;DR: Name your class after it's arguments, and the queue by the class name.

Naming Active Jobs and Queues is tricky, it's pretty easy to get yourself into a pickle of queue names that are vague & classes that are unclear.

Recently I was looking through the [Rails Active Storage](https://guides.rubyonrails.org/configuring.html#configuring-active-storage) documentation, I noticed they had given the class `ActiveStorage::AnalysisJob` the queue `active_storage_analysis`. Looking a bit deeper I noticed they had followed this pattern in the other Active Storage job classes, and Action Mailbox Active Job classes.

I really liked this pattern, and started applying it to my rails projects. Here are the two strategies which led to much cleaner code.

## Naming the Active Job class

Opening the `app/jobs` folder and seeing an unorganized mess is a little intimidating. I started using the first argument (most often a Active Record model), then what it's doing as the second aspect of the name.

For example, if you have a job that took the User model and enriched the data you had on it, you'd end up with something like:

```ruby
# In app/jobs/user/enrichment_job.rb
class User::EnrichmentJob < ApplicationJob
  queue_as :user

  def perform(user)
    # Do some magic.
  end
end
```


## Naming the queues

It's pretty tempting to dump everything into the `default` queue, but that can become problematic when quick running jobs get stuck waiting for a slower job to finish.

I use the approach of naming my queues based on the class name, using each namespace as a level of Granularity. For example:

```ruby
# In app/jobs/user/enrichment_job.rb
class User::EnrichmentJob < ApplicationJob
  # Group them by the folder name
  queue_as :user

  # Be more specific if I want to run it in a dedicated worker.
  # queue_as :user_enrichment
end
```
