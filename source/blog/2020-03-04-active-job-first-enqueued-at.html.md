---
layout: post
title: How to get the time an ActiveJob was enqueued at
categories:
 – blog
published: true
meta:
  description: Knowing the exact time you queued up a background job is handy, here is how to get it in Ruby on Rails ActiveJob.
  index: true
---

I had a really cool Ruby on Rails ActiveJob task recently where I needed to know the exact time when the job was originally enqueued at (i.e. when `perform_later` was called).

Initially I passed an argument with the current time when I call `perform_later`. That solution proved really messy, as every time I queued up the job I had to pass the additional time argument. It also wasn't very easy to quickly implement onto other projects & jobs.

After a bit of documentation exploration, I then came across a [`enqueued_at`](https://api.rubyonrails.org/classes/ActiveJob/Core.html) method which is available out of the box with ActiveJob. However, as I experimented with this method I noticed in the event of a job retried due to an exception the `enqueued_at` value would be updated.

## Getting initial time the job was enqueued

I found the cleanest solution to solve this was to add a little `attr_writer` to my `ApplicationJob` class, which we use to add an extra value in when a job is [serialized](https://github.com/rails/rails/blob/eca6c273fe2729b9634907562c2717cf86443b6b/activejob/lib/active_job/queue_adapters/sidekiq_adapter.rb#L26) & passed onto Sidekiq.

```ruby
# app/jobs/application_job.rb
class ApplicationJob < ActiveJob::Base
  attr_writer :initially_enqueued_at

  def initially_enqueued_at
    @initially_enqueued_at ||= Time.zone.now
  end

  def serialize
    super.merge('initially_enqueued_at' => initially_enqueued_at)
  end

  def deserialize(job_data)
    super
    self.initially_enqueued_at = job_data['initially_enqueued_at']
  end
end
```

Now when whenever I run a job, I have the method `initially_enqueued_at` which is the time the initial `perform_later` is called.
