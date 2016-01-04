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
<!-- app/views/messages/_sidebar_pricing.html.erb -->
<%= t ".pricing_information", price: number_to_currency(200, precision: 2) %>
```

```
en.messages.pricing_information: "That'll cost #{price}"
```
