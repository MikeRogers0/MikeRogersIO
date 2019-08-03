---
layout: post
title: Testing Rails Action Mailbox with RSpec
categories:
 – blog
published: true
meta:
  description: Rails 6 ships with Action Mailbox, here is how I added tests for RSpec
  index: true
---

Rails 6 ships with some pretty nice new features, the main one I'm pretty excited about is [Action Mailbox](https://edgeguides.rubyonrails.org/action_mailbox_basics.html), however writing RSpec tests for it requires a little bit of extra setup.

## Add the support helper

First create a file in `spec/support/mailbox.rb`, inside it add:

```ruby
# spec/support/mailbox.rb
require 'action_mailbox/test_helper'

RSpec.configure do |config|
  config.include ActionMailbox::TestHelper, type: :mailbox
end
```

This will include the [ActionMailbox::TestHelper](https://rubydocs.org/d/rails-6-0-0-rc1/classes/ActionMailbox/TestHelper.html) module, this adds methods like `receive_inbound_email_from_source` for use in your tests.

## A sample RSpec Test

I've been using `type: :mailbox` and putting  them in the `spec/mailboxes/` folder, a sample looks like:

```ruby
# spec/mailboxes/generic_emails_mailbox_spec.rb
require 'rails_helper'

RSpec.describe GenericEmailsMailbox, type: :mailbox do
  subject do
    receive_inbound_email_from_mail(
      from: 'from-address@example.com',
      to: 'to-address@example.com',
      subject: 'Sample Subject',
      body: "I'm a sample body"
    )
  end

  it do
    expect { subject }.to change(SomeModel, :count).by(1)
  end
end
```

## Fixing "NotImplementedError"

If you hit an error that looks like:

```
NotImplementedError:
   Use a queueing backend to enqueue jobs in the future.
```

This means you're using Active Job in inline mode in your tests, which doesn't play nicely with with Active Mailbox. I fixed this by setting `config.active_job.queue_adapter` in my test environment to be `:test`.

```ruby
# config/environments/test.rb
# Run Active Job in test mode.
config.active_job.queue_adapter = :test
```
