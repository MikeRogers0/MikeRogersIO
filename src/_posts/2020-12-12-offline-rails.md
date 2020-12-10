---
layout: post
title: How to Make Rails Work Offline (PWA)
description: I've been experimenting with Progressive Web Apps
---

I've been experimenting a lot lately with allowing Ruby on Rails to work offline, by this I mean having a sensible fallback for when the network unexpectedly drops out (e.g. the user is underground).

## Libraries

These make it easier.

### The serviceworker-rails Gem

This is the first thing I tried, it was decent.

### webpacker-pwa library

- This one is better

## Strategies

### NetworkFirst

### CacheFirst

### StaleRefreshLaterOrWhatever

## Prewarming the cache

- Do it on the page, call a few things I think.
