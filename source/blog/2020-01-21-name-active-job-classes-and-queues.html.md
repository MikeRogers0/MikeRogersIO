---
layout: post
title: How to name ActiveJob classes and queues
categories:
 – blog
published: true
meta:
  description: Strategies for name spacing ActiveJob queues & class names.
  index: true
---

TL;DR: Name your class after it's arguments, and the queue on the class name.

Naming ActiveJobs and Queues is tricky, it's pretty easy to get yourself into a pickle of queue names that are vague & classes that are unclear.

Recently I came across a pattern that feels like it helps name the queue & gives a good hint to what an ActiveJob should do.

## Naming the ActiveJob class

Use the first argument (most often a ActiveRecord model), then what it's doing as the second aspect of the name. For example, if you have a job that took the User model and enriched the data you had on it, you'd end up with something like:

```ruby
# In app/jobs/user/enrichment_job.rb
class User::EnrichmentJob < ApplicationJob
```

Opening the `app/jobs` folder and seeing an unorganized mess is a little intimidating. I'm a fan of organising your jobs in this way as each folder is clear as to the object it's about to work with.

## Naming queues

It's pretty temping to dump everything into the `default` queue, but that can become problematic when quick running jobs get stuck waiting for a slower job to finish. I use the approach of naming my queues based on the class name, then if it's slow being more specific so I can run it in its own worker. For example:

```ruby
# In app/jobs/user/enrichment_job.rb
class User::EnrichmentJob < ApplicationJob
  # Group them by the folder name
  queue_as :user

  # Be more specific if I want to run it in a dedicated worker.
  # queue_as :user_enrichment
end
```

## Who else does this?

I started doing this after I noticed [Rails ActiveStorage](https://guides.rubyonrails.org/configuring.html#configuring-active-storage) uses the queue names `active_storage_analysis` & `active_storage_purge`.
