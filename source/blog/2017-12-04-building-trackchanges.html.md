---
layout: post
title: Building and shipping TrackChanges
categories:
 – blog
published: true
meta:
  description: I wrote another extension
  index: true
---

I opened my first ticket of the day & made a grimace look. The client I was working with had sent over design changes. The client was confident in changing things in the browser, and they'd send me annotated screenshots and snippets of code for what they wanted to change, but felt inefficient.

Then I was inspired, what if my clients who could edit in the browser and send me a much more complete summary. I started building and last week I launched the 1.0.0 version of my idea [TrackChanges](https://trackchanges.mikerogers.io/). 

## The first MVP

{% youtube 3FyesD_J28E %}

It was pretty naff, it was hard to use and really unclear as to how it worked, but it generated the files I wanted. I sent the demo video (above) to a few friends and got some fairly positive feedback.

Then I put it in the hands of my client, and they didn't get it at all. Worst of all, they stuck with sending me screenshots! Bugger.

I was a little deterred, but there were three things I hadn't considered initially:

1. The extension has to demonstrate the value it adds as quickly as possible.
2. My target market is not developers, it's the people who are writing their tickets.
3. The popup is the wrong interface to show the diff.

Once solve those three things, I should be ready for market.

## Better inspiration

Solving those 3 problems was tricky. I tweaked when I had spare time, but nothing felt like a good solution. I tried making the popup prettier and the processes more informative, but nothing felt like an improvement.

Then I got inspired while the devtools, specially the audit panel. I very quickly put together a mockup using the `chrome.panels` API and it felt so much better!

## The final product

{% youtube a2gRWHZn3fI %}

It was looking pretty good. I ran it past a few friends, and the response I got back was much more positive then the first MVP. I was almost there.

A friend of mine ([Sarah Ball](https://sarahb.co/)) helped me put together an awesome [landing page](https://trackchanges.mikerogers.io/). I was ready to launch! 

## Going forward

- $$$
