---
layout: post
title: Organising I18n locale files in rails
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

One feature that's under utilised in the [Internationalization (I18n) API](https://guides.rubyonrails.org/i18n.html), it lets you easily translate your application into lots of different languages without any extra code.

I think the lack of usage comes from:

  1. It's a little unclear what key an object is using to lookup its translation
  2. By default it doesn't look in subfolders of `config/locales/` for definitions.
  3. A lot of tutorials don't demonstrate it.

Here are some solutions to that.

## Outputting i18n lookups to logs

Add the gem `i18n-debug`, then tag your logs.

```
tail -f log/development.log | grep "i18n-debug"
```

## Putting locales into subfolders

Add the following line into your `config/application.rb` file, add the line:

```
# However, I18n is better when broken down into multiple folders.
config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
```

This will let you break up your locales into nicely organised subfolders. Most my apps contain the files:

```
config/locales/en.yml
config/locales/activerecord/user.en.yml
config/locales/activemodel/user_form.en.yml
config/locales/formtastic/user.en.yml
config/locales/flashes/users.en.yml
config/locales/helper/user.en.yml
config/locales/mailers/user_mailer.en.yml
config/locales/views/simple_form/user.en.yml
```

## Some samples

TODO: Do a form of some kind & a controller.
