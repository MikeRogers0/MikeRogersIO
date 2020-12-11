---
layout: post
title: How to Make Rails Work Offline (PWA)
description: I've been experimenting with Progressive Web Apps
---

I've been experimenting a lot lately with allowing Ruby on Rails to work offline, by this I mean having a sensible fallback for when the network unexpectedly drops out (e.g. the user is underground).

The main way to achieve this via by making our app a Progressive Web App (PWA) via a Service Worker. This allow us to create a pretty nice user experience, without having to rewrite our Rails App to a non-traditional approach (e.g. server side rendering & Turbolinks).

## Screencasts

I've put together a few screencasts so you can see everything in action.

- [The serviceworker-rails gem](https://www.youtube.com/watch?v=EKa6IOBRnHI)
- [webpacker-pwa & Workbox](https://www.youtube.com/watch?v=c9slVBXsXyo)
- [NetworkFirst, CacheFirst & StaleWhileRevalidate](https://www.youtube.com/watch?v=iL7erF3t83o)

## Libraries

Service Workers awesome & because they've been around a few years there is quite a few libraries which make it a lot easier to work with.

### The [serviceworker-rails](https://github.com/rossta/serviceworker-rails) Gem

This gem will work pretty nicely for most use cases, it works with the Asset Pipeline (Sprockets) & has a very nifty generator automated setup.

The only downside of this approach is because it's using the Asset Pipeline, it defaults to a verbose vanilla JavaScript approach. It's good, but there are some new libraries out there which can cut down some of the boilerplate.

### webpacker-pwa library

- This one is better

### Workbox

- This is easier

## Strategies

### NetworkFirst

### CacheFirst

### StaleWhileRevalidate

## Prewarming the cache

- Do it on the page, call a few things I think.

## JavaScript Modules

- It could be the most exciting option, here is a one off install.

## Service Worker Limitations

## Conclusions
