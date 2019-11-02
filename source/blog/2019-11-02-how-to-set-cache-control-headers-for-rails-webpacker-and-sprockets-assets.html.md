---
layout: post
title: How to set "Cache-Control" headers for Rails Webpacker & Sprockets Assets
categories:
 – blog
published: true
meta:
  description: Fix that pesky "Serving static assets with an efficient cache policy" PageSpeed suggestion.
  index: true
---

If you've ever run a fairly bog standard Ruby on Rails application through a Page Speed testing service (like [Google PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/)), you'll most likely see a suggestion like:

> Serve static assets with an efficient cache policy

This is because Rails ships with fairly vanilla headers for it's assets, as quite often services like Nginx will override headers provided by the app. However services like Heroku will totally honour the custom header you add in your Ruby on Rails app.

To fix this issue, I normally add a file to my `config/initializers` folder to set sensible headers on all my Rails assets:

```ruby
# Add this to config/initializers/assets_cache_headers.rb

# This will affect assets served from /app/assets
Rails.application.config.static_cache_control = 'public, max-age=31536000'

# This will affect assets in /public, e.g. webpacker assets.
Rails.application.config.public_file_server.headers = {
  'Cache-Control' => 'public, max-age=31536000',
  'Expires' => 1.year.from_now.to_formatted_s(:rfc822)
}
```

After this file is added, the assets will ask the browser to cache them for a year. This solves that PageSpeed suggestion.
