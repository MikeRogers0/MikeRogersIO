---
layout: post
title: Easier DateTime Localisation with Rails 
categories:
 – blog
published: true
meta:
  description: Rails ships with a bunch ISO date formats (and a few localised ones), here is how to use them
  index: true
---

Ruby and Ruby on Rails come with a bunch of time saving libraries, which can save you a lot of time coding for specific scenarios.

## Pure Ruby

These are the methods which ship with Ruby's [DateTime class](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/DateTime.html), with their associated [strftime format](http://strftimer.com/). Where possible you should use these when storing times, or outputing data in some machine readable way (Like an API).

| Method   |      strftime  Format     |  Output |
|----------|:--------------------------:|--------|
| `DateTime.now.httpdate` | `%a, %d %b %Y %H:%M:%S GMT` | Sun, 03 Mar 2019 13:45:03 GMT |
| `DateTime.now.iso8601` |  `%Y-%m-%dT%H:%M:%S+%H:%M` | 2019-03-03T13:45:17+00:00 |
| `DateTime.now.jisx0301` |  `H%d.%m.%yT%H:%M:%S+%H:%M` | H31.03.03T13:45:26+00:00 |
| `DateTime.now.rfc3339` |  `%Y-%m-%dT%H:%M:%S+%H:%M` | 2019-03-03T13:45:37+00:00 |
| `DateTime.now.rfc2822` |  `%a, %-d %b %Y %H:%M:%S +%H%M` | Sun, 3 Mar 2019 13:45:48 +0000 |
| `DateTime.now.rfc822` |  `%a, %-d %b %Y %H:%M:%S +%H%M` | Sun, 3 Mar 2019 13:45:58 +0000 |
| `DateTime.now.xmlschema` |  `%Y-%m-%dT%H:%M:%S+%H:%M` | 2019-03-03T13:49:32+00:00 |
| `DateTime.now.to_i` |  `%s` | 1551621698 |

## Rails

Non-developers are a bit rubbish at reading those standardised formats. Luckily, Rails has your back with a bit of I18n awesomeness! It ships with [3 localisation formats (default, short & long)](https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/activesupport/lib/active_support/locale/en.yml#L3), that'll output dates nicely.

| Code   |  Output |
|----------|--------|
| `I18n.l(DateTime.now, format: :default)` | Sun, 03 Mar 2019 14:17:01 +0000 |
| `I18n.l(DateTime.now, format: :short)` | 03 Mar 14:17 |
| `I18n.l(DateTime.now, format: :long)` | March 03, 2019 14:17 |

By default, rails ships with the `:en` locale. However, pretty often you'll want to localise your dates and times to different international formats, for this the [rails-i18n gem](https://github.com/svenfuchs/rails-i18n) to save you a bunch of time.

Add that gem to your Gemfile, then you can either set the locale from the `Accept-Language` [browser header](https://guides.rubyonrails.org/i18n.html#choosing-an-implied-locale), or just pass the `format` argument to your `I18n.l` method call.

| Code   |  Output |
|----------|--------|
| `I18n.l(DateTime.now, format: :long, locale: :'en-US')` | March 03, 2019 02:37 PM |
| `I18n.l(DateTime.now, format: :long, locale: :'en-GB')` | 03 March, 2019 14:38 |
| `I18n.l(DateTime.now, format: :long, locale: :'de')` | Sonntag, 03. März 2019, 14:38 Uhr |

This should handle most your date & time formatting needs when outputting to various users :D
