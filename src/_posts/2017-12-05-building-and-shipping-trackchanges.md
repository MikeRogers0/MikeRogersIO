---
layout: post
title: Building and shipping TrackChanges
description: I shipped a Chrome extension, it was an adventure.
---

Last week I released [TrackChanges](https://trackchanges.mikerogers.io/) to the public, and it was fairly niche extension, but I felt like it launched pretty nicely. I wanted to share the journey from initial idea to shipping to the Chrome Store.

# The problem

I opened my first ticket of the day & made a grimace look. The client I was working with had sent over design changes. The client was confident in changing things in the browser, and they'd send me annotated screenshots and snippets of code for what they wanted to change. It was good, but felt very inefficient.

I wanted to build something which allowed my client to edit in the browser and send me a more complete summary. So I got cracking!

## The MVP

{% youtube 3FyesD_J28E %}

It was hard to use and really unclear as to how it worked, and it generated the files I wanted! I thought a nailed it! I sent the demo video (above) to a few friends and got some fairly positive feedback.

I thought I was pretty much ready, so I put it in the hands of my client, and they didn't get it at all! Worst of all, they stuck with sending me screenshots! Bugger.

I was a little deterred, but there was three things I hadn't considered initially:

1. The extension has to demonstrate the value it adds as quickly as possible. It wasn't clear at all exactly how the extension made life easier.
2. My target market is not developers, it's the people who are writing their tickets. I had to test this against project managers and designers.
3. The popup is the wrong interface to show the diff, it felt like every other extension. I needed to make it feel like part of chrome.

Once I solved those three things, I thought I'd be ready for market.

## Better inspiration

Solving those three problems was tricky. 

I tweaked and tinkered when I had spare time, but nothing felt like a good solution. I tried making the popup prettier, made the comparison more concise and the processes more informative, but nothing felt like an improvement. I spent about 3 months just changing things and getting nowhere. Then I pretty much just shelved it. 

![The chrome audit panel](/uploads/2017/12/05/chrome-audit-panel.png)

Then I using the audit panel in Chrome, it was really obvious as to the value clicking the button would do and really clean. I wanted my extension to feel like that! I very quickly put together a mock-up using the `chrome.panels` API and it felt so much better!

## The final product

{% youtube a2gRWHZn3fI %}

It was looking pretty good. I ran it past a few friends and potential users, and the response I got back was much more positive then the first MVP. I was almost there!

A friend of mine ([Sarah Ball](https://sarahb.co/)) helped me put together an awesome [landing page](https://trackchanges.mikerogers.io/). I was ready to launch!

![The stats for the first week" title: "I launched on the 25th of November and had a nice spike in users](/uploads/2017/12/05/first-user-week-stats.png)

I [shared the link](https://twitter.com/MikeRogers0/status/935824204225810433) on twitter and the users started trying it out. In the first week I gained 210 users, with most the installations on the first day.

Launching something and to get that many users on the first day is awesome!

## Going forward

I'm going to keep monitoring the feedback. I've had a bunch of suggestions which will make it even better (Such as adding Source Maps support). Assuming the users keep growing I'll keep looking into ways to improve it.

I'm also fairly confident I can monetise TrackChanges. When the time is right, I intending to start with selling it ([like I have for the last year with LivePage](/2017/11/28/a-year-after-monetising-my-chrome-extension.html)) via a $4 one off fee.
