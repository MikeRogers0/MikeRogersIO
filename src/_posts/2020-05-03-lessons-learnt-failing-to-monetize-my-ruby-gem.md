---
layout: post
title: Lessons Learnt Failing to monetize my Ruby Gem
description: I closed down my PigCI app. Here are some of the things I learnt along the way.
---

My side project ([PigCI](https://pigci.com/)) was a ruby gem that you'd attach to your RSpec test suite, and it'll warn you via a GitHub App if you had an unexpected increase in memory usage or database requests.

It achieved just over 9,000 downloads & had some wonderful feedback from users. I intended to monetize this library via the GitHub Marketplace, unfortunately it earned a total of $0.

I decided in March 2020, it was a good time to shutdown the GitHub App side of it & free myself up to focus on other projects. I've open sourced the [GitHub App](https://github.com/PigCI/App) (It might be helpful to anyone curious about setting up a GitHub App with Ruby on Rails), and I've also updated the [Ruby Gem](https://github.com/PigCI/pig-ci-rails) so it doesn't require a GitHub App to pass/fail pull requests.

I learnt a lot while attempting to monetize PigCI (It was a lot of fun!), but I also made a bunch of mistakes which I hope others might find useful to hear about.

## Build a little, learn a little & repeat

I launched PigCI as a full singing and dancing SaaS from day one. This was a terrible approach, I had zero idea if people would even use the product let alone if they'd pay for it. It gets worse though, because I had sunk a lot of time into building a  subscription model which relied heavily on GitHub, so I was unwilling to consider alternative monetisation approaches. 

I think it's fairly normal to want to launch a polished product & only charge customers in a single way. But it's the worst way to earn money. It took me seeing the [heya](https://github.com/honeybadger-io/heya) gem charging via Gumroad to really realise how much I had screwed up. I had wasted a bunch of time building the parts to support a subscription model, when I should have been promoting & improving the darn thing!

If I was to do it all again, I'll just build a little bit of the product with a small "hey buy a licence" request in the README. Enough to let people see it working, but with a little push to get people to validate it's a good product with their money.

## Promote in person

I didn't put much effort into promoting PigCI (I was waiting until I had a verified status in the GitHub Marketplace). However, I experimented when I first launched to get a feel for what would work best for me.

Initially I spent $50 via AdWords, however I misconfigured my campaign so it was spent in less then 5 minutes & generated zero installs (Whoops). I had targeted the keywords "rails", "memory" & "usage" to appear anywhere in a search query instead of as an exact phrase. So I had just sent people looking for "national rail usage" to a pig themed website.
I retried AdWords again with [Typo CI](https://typoci.com/) a few months later ($50, this time with very specific targeting) & it worked out about $5 per an install.

I also spent $50 on an Twitter Campaign. The tweet I promoted probably wasn't the best copy (It was just a "Hey, I've launched PigCI a memory tracking tool for ruby on rails"), but I ended up with about 5 installs from it.

The most useful form of promotion I found was simply sitting down with developers, listening to their problems & asking them to give my product a try. The cool thing about meeting people face to face was I was able to get some pretty useful feedback. With one customer they emailed me with what they were finding annoying, which took a few hours to fix and they stayed as a customer until I let them know I was closing it down.

## Make your app do a standup

Keeping motivated to keep building is one of the hardest aspects of building a product.

I made the app post a daily standup every morning via slack. Seeing that new people had joined, or lots of commits had been processed really spurred me on! It took like an hour to build & I've duplicated it on all my other side projects since.

## The GitHub Marketplace…

I used the GitHub Marketplace as a way for users to connect their GitHub account to my SaaS App. It seemed like a great deal, GitHub would list me in their marketplace (which drove installs) while taking a 30% cut of the paid tier subscriptions.

The catch with GitHub, was I had to be verified before I could start charging for usage (it was 100 installs, which was very achievable via AdWords). I was _ok_ with having to reach a threshold of users before I could start charging, however *GitHub paused verifying applications in January*. This really screwed me as the marketplace guidelines said I was not allowed to be listed on the GitHub marketplace if I offer a paid service outside of GitHub Marketplace.

This meant for the last 5 months I had zero chance of earning a penny if I was in their Marketplace unless I was verified (which was not possible). It really killed my motivation. I had built my product around the marketplace. When I tried to contact their support regarding the status of the pause, they took a month to reply to my email.

I spent the last few months hoping they'd start verifying applications again, but hindsight being 20/20, the moment I was told I'd have to wait to start charging via GitHub, I should have started charging via Stripe or Gumroad. 

## Automate Patching & Deploys

I used Heroku for hosting ($23 a month for two dynos, Redis & a Postgres database). I really like the tools they offer out of the box, but I especially like how easy it is to automate deploys from GitHub.

Once I had a decent test suite, I setup [Dependabot](https://dependabot.com/) to auto-merge patches, which were then automatically deployed once the test suite passed. This meant when I had some spare time during (e.g. a quite weekend or evening) I could focus on building a new feature or fixing a bug, instead of routine maintenance. It was great!

I was even able to quickly tweak some of the app by making a Pull Request from my iPhone while on a train. I have the same setup on my other apps now as it's something I wouldn't want to live without.

## Breakup your app via subdomains

Ever wondered why lots of apps are often on a subdomains like `app.company-name.com`? I copied that a little as my API & Webhook endpoints were on subdomains & I wish I had done the same with my main app.

Being able to filter my logs by subdomain made it super easy to see what was going on, plus it made it really easy for me to consider how I'd scale various part of my apps up in the future if required.

I really wish I had put my marketing site on a different subdomain to my app. I'm growing really fond of having a blazing fast middleman site for marketing and have the user facing web app running Rails somewhere else.

## Talking to other people running side projects

One of my friends runs both [PR Scheduler](https://github.com/marketplace/pr-scheduler) & [CommitCheck](https://github.com/marketplace/commitcheck). Having someone to compare experiences with was really enjoyable, plus we're a little competitive on who has the most users.

I'd totally recommend joining some of the IndieHacker groups out there, it makes working a lot more fun.

## Generic naming is better

I named the project "PigCI". You know what no one is searching for? Pig themed CI services.

Having a unique name is fun, but my other side project [Typo CI](https://typoci.com/) has had much more initial organic growth, which I think has been somewhat down to a more clear name.

I did really like having a unique name, but if I was it re-release the gem, I'd just call it something like "Rails Memory Test Profiler".
