---
layout: post
title: Rails i18n examples
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

For a long time I had never fully embraced how simple internationalisation (i18n) in Rails is, but once I started by default I started feeling the benefits.

## Before I dive in

### Useful tools

There are two main tools I use while developing to see the i18n in action. Firstly [`i18n-debug`](https://github.com/fphilipe/i18n-debug) a rails gem that appends the i18n lookups to the logs.
The second [Quick Language Switcher](https://chrome.google.com/webstore/detail/quick-language-switcher/pmjbhfmaphnpbehdanbjphdcniaelfie/related?hl=en) a chrome extension that allows you to change the `Accept-Language` header.

### Internationalisation != Localisation

Internationalisation and Localisation are not the same thing, and I used to get this confused far to often. The best way to remember the difference is:

* Internationalisation - Displaying your app in the language the user is requesting.
* Localisation - Displaying content in your app based upon the users physical location, for example using the users local currency.

## How RoR decides on the i18n to use

By default Rails will attempt to honor the `Accept-Language` header in the users HTTP request, and serve the translations saved in your `/config/locales/*.yml` files. 
If it can't find a translation in the users language it'll fallback to the `default_locale`, which is normally set to `en`.

## Where Rails magic does stuff for you

### Input Placeholders

```
<%= form_for :message do "f| %>
  <%= f.input :name, placeholder: true
<% end %>
```

```
en.activerecord.placeholders.message.name
```

### Labels
```
<%= form_for :message do "f| %>
  <%= f.label :name
<% end %>
```

```
en.activerecord.label.message.name
```

### Adhocly in controllers

```
# app/controllers/messages_controller.rb
MessagesController < BaseController
  def update
    # Some business logic

    return redirect_to:index, notice: t(".notice") if @resource.save
    render :edit, alert: t(".alert")
  end
end
```

```
en.messages.notice
en.messages.alert
```

### Adhocly in views (With arguments)

```
<% # app/views/messages/_sidebar_pricing.html.erb %>
<%= t ".pricing_information", price: number_to_currency(200, precision: 2) %>
```

```
en.messages.pricing_information: "That'll cost #{price}"
```

## Reloading locales during development

Rails by default only loads up the translations once when you boot the app, this can make it a tad tricky when you're experimenting in development mode, to get around this add the following initializer:

```
# config/initializers/reload_locale.rb
if Rails.env.development?
  locale_reloader = ActiveSupport::FileUpdateChecker.new(Dir["config/locales/*yml"]) do
     I18n.backend.reload!
  end

  ActionDispatch::Callbacks.to_prepare do
    locale_reloader.execute_if_updated
  end
end
```

This will automatically reload your locales when they change without you having to restart the app.
