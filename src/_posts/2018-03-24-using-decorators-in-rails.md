---
layout: post
title: Using Decorators in Rails
categories:
 – blog
published: true
meta:
  description: Avoid adding if/else logic inside view, instead use Decorators.
  index: true
---

Have you ever opened a view in your Ruby on Rails app and seen something like this:

```erb
# users/show.html.erb
<% if user.avatar.present? %>
  <%= image_tag(user.avatar) %>
<% else %>
  <div><%= user.fullname %></div>
<% end %>
```

This is a somewhat common code smell, and should be avoided.

## What's wrong with if/else in a view?!

It adds extra cognitive processing while considering the design of a page. 

Instead of "Ok, when no avatar is present, it will always fall back to the users name in a div", the design choice becomes "It could fallback, but that might not always be the case".

## Enter Decorators

Decorators (I'm fond of [Draper](https://github.com/drapergem/draper)) take that presentational logic and puts it somewhere out of the way.

So the above code can become:

```ruby
# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  def branding
   if object.avatar.present?
     h.image_tag(object.avatar)
   else
     h.content_tag(:div, user.fullname)
   end
  end
end
```

```erb
# users/show.html.erb
<%= user.branding %>
```

## Expanding it further

The above example will get you pretty far, but you can reduce the amount of logic you're working with further.

### ApplicationDecorator

I've found adding a parent class containing commonly used methods can reduce the amount of duplication in decorators, e.g.:

```ruby
# app/decorators/application_decorator.rb
class ApplicationDecorator < Draper::Decorator

  private
  # Call cms_content(object.some_field) to have a consistent CMS output.
  def cms_content(body)
    h.sanitize(body, tags: %w(p a ul ol li), attributes: %w(href))
  end
end
```

### Contextual Decorators

In cases (such as admin panels), you might want to have different decoration while still inheriting from the parent decorators, e.g.:

```ruby
# app/decorators/admin/user_decorator.rb
class Admin::UserDecorator < UserDecorator
  # Tell the Draper we're decorating the User model.
  decorates User
  delegate_all

  # Fallback to gavatar image in the admin panels
  def avatar
    if object.avatar.present?
      h.image_tag(object.avatar)
    else
      h.image_tag(object.gavatar_url)
    end
  end
end
```
