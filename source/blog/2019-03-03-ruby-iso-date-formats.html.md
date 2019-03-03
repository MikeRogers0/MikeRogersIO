---
layout: post
title: Quicker date formatting with Rails
categories:
 – blog
published: true
meta:
  description: Rails ships with a bunch ISO date formats (and a few localised ones), here is how to use them
  index: true
---

The Ruby Standard Library, and Rails comes with a bunch of time saving techniques which cover a bunch of sensible use cases.

## Standard Ruby

These are the methods which ship with the [DateTime class](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/DateTime.html), with their associated [strftime format](http://strftimer.com/). Where possible you should use these when storing times, or output data is some machine readable way (Like an API).

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
{: class='table table-striped table-bordered'}

## Rails

https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-GB.yml
