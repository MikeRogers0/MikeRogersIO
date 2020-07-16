---
layout: post
title: Building internet safe addresses for ActionMailer using Mail::Address
description: Sometimes you need to pass in some funky characters to your mail parameters, use Mail::Address to do it safely.
---

Recently I needed to send emails on behalf of my users, using their full name and email.

I could just pass their unsanitized input into a string like `Full Name <name@example.com>`, then hand that off to ActionMailer. However, I had a bunch of users with names that included characters such as `@` and `<`, so I went searching for a safer solution.

What I discovered was that [Mail](https://github.com/mikel/mail) (which ships with Rails and does the actual sending of emails) has a super handy [Mail::Address](https://github.com/mikel/mail/blob/7c2bc2e4ac2760061ad6f26fcea0e9aef1f6bb72/lib/mail/elements/address.rb#L16) class, which can build internet safe email addresses.

## Example Usage

To build an internet safe address for ActionMailer, you can use the tap method like so:

```ruby
Mail::Address.new.tap do |m|
  m.address = 'name@example.com'
  m.display_name = 'Super <@>, Name'
end.to_s

# Outputs: "\"Super <@>, Name\" <name@example.com>"
```

### How to use with ActionMailer

To use this address in the "from" field in an email, just pass the output of `to_s` to the `from` argument when sending an email. Like this:

```ruby
class GuestMailer < ApplicationMailer
  def get_hyped
    user_address = Mail::Address.new.tap do |m|
      m.address = 'name@example.com'
      m.display_name = 'Super <@>, Name'
    end.to_s

    mail to: 'guest@example.com', from: user_address
  end
end
```
