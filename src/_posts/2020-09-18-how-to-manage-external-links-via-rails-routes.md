---
layout: post
title: How to manage external links via Rails Routes
description: Linking to a 3rd party site & want to a nifty helper method? Here is a neat trick I found to solve this.
---

Linking to external sites in Rails is pretty easy, you can normally just drop the URL as a string into your code & you're good to go.

However, in a recent project I had a bunch of external links that would be used multiple times within within the application, and were highly likely to change in the future. So managing them from a single location was quite important.

I discovered this neat trick within Rails Routes which allows you to reference external links & have them output a full URL.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Define your route with the to, host & protocol set
  get 'contact',
    to: redirect('https://example.com/contact'),
    protocol: 'https://',
    host: 'example.com',
    as: :example_contact
end
```

The above would create route, that when you call `example_contact_url` it'll return the full external URL, e.g:

```bash
$ Rails.application.routes.url_helpers.example_contact_url
# Outputs: https://example.com/contact
```
