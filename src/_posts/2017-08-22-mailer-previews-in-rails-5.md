---
layout: post
title: Mailer Previews in Rails 5
description: How to share Rails 5 mailer previews in a staging environment
---

One of the best features of Ruby on Rails when developing locally is the [Preview Email](http://guides.rubyonrails.org/action_mailer_basics.html#previewing-emails) feature, along with [premailer](https://github.com/fphilipe/premailer-rails) it really makes building out mailers super easy.

However, I like to enable mailer previews in my apps staging environments. Primarily this is so clients can confidently sign off mailers and if required, easily communicate amends.

To achieve this I use the following snippet of code in `config/environments/production.rb`:

```ruby
# Enable preview mailers
# Add the ENABLE_MAILER_PREVIEWS to your environment to enable.
if ENV['ENABLE_MAILER_PREVIEWS'].present?
  config.action_mailer.show_previews = true

  # If you're using RSpec make sure to add the link changing where the previews path is.
  config.action_mailer.preview_path ||= defined?(Rails.root) ? "#{Rails.root}/spec/mailers/previews" : nil
end
```

Then I just set `ENABLE_MAILER_PREVIEWS` to `true` in my Heroku Apps Config Variables and I'm good.
