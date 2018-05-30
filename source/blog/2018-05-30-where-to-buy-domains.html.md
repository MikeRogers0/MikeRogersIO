---
layout: post
title: Where to buy your domains
categories:
 – blog
published: true
meta:
  description: Domain registrars is hard get right, here are the ones I like
  index: true
---

Where you buy your domain will have a small, but noticeable impact on the long term scalability of your web app.

As a rule of thumb, I look for three things:

  1. How locked in I am? - Can I move my domain if I find a better product? Unsurprisingly a few big name registrars are no fun to move away from.
  2. Do they support Root Domain CNAMEs? - This lets me host my website on a host like Heroku without having to use a `www.` prefix.
  3. How secure is their system? - Does it have 2FA and can I provide someone a limited login, if I need them to do work!
  4. Can I actually use their UI? - Seriously! Can I actually manage my domain.

## So who should you use?

Here are my current favourites:

  1. [AWS Route 53](https://aws.amazon.com/route53/) - You can register domains with Amazon! It's a nice no nonsense UI, though does cost $0.50 a month per a domain for DNS.
  2. [Gandi](https://www.gandi.net/en) - They support a large amount of TLDs and aren't to pricey.
  3. [Namecheap](https://www.namecheap.com/) - I used this group for a while, their support was pretty decent and they have some reasonably priced addons.
  4. [Hover](https://www.hover.com/) - They offer some of the more unusual TLDs.

## What if you are stuck with a rubbish registrar!

Luckily you can host your DNS somewhere else and avoid a lot of the registrar faff.

In this case, I normally use [AWS Route 53](https://aws.amazon.com/route53/) and [Cloudflare](https://www.cloudflare.com/), both offer a pretty clean UI and can also offer a free SSL certificate.
