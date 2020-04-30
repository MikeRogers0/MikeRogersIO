---
layout: post
title: Lessons Learnt Failing at a SaaS
categories:
 – blog
published: true
meta:
  description: 
  index: true
---

## Stats:

Hosting Cost: $23 a month
First Commit: 28th Aug 2018
Shutdown Date: 1st May 2020

## Article

In March 2020 I decided it was time to shutdown my PigCI side project. It was a small piece of software that you'd attach to your Rails RSpec test suite that warn you if you had an unexpected increase in memory or database requests.

I made a lot of mistakes attempting to convert this into a SaaS, here are some of my notes over the last month as to what went wrong.

## Product first, SaaS later

I launched PigCI as a full singing and dancing SaaS from day one. This was a terrible approach, I had zero idea if people would even use the product let alone pay for it. Further more, because I had spent so much time setting up the SaaS it made me unwilling to pivot to a better monetisation model.

Had I done it again, I would have just launched the library & talked to people who actually used it. From there I could decided if it would have been worth going to route of [heya](https://github.com/honeybadger-io/heya) (who charge via Gumroad) or creating a full blown app to support it.

## Promote in person

Promotion is hard! It took me almost a month to have a user sign up & use the product for more then a month. I put aside $150 & split it between various platforms, here is the results:

- *AdWords*: I screwed up & $50 was gone in less than 5 minutes. Turns out I targeted the keywords "rails", "memory" & "usage" to appeared anywhere in a search query instead of as an exact phrase. So I had just sent people looking for "national rail usage" to a pig themed website. I tried again with Typo CI a few months later ($50, this time with very specific targeting) & it worked out about $5 per an install.
- *Twitter*: I had a few clicks, but no conversions.
- $50 for Beers in Person: This was a real winner! I brought a few developers a beer & was able to talk them through the product, along with hearing their feedback.

While AdWords was a great way to get users, the feedback I gained by talking to people face to face while 10x more valuable. 

## Automated deploys make life a joy

For my first few months I hosted the app on a $5 AWS Lightsail server. Eventually I moved off to Heroku ($23 a month for two dynos & a database) because it offered a bit out of the box (Insights & scaling).

One of the big advantages of Heroku was it allowed me to easily Automate deploys. One of the best things I did was setup [Dependabot](https://dependabot.com/) to auto-merge patches, which were then automatically deployed. This meant when I had some spare time during a month (e.g. a quite weekend or evening) I could focus on building a new feature or fixing a bug, instead of routine maintenance.

One of the best moments I had which validated this setup, was when I was able to quickly tweak some of the app by making a Pull Request from my iPhone while on a train.

## Support

Email is ok.

## Breakup app via subdomains



## Target Adverts as much as you can

I wasted some cash learning Adwords

## Generic naming is better

I named the projected "PigCI". You know what no one is searching for? Pig themed CI services!

Having a unique name is nice, but in comparison my other side project [Typo CI](https://typoci.com/) has had much more initial organic growth. I lot of this is from people seeing it's name & having a decent idea as to what it could do.

If I had called it something like "Rails RSpec Test Profiler" I probably would have had much better. Mostly because I wouldn't have to explain what the product did after saying the name.

## Final notes

I've updated the ruby gem so it can work independently without requiring a SaaS app to update github. I've also open sourced the code from the Rails app.
