---
layout: post
title: Displaying a Twitter feed
description: How to use the twitter gem to display tweets then fragment caching to keep things quick.
---

{% youtube_playlist PLsqSLeo9DZwTLSLxfe0ke6uSproB7QMN_ %}

In these tutorials I show how to display a Twitter feed via the Twitter API, then cache the output with [fragment caching](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching).

You can find all the code behind this tutorial in the [GitHub Repo](https://github.com/MikeRogers0-YouTube/RoR4-Twitter-Feed).

## Gems

Here are the main gems I used:

* [twitter](https://github.com/sferik/twitter) - The Ruby interface we used to talk to the Twitter API.
* [dotenv-rails](https://github.com/bkeepers/dotenv) - We used this gem to load up our consumer key and secret into our app, so we can access them via `ENV['TWITTER_CONSUMER_KEY']`.

