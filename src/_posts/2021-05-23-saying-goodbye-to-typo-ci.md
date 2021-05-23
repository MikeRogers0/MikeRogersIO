---
layout: post
title: Saying Goodbye To Typo CI
description: I decided it was time to close Typo CI. Before I pulled the plug, I want to document why it failed.
---

I started [Typo CI](https://typoci.com/) back in 2019, the idea was pretty simple, I wanted something that'll warn me when I've made a spelling mistake within my code.

![GitHub Check Preview](/2021/05/typo-ci-preview.png)

Over a quiet weekend, I built out the first version using Ruby on Rails. After a few hours, I had exactly what I wanted! After using it for a while privately, I decided I should open it up to the world via the GitHub Marketplace. It has been a pretty exciting 2 years.

Unfortunately I've decided it's time to shutdown Typo CI. I'm aiming to completely shutdown the service by the end of June 2021.

## Why am I closing it down?

This was a really difficult decision, but here is a summary of the main reasons.

### GitHub

I lost a lot of enthusiasm to build Typo CI after I started working with the GitHub Marketplace. I really feel that GitHub isn't interested in having 3rd Party Apps promoted on their platform any more.

One of the largest sources of frustration I had with the GitHub Marketplace was just being able to charge for usage. When I first launched, GitHub required I have at least 100 users before I could apply to add a paid tier (and I wasn't allow to handle billing myself as per their developer agreement). I reached the 100 user threshold in about a month, then *it took GitHub over 6 months to allow me to start charging for usage*.

Having to wait so long to validate if I had a product people would pay for was not great. But I was also quite upset that when I contacted GitHub, often I wouldn't hear a response for many weeks.

![GitHub Marketplace Insights - Missing data](/2021/05/typo-ci-stats.png)

I've also been quite disappointed with the tools available to me for the GitHub Marketplace. I can't create a coupon to help drive sales, I can't see where my traffic is coming from and _recently it has just stopped tracking the amount of views I had_ on my Marketplace listing.

While GitHub has [done work to improve their Marketplace](https://github.blog/2021-02-04-github-reduces-marketplace-transaction-fees-revamps-technology-partner-program/), I still feel it's a work in progress and they don't want to deal with small indie developers.

If I was to do this again, I'd ignore the GitHub Marketplace Developer Agreement & just handle billing myself via Stripe.

### Talking to Users

When I first started Typo CI, I didn't reach out & talk to my users. I only talked to a small handful of people I knew quite well.

Recently I followed the advice from [Michele Hansen](https://twitter.com/mjwhansen/status/1388246809211031552) & I started talking to my users. I found out I had a lot of faults with Typo CI which would require a lot of work to fix.

The big discovery I've had was "the users who want to use Typo CI, often don't have the right level of permission within their organisation to install it". For example, a developer may want to help improve the spelling within their codebase by adding Typo CI, but to do this they need their boss to install it. This extra bit of friction would lead to the idea of installing Typo CI being suggested, but just never actioned.

![An annotation within a Pull Request](/2021/05/typo-ci-annotation.png)

Another user I spoke to said "I can see Typo CI is spotting spelling mistakes in my code, but what should I do with them?". This made me think the approach of annotating Pull Requests with suggestions wasn't the most ideal solution.

I really regret not reaching out to my first users while I was full of enthusiasm, and _just finding out how I could have made a much better product_.

### Competition

When I launched Typo CI, I think I was the only service on GitHub which would analyse code for spelling mistakes. Now via GitHub Actions there are a bunch of really good alternatives.

While I'd love to improve Typo CI, ultimately unless I can be radically better, the work required isn't worth it.

### Stagnant Growth

When Typo CI first launched, the growth was super fast! Every day I'd look at my stats & see I'd gained a few new users...it was amazing! I felt like I was onto a real winner.

In the last few months, Typo CI has had very little growth. I've been hovering around 550 installs which normally generates ~11,000 commits a week for analysis. While not a small number, the lack of growth is not a great sign.

### Revenue

Typo CI started making a small profit a few months ago, however it has remained at just "a small profit". If I was to buy myself a few beers & spend a weekend working on Typo CI, the profit would be totally gone.

I've really struggled to convert users to a paid tier. Currently for every paid user, I have 50 free users. This isn't a bad ratio, but with so few paying users in total it feels very risky.

Also GitHub handles the payout of the revenue Typo CI makes & it has a $500 payout threshold. As I only have a few paid users, it can be a long wait between payments from GitHub.

## What next?

I've opened a support request with GitHub to cancel all active subscriptions to Typo CI & remove it from the GitHub Marketplace. I expect that to take a few weeks to process, but once that's done I'll delete the app & shutdown the servers.

The current source can be found [on GitHub (and I've made it MIT)](https://github.com/TypoCI/Marketplace-App), I think it has some valuable parts so I'm happy to share it.

Finally, I have been thinking about how to encourage spell checking within code. I think a better solution would be a terminal command (like [Standard](https://github.com/testdouble/standard)) where a user just can run:

```bash
$ typo-lint --auto-fix
```

And then have all the spelling mistakes just fixed (Or warnings raised if run within a GitHub Action). One day I might come back & try to make something like that, but for now I'm focusing on some other projects.
