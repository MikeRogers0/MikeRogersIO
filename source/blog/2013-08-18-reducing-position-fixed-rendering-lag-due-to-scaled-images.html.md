---
layout: post
title: Reducing position:fixed; rendering lag due to scaled images
published: true
categories:
 – blog
meta:
  description: 'Using position:fixed; causes the page to lag when your scrolling, scaled images make this issues worse. Here is a fix to make it less noticeable.'
  index: true
---
I'm currently working on a project that uses a variable amount of images which are scaled into 120px by 120px elements (The images are 3rd party). On lower end devices I noticed a lag when scrolling the page, upon further inspection the issue was also noticeable on my desktop machine. [Here is a demonstration of the issue](/2013/08/18/fixed-position-scroll-lag.html).

## The Problem
After watching the page render in the timeline tool in Chrome and watching the timeline as the page was scrolled, the issue was clear. 

{% img src: /uploads/2013/08/18/timeine-repainting.jpg width: 750 alt: "The Chrome Dev tools timeline showing the lag cause" %}

The scaled images were being repainted from the cache each time the page was scrolled. As there was quite a few images this caused a lag in the page rendering. Upon further investigation it turned out to be due to there being a element which used position:fixed; on the page, which triggers the elements on the page to be repainted when they collide. More information about this issue has been documented by <a href="http://remysharp.com/2012/05/24/issues-with-position-fixed-scrolling-on-ios/">Remy Sharp</a>.

## A Solution
I tried a few approaches at fixing this issue, including moving the scaled background images into image elements. However, I found the best approach was to use HTML5 canvas to reduce the time it took to repaint the elements.

### The HTML5 Canvas Approach
Scaling the images via canvas, then injecting the canvas like a background image into a container element worked great. I've set up a [demo of the HTML5 Canvas approach](/2013/08/18/fixed-position-scroll-lag-html5-canvas-solution.html). You'll notice that while the elements are still being repainted, the lag is greatly reduced albeit the initial loading time is slightly increased. 

Below is the code sample used in the demonstration, though to keep things simple I didn't do much with image ratios.

{% gist 6264546 resize-image.js %}

This works by downloading the image, then resizing it into a canvas element which is injected into the list element, then CSS absolute position is used to position the canvas correctly. 
