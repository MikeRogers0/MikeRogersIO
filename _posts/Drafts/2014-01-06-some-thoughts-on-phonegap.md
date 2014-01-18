---
layout: post
title: Using one codebase for a browser and Phonegap app was a bad idea.
published: false
categories:
 – blog
meta:
  description: 
  index: true
---

A few months ago I attempted to make [Podcast Player](https://github.com/MikeRogers0/podcast-app/) with a friend of mine. The idea was that we could use a single HTML5 codebase to play the podcasts and then sync the playheads via Dropbox to other devices. I was pretty naive to mobile and HTML5 app development when I started and as a result made a clunky app. 

## Bad parts

### Wanting to use the HTML5 audio tag in the browser and in Phonegap.
Lisencing issues for audio codecs in browsers meant that going for a pure HTML5 audio player was impossible. As a result if a user wanted to play an MP3 in Firefox or an AC3 in Chrome I had to use [MediaElement.js](http://mediaelementjs.com/). MediaElement pretty much plays the audio via a flash or silverlight wrapper, then provides a API to chat to the wrappers. 

MediaElement worked pretty well in browsers, but in Phonegap it was eating the battery on my phone (even when running in the background). I tried using the native API phonegap provides, but it proved hard to keep the codebase understandable.

### Using LocalStorage as a database
I really wanted the app to work offline, so I used a [LocalStorage adaptor](https://github.com/jeromegn/Backbone.localStorage) for backbone. This initally worked really well, but then the app started getting super sluggish on mobile. The cause was a 100mb memory footprint.
