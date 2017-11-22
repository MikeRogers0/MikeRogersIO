---
layout: post
title: Rails internationalisation (i18n) cheatsheet
categories:
 – blog
published: true
meta:
  description: A collection of examples of how to use the rails internationalisation (i18n) and a few quick start tools.
  index: true
---

For a long time I had never fully embraced how simple internationalisation (i18n) in Rails is, but once I started using it by default I felt like a silly pickle for not embracing it before.

## Before I dive in

### Useful tools

There are two main tools I use while developing to see the i18n in action. Firstly [`i18n-debug`](https://github.com/fphilipe/i18n-debug) a rails gem that appends the i18n lookups to the logs.
The second is [Quick Language Switcher](https://chrome.google.com/webstore/detail/quick-language-switcher/pmjbhfmaphnpbehdanbjphdcniaelfie/related?hl=en) a chrome extension that allows you to change the `Accept-Language` header.

### Internationalisation != Localisation

Internationalisation and Localisation are not the same thing, and when I was a newbie I used to get this confused far to often. The best way to remember the difference is:

* Internationalisation - Displaying your app in the language the user is requesting.
* Localisation - Displaying content in your app based upon the users physical location, for example using the users local currency.

## How RoR decides on the locale to use

By default Rails will attempt to honour the `Accept-Language` header in the users HTTP request, and serve the translations saved in your `/config/locales/*.yml` files. 
If it can't find a translation in the users language it'll fallback to the `default_locale`, which is normally set to `en`.

## Reloading locales during development

Rails by default only once parses the translations when you boot the app, this can make it a tad tricky when you're experimenting in development mode, to get around this add the following initialiser:

    # config/initializers/reload_locale.rb
    # from http://stackoverflow.com/a/20570652/445724
    if Rails.env.development?
      locale_reloader = ActiveSupport::FileUpdateChecker.new(Dir["config/locales/*yml"]) do
         I18n.backend.reload!
      end

      ActionDispatch::Callbacks.to_prepare do
        locale_reloader.execute_if_updated
      end
    end

This will automatically reload your locales when they change without you having to restart the app.

## Where Rails magic does stuff for you

### Input Placeholders

You can tell Rails to use the i18n placeholder by passing `placeholder: true` into the inputs options.

    <%# app/views/messages/_form.html.erb %>
    <%= form_for :message do "f| %>
      <%= f.input :name, placeholder: true %>
    <% end %>

This'll search the i18n tree for the following key setup:

    en:
      helpers:
        placeholder:
          message:
            name: "Your placeholder text here"

### Labels

    <%# app/views/messages/_form.html.erb %>
    <%= form_for :message do "f| %>
      <%= f.label :name %>
    <% end %>

    en:
      helpers:
        label:
          message:
            name: "Name label"
      activerecord:
        attributes:
          message:
            name: "Name attribute (fallback for when label is nil)"


### Submit buttons

You can change the value of your create and update submit buttons:

    <%# app/views/messages/_form.html.erb %>
    <%= form_for :message do "f| %>
      <%= f.submit %>
    <% end %>

    en:
      helpers:
        submit:
          message:
            create: "Create a new %{model}"
            update: "Save changes to %{model}"

However you can also specify the create/update terms one level up the tree to have this effect every model in your app by default:

    en:
      helpers:
        submit:
          create: "Create a new %{model}"
          update: "Save changes to %{model}"

### Model names

In the previous example I used the `%{model}` argument in the i18n. You can easily change the name of a model in the locale file like this:

    en:
      activerecord:
        models:
          messages: "Queries"


### Adhocly in controllers

One of my favourite places to use the i18n is in my controller for the notices and alerts:

    # app/controllers/messages_controller.rb
    MessagesController < BaseController
      def update
        # Some business logic

        return redirect_to:index, notice: t(".notice") if @resource.save
        render :edit, alert: t(".alert")
      end
    end

    en:
      messages:
        update:
          notice: "Message was successfully updated."
          alert: "Unable to update message."

### Adhocly in views (With arguments)

You can also pass arguments into the i18n translate method, like so:

    <% # app/views/messages/_sidebar.html.erb %>
    <%= t ".pricing_information", price: number_to_currency(200, precision: 2) %>

    en:
      messages:
        sidebar:
          pricing_information: "That'll cost %{price}"

This would return the text:

    That'll cost $200.00

Alternatively if you start without a dot, it'll look from the start of the i18n tree, for example:

    <% # app/views/messages/_sidebar.html.erb %>
    <%= t "pricing_information", price: number_to_currency(200, precision: 2) %>

    en:
      pricing_information: "That'll cost %{price}"
