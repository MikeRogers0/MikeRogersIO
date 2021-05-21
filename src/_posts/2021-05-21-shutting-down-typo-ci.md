---
layout: post
title: Shutting Down Typo CI
description: I decided it was time to close Typo CI. Before I pulled the plug, I want to document some lessons learnt.
---

I started Typo CI back in 2019 to help catch spelling mistakes in my code when I push up to GitHub. I built the first working version over a weekend, then over the next few months I build out a bit more functionality & shared it via the GitHub Marketplace.

I'm now in the process of closing down Typo CI & I'm aiming to completely shutdown by the end of June 2021.

## Why am I closing it down?

There are a lot of reasons behind the shutdown, but here is a summary of the main aspects.

### GitHub

I lost a lot of enthusiasm to build Typo CI after the amount of slow bureaucracy required to be on the GitHub Marketplace.

One of the largest sources of frustration I had with the GitHub Marketplace was just being able to charge for usage. When I first launched, GitHub required I have at least 100 users before I could apply to add a paid tier (and I wasn't allow to handle billing myself as per their developer agreement). I reached the 100 user threshold in about a month, then *it took GitHub over 6 months to allow me to start charging for usage*.

Having to wait so long to be able validate if I had a product people would pay for was not great. But I was mostly upset that when I contacted GitHub, often I wouldn't hear a response for many weeks.

### Talking to Users

When I first started Typo CI, I didn't talk to users at all & I really regret that now. Recently I followed the advice from [Michele Hansen](https://twitter.com/mjwhansen/status/1388246809211031552) & I started talking to my users. I found out I had a lot faults with Typo CI which would require a lot of work to fix.

The big discovery I've had was "the users who want to use Typo CI, often don't have the right level of permission within their organisation to install it". For example, a developer may want to help improve the spelling within their codebase by adding Typo CI, but to do this they need their boss to install it. This extra bit of friction would lead to the idea of installing Typo CI being suggested, but just never actioned.

One user I spoke to said "I can see Typo CI is spotting spelling mistakes in my code, but what should I do with them?". This made me think the approach of annotating Pull Requests with suggestions wasn't the most ideal solution.

### Competition

When I launched Typo CI, I think I was the only service on GitHub which would analyse code for spelling mistakes. Now via GitHub Actions there are a bunch of really good alternatives.

While I'd love to improve my Typo CI, ultimately the amount of work required to do that is to much for a side project.

### Stagnant Growth

When Typo CI first launched, the growth was super fast! Every day I'd look at my stats & see I'd gained a few new users...it was amazing!

In the last few months, Typo CI has had very little growth. I've been hovering around 550 installs which normally generates ~11,000 commits a week for analysis.

### Money

Typo CI started making a small profit a few months ago, however it has remained at just "a small profit". If I was to buy myself a few beers & spend a weekend working on Typo CI, the profit would be totally gone.

## What next?

I've opened a support request with GitHub to cancel all active subscriptions to Typo CI & remove it from the GitHub Marketplace. I expect that to take a few weeks to process, but once that's done I'll delete the app & shutdown the servers.

The current source can be found [on GitHub (and I've made it MIT)](https://github.com/TypoCI/Marketplace-App), I think it has some valuable parts so I'm happy to share it.

Finally, I have been thinking about how to encourage spell checking within code. I think a better solution would be a terminal command (like [Standard](https://github.com/testdouble/standard)) where a user just can run:

```bash
$ typo-lint --auto-fix
```

And then have all the spelling mistakes just fixed (Or warnings raised if run within a GitHub Action).
