---
layout: post
title: How To Use List-Unsubscribe Headers In Action Mailer
description: Ever seen "Unsubscribe" links in your email client? Here's how to add them in Rails Action Mailer.
---

Have you ever opened an email & saw there is an "Unsubscribe" link outside of the email contents? I was curious about this recently, and decided to have a little dive into how it works.

![Ruby Weekly has an unsubscribe link in Gmail](/2020/07/ruby-weekly-unsubscribe.png)

Turns out, it was actually pretty straight forward to add via Action Mailer in Rails. It just requires adding a [`List-Unsubscribe`](https://blog.mailtrap.io/list-unsubscribe-header/) header to your mailers.

## The `List-Unsubscribe` header

This header tells emails clients that "This is where to go to unsubscribe from this list", when the user clicks the link they'll either be taken to a URL or the email client will attempt to click it for them.

For best results it's recommended you use both a `mailto` link (Which you could listen to with Action Mailbox) & a HTTP link, e.g:

```
List-Unsubscribe: <mailto: unsubscribe@example.com?subject=unsubscribe>, <http://www.example.com/unsubscribe.html>
```

## Example

```ruby
class SampleMailer < ApplicationMailer

  def unsubscribe_sample(user)
    # You'll need to create a route the user will visit to confirm
    # they'd like to unsubscribe
    unsubscribe_url = user_unsubscribe_url(user)

    # Add the header to the mailer
    headers['List-Unsubscribe'] = "<#{unsubscribe_url}>"
    mail to: user.email
  end
end
```

You'll need to setup a controller (Plus, I'd suggest using a [`signed_id`](https://github.com/rails/rails/pull/39313) in the URL) to handle the user unsubscribing, and store that the user doesn't want to receive that type of email anymore, but I'll leave that up to you.
