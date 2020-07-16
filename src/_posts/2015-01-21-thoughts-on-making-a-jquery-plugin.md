---
layout: post
title: Some thoughts on making a jQuery plugin
description: I wrote a jQuery Plugin. Here are notes on the parts of used.
---

I recently got around to finishing off [show-when-this](https://github.com/MikeRogers0/show-when-this), a jQuery plugin that had been knocking around in the back of my head for a while now. This was the first jQuery plugin I had written with tests and decided to published to the world, in this post I've put down a few of my thoughts.

## Building

### Naming and describing things

I'm still not 100% happy with the name and options I've used. I feel that evaluator_callback / change_selector, are somewhat descriptive but probably should be changed in the 1.0.0 release. If anyone has any suggestions, please tweet them to me :)

### QUnit

My plugin was pretty simple (It just shows and hides elements based on the value of another element), so I thought I'd try and write a few tests for it. 

I was really impressed by how simple [QUnit](http://qunitjs.com/) was to get working with, pretty much all you have to do is  include the QUnit JS and CSS onto a page, then you can start writing tests and see them pass in the browser. 

It was really nice to drop my test html file into the browser and use the chrome console to debug errors. 

I did have problems getting QUnit running with Grunt/Travis CI, it turned out I had to host all the JS and CSS files locally (I had served jQuery / QUnit from a CDN). This was a bit of a let down, but I have no doubt it is a small configuration I have to change somewhere.

### Grunt

I used Grunt to run the tests, run a JSHint and uglify the source code via terminal. It was nice that I could automate a bunch of commands before I pushed up a new version to GitHub. That said, I felt the [Gruntfile](https://github.com/MikeRogers0/show-when-this/blob/master/Gruntfile.js) had potential to get messy very quickly. 

### Travis CI

I really wanted to have the "build passing" badge on my repo, I've used Travis previously with a few private rails projects and I was very impressed.

However when I first pushed up the project it took a long time for Travis to run the build, I thought initially I had misconfigured something, but it turned out I was just in the open source project build queue, and it has a short wait until your tests run.

### Zepto

I'm a big fan of [Zepto](http://zeptojs.com/), as it's a nice alternative to jQuery with a smaller footprint. As the plugin was fairly simple (and had a test suite) it was pretty easy to confirm it worked with Zepto. 

## Publishing

### jQuery Plugin Registry

The [jQuery Plugin Registry](http://plugins.jquery.com/) appears to be completely abandoned and will never come back. This is a damn shame, but I think alternatives such as [bower](http://bower.io/) do a much better job.

### Bower

I was very skeptical of bower to begin with as I had to add another .json file to my repo to serve one service. That said, bower was really easy to [publish to](http://bower.io/search/?q=show-when-this) and is used by a few other services to manage front end packages.

I think I still need to use Bower a bit more to fully understand how to use it correctly, but I think it is really good.

### Rails Assets

Using bower with Rails projects kinda sucks because it adds JS files you should never touch to your rails project folder. However with [Rails Assets](https://rails-assets.org/) you can keep those JS files somewhere out of the way. 

I really liked Rails Assets because it builds a gem from bower, so I only need to make sure bower has updated to be able to use a new version of the plugin.
