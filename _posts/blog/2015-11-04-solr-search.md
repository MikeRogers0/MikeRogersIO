---
layout: post
title: Searching with Solr in Rails
categories:
 – blog
published: true
meta:
  description: SOLR
  index: true
  image: TODO
---

Adding a custom search to your website can be somewhat tricky if you want to organise results by relavancy, solr can make this a bit easier. 

For this post I'm going to assume you've installed solr via brew, or are using WebSolr.

## Setup in rails

To setup Solr, add the [sunspot_rails](https://github.com/sunspot/sunspot) gem to your Gemfile, then bundle. 

Examples how adding in the search

## Add to your models

## Setup for more scale

Solr defaults are setup for you to get going as fast as your can, but you may find you're reindexing a document to often

* Don't reindex every save, my approach
* Reindex in background

    
