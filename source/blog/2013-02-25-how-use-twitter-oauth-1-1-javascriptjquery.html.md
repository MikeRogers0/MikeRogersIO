---
layout: post
title: How to use Twitter OAuth v1.1 with JavaScript/jQuery
tags:
- Coding
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'A simple JavaScript patch for twitter API V1 retirement issue.'
  index: true
---
In March 2013 [Twitter plans to retire version 1](https://dev.twitter.com/blog/planning-for-api-v1-retirement) of their REST API, however it's replacement requires all requests to use OAuth signed headers. As a result if you're using JavaScript to pull in a twitter feed to show on your website, you might be  in for a spot of bother. However I've put together a little script which will allow you to remain using your JavaScript implementation, until you have time to move to the Twitter API 1.1 completely.

## The Code

Create a file called twitter-proxy.php and place it somewhere publicly accessible on your server.

{% gist 5033286 twitter-proxy.php %}

Be sure to update the $config variable with the tokens, keys and secrets provided by Twitter when you create an [app on their developer site](https://dev.twitter.com/apps) (this is free).

## Usage

Usage is pretty simple, instead of pointing your JavaScript XML request to Twitter just point it to the file you created instead. For example:

{% gist 5033286 usage.js %}
