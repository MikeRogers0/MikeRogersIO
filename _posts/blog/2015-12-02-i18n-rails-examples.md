---
layout: post
title: Rails I18n examples
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

For ages I had never fully embraced how time saving the i18n is in Rails, but once I started using it more frequently it started becomming by biggest time saver.

## Useful tools

There are two main tools I use to develop while seeing the i18n in action. Firstly [`i18n-debug`](https://github.com/fphilipe/i18n-debug) a rails gem that appends the i18n lookups to the logs.
The second [Quick Language Switcher](https://chrome.google.com/webstore/detail/quick-language-switcher/pmjbhfmaphnpbehdanbjphdcniaelfie/related?hl=en) a chrome extension that allows you to change the `Accept-Language` header.

## How i18n decides on the language to use

Looks at what the browser is requesting (The lang header), if not found it'll fallback to the default.

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
