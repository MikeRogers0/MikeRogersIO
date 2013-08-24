---
layout: post
title: Preparing your blog for traffic spikes
published: true
categories:
 – blog
meta:
  description: 'A collection of benchmarking tools and caching solutions which should help keep a small site online during traffic spikes.'
  index: true
---
It seems like every few days I click a link on HN or Reddit to find that the page returns an error due to the high level of traffic hitting the server. Here is a short guide on how to prepare your blog for a traffic spike.

## Stress Testing
The best way to find out how your website will handle 400 people a second hitting your site is to send this amount of people per second to it and see where it's struggling. Here are a few resources which will help you stress test your website.

### Apache Benchmark
[Apache Benchmark](http://httpd.apache.org/docs/2.0/programs/ab.html) is an open source tool which allows you to benchmark a site from your local machine. If you're using OSX simply open terminal and type:

{% gist 6327838 apache-benchmark.sh %}

This will make 25 requests (5 at a time) to http://mikerogers.io, then output a table of benchmark information into the terminal. 

### LoadImpact
[LoadImpact](http://loadimpact.com/) is a cloud based benchmarking tool that offers a free test that will send a small number of concurrent users to your webpage, then plots on a graph the change in user load time over the duration of the test.

It also has a paid option where you can simulate a larger amount of concurrent users.

## Enable caching
The default theme in Wordpress makes a lot of MySQL requests to load a single blog post. If the output is the same each time it makes sense to cache it right? Here are a few options for caching output.

### Varnish Cache
 [Varnish Cache](https://www.varnish-cache.org/) is by far the best solution if you have root access to your server. Varnish will cache the output and store it in your servers memory for future requests. On my server I managed to get a Wordpress page load time down from 300ms to 38ms.

### Put it behind a CDN
CDNs aren't just for serving images, you can very easily put your entire website behind one. This will reduce the speed at which you can deploy updates, but will cache your website in a location close to your user.

Two popular CDN options are [CloudFront](http://aws.amazon.com/cloudfront/) and [CloudFlare](https://www.cloudflare.com/). 

*Note: A CDN cannot be added to your root domain (e.g. mikerogers.io) for DNS reasons. Your website would need to served via the CDN on a subdomain (e.g. www.mikerogers.io). When setting up a new site keep this in mind.*

## Don't use Wordpress
As mentioned above, Wordpress by default isn't the most efficient blogging solution. If you can, considering moving to [Jekyll](http://jekyllrb.com/), it will generate a static site (Which can be served super fast on almost any host) which you can upload to your server.
 