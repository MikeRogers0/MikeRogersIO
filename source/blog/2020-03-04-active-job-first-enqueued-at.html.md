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

I recently had a Ruby on Rails ActiveJob task where I needed to know the exact time when the job was originally enqueued at (i.e. when `perform_later` was called).

Initially I passed an additional argument with the current time to the `perform_later` method call. That solution proved really messy, as I was needlessly passing the same argument in everywhere. It also wasn't particularly quick to implement onto other projects & jobs.

After a bit of exploration through the documentation, I came across a [`enqueued_at`](https://api.rubyonrails.org/classes/ActiveJob/Core.html) method which is available out of the box with ActiveJob. However, as I experimented with this method I noticed if a job had to be retried due to an exception, the `enqueued_at` value would be updated to the time it had been enqueued to be retried again.

## Getting the initial time the job was enqueued

I found the cleanest solution to solve this was to add a little `attr_writer` to my `ApplicationJob` class, which I pass as an extra value in when a job is [serialized](https://github.com/rails/rails/blob/eca6c273fe2729b9634907562c2717cf86443b6b/activejob/lib/active_job/queue_adapters/sidekiq_adapter.rb#L26) & passed onto Sidekiq.

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

Now when whenever I run a job, I have the method `initially_enqueued_at` available to me which returns the time the initial `perform_later` is called.
