---
layout: post
title: Using Signed Global ID in Rails
categories:
 – blog
published: true
meta:
  description: Lookup objects from a string of text, way better then passing ID references around.
  index: true
---

Passing objects between external services & Rails is fun. Historically I've used an ID or slug to reference an object when making calls to external API, however this puts a lot of trust into a 3rd party. This could easily become an attack vector that goes unnoticed.

Recently I found [Global ID](https://github.com/rails/globalid) (Which ships with Rails) offers a `to_sgid` method that allows you to get a reference to an object, that only your app knows what it is referring to.

Here is a sample usage from the Global ID docs:

```ruby
person_sgid_to_s = Person.find(1).to_sgid.to_s
# => "BAhJIh5naWQ6Ly9pZGluYWlkaS9Vc2VyLzM5NTk5BjoGRVQ=--81d7358dd5ee2ca33189bb404592df5e8d11420e"
# Your app will decode this to: "gid://app/Person/1"

GlobalID::Locator.locate(person_sgid_to_s)
# => #<Person:0x007fae94bf6298 @id="1">
```

This provides a great solution for if you're concerned an object reference could be adjusted in transit between your app, an external service & back to your app again.

## Sample usage with a Webhook & Polymorphic Relationship

A recent use case where I implemented this, was to allow a user to make a telephone call via their browser to a phone number associated to an object. The flow was as follows:

1. User clicks a "Start Call" button on a page, this opens a connection to our telephony provider via a web socket.
2. The telephony provider send a request to our application to requesting the telephone number to call.
3. Phone call is started & the user is connected.

A key security concern, was making sure users only called the numbers they we're allow to to. Here is a simplified version of the approach:

### The view

```erb
<button
  data-callable-sgid="<%= @object.to_sgid.to_s %>"
  data-current-user-sgid="<%= current_user.to_sgid.to_s %>">
  Call <%= @object.phone_number %>
</button>
<!--
  When this is clicked:
  A web socket is opened with `data-callable-gid` & `data-current-user-sgid` passed to it
  The telephony provider passes those onto our webhook.
-->
```

### The telephony provider callback

```ruby
class Webhook::CallsController < ApplicationAPIController
  # POST /webhooks/calls
  # Sent by the telephony provider to confirm the phone number we want to call:
  #
  # params:
  #  * current_user_sgid - Signed Global ID of the user making the call.
  #  * callable_sgid - Signed Global ID of the object the user is requesting to call.
  def complete
    user = GlobalID::Locator.locate(params[:current_user_sgid])
    callable = GlobalID::Locator.locate(params[:callable_sgid])

    if user.can_call?(callable)
      render json: { phone_number: callable.phone_number }
    else
      render status: :unauthorised
    end
  end
end
```

