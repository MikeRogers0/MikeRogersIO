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

Last week I released [TrackChanges](https://trackchanges.mikerogers.io/) to the public, it has been a pretty fun adventure building.

# The problem

I opened my first ticket of the day & made a grimace look. The client I was working with had sent over design changes. The client was confident in changing things in the browser, and they'd send me annotated screenshots and snippets of code for what they wanted to change. It was good, but felt very inefficient.

I decided I wanted to build something which allowed my client to edit in the browser and send me a much more complete summary. So I got cracking!

## The first MVP

{% youtube 3FyesD_J28E %}

It was pretty naff, it was hard to use and really unclear as to how it worked, but it generated the files I wanted. I sent the demo video (above) to a few friends and got some fairly positive feedback.

I thought I was pretty much ready, so I put it in the hands of my client, and they didn't get it at all. Worst of all, they stuck with sending me screenshots! Bugger.

I was a little deterred, but there were three things I hadn't considered initially:

1. The extension has to demonstrate the value it adds as quickly as possible. The popup wasn't the best mechanism for this.
2. My target market is not developers, it's the people who are writing their tickets. I had to test this against project managers and designers.
3. The popup is the wrong interface to show the diff, it felt like every other extension. I needed to make it feel like part of chrome.

Once solve those three things, I should be ready for market.

## Better inspiration

Solving those 3 problems was tricky. I tweaked when I had spare time, but nothing felt like a good solution. I tried making the popup prettier, made the comparison more concise and the processes more informative, but nothing felt like an improvement. I spend about 3 months just changing things and getting nowhere.

{% img src: /uploads/2017/12/05/chrome-audit-panel.png width: 720 alt: "The chrome audit panel" %}

Then I got inspired while using the audit panel in Chrome, I wanted my extension to feel like that! I very quickly put together a mockup using the `chrome.panels` API and it felt so much better!

## The final product

{% youtube a2gRWHZn3fI %}

It was looking pretty good. I ran it past a few friends, and the response I got back was much more positive then the first MVP. I was almost there.

A friend of mine ([Sarah Ball](https://sarahb.co/)) helped me put together an awesome [landing page](https://trackchanges.mikerogers.io/). I was ready to launch!

{% img src: /uploads/2017/12/05/first-week-stats.png width: 720 alt: "The stats for the first week" %}

I [shared the link](https://twitter.com/MikeRogers0/status/935824204225810433) on twitter and got a fairly decent amount of shares. In the first week I gained 210 users, with most the installations on the first day. I was pretty satisfied.

## Going forward

I'm going to keep monitoring the feedback. I've had a bunch of requests to make it even better (Such as adding Source Maps support). Assuming the users keep growing I'll keep looking into ways to improve it.

I'm going to keep looking into ways to market TrackChanges, most people who try it see the value it can offer fairly quickly.

I'm also fairly confident I can monetise TrackChanges via a $4 one off fee. It's still early days, but I think once I hit 500 users I start charging all new users.
