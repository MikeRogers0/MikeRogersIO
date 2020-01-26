---
layout: post
title: Decoupling copy from your Ruby on Rails code with I18n
categories:
 – blog
published: true
meta:
  description: I18n is a great way to quickly translate your app, but it's also a great way to tidy up your code.
  index: true
---

One feature that's really underutilised by Ruby on Rails developers is the [Internationalization (I18n) API](https://guides.rubyonrails.org/i18n.html). This API lets you easily translate your application into lots of different languages without any extra code. But more importantly, it's a fantastic way to decouple copy from your code.

In my opinion hard coded copy is a code smell. If you're able to decouple it, you will notice a reduction in code complexity with the happy side effect of easier translation in the future.

It's really hard to pinpoint why developers don't often use I18n, though from my experience I think the lack of usage is caused by:

  1. It's a little unclear what key an object is using to lookup its translation value.
  2. Very few tutorials & sample code demonstrate I18n, so lots of developers haven't had much exposure to it.
  3. The locale files can become disorganised very easily as out of the box rails doesn't look in subfolders of `config/locales/` for definitions.

## Making I18n easier to manage

The first step to make I18n more easier to work with is to tweak your Rails setup. By improving your vision of what I18n is doing & making the files easier to organise, I18n becomes a lot easier to default to.

### Outputting I18n lookups to logs

From a blank application it's a little tricky to know what Rails is doing under the hood with the I18n library. One way to make it more obvious where rails is looking for translations is by the [`i18n-debug`](https://github.com/fphilipe/i18n-debug) gem.

Add it to your projects Gemfile, restart Rails and then tail your logs:

```bash
tail -f log/development.log | grep "i18n-debug"
```

As you navigate around your application you'll see Rails looking up values in the I18n. It's really awesome!

### Putting locales into subfolders

One out of the box "well this sucks" is that Rails doesn't let you easily break up your locale into lots of small easy to manage nested files.

However this is an easy fix. Add the following line into your `config/application.rb` file:

```ruby
# I18n is better when broken down into multiple folders.
config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
```

This will allow you to break up your locale files into nicely organised subfolders. Awesome!

Most of my apps contain the following files:

```bash
config/locales/en.yml
config/locales/activerecord/user.en.yml
config/locales/activemodel/user_form.en.yml
config/locales/formtastic/user.en.yml
config/locales/flashes/users.en.yml
config/locales/helper/user.en.yml
config/locales/mailers/user_mailer.en.yml
config/locales/views/simple_form/user.en.yml
```

I usually organise my files by the I18n key path, e.g. if the key is `en.activerecord.user.attributes` I'll put the values in the `config/locales/activerecord/user.en.yml` file.

## Examples of I18n in Rails

I try to use I18n where I can in most my Rails projects, here are a few samples based on code I shipped to production which should help you get started.

### Controllers

You can use the [`t` helper method](https://guides.rubyonrails.org/i18n.html#lazy-lookup) in views & controllers. It'll lookup an I18n value with a scope of your current controller & action.

```ruby
class SamplesController < ApplicationController
  def create
    # Look will up flash from:
    # en.flashes.samples.create.notice
    # Which I'd store in the file: config/locales/flashes/samples.en.yml
    redirect_to({ action: :index }, { flash: { notice: t('.notice', scope: :flashes) } })
  end
end
```

For the above example, I scoped it to "flashes", this way I can happily store all my controller flashes within a nice scoped folder, with a file structure like:

```yaml
# config/locales/flashes/samples.en.yml
en:
  flashes:
    samples:
      create:
        notice: 'Sample was created successfully'
```

### Forms

Lots of forms have shortcuts built into them to look to I18n for their copy. Error messages, labels, placeholders & even submit buttons text values can be controlled via I18n.

```erb
<%= form_with model: @user do |f| %>
  
  <!-- en.activerecord.errors.models.sample.attributes.full_name.blank -->
  <%= f.object.errors.collect(&:full_messages) %>

  <!-- en.helpers.label.user.full_name -->
  <!-- en.activerecord.attributes.user.full_name -->
  <%= f.label :full_name %>

  <!-- en.helpers.placeholder.user.full_name -->
  <%= f.text_field :full_name, placeholder: true %>

  <!-- en.helpers.submit.user.create -->
  <%= f.submit %>
<%= end %>
```

### Mailers

You can use I18n for the subject lines of mailers either by not passing the `subject` argument, or by passing [`default_i18n_subject`](https://api.rubyonrails.org/v6.0.1/classes/ActionMailer/Base.html#method-i-default_i18n_subject) with a few values.

```ruby
class SampleMailer < ApplicationMailer

  def hello_world
    # Subject will be looked up at: en.sample_mailer.hello_world.subject
    mail to: "to@example.org"
  end

  def with_values
    # You can pass variables to mailer subject lines via the default_i18n_subject method.
    mail to: "to@example.org", subject: default_i18n_subject({a_value: "a value"})
  end
end

```

### Plain old ruby classes

I like to try to avoid hard coding text into my ruby classes by calling the `I18n.t` method with a scope. This is especially handy if you'd like to avoid a switch statement for returning different copy.

```ruby
class UserPresenter
  def status
    # en.presenters.user.status.active / en.presenters.user.status.inactive
    I18n.t(".status.#{object.active? ? 'active' : 'inactive'}", scope: %w[presenters user], a_value: "a value")
  end
end
```

```yaml
# config/locales/presenters/user.en.yml
en:
  presenters:
    user:
      status:
        active: 'An active sample status with %{a_value}'
        inactive: 'An inactive sample status with %{a_value}'
```
