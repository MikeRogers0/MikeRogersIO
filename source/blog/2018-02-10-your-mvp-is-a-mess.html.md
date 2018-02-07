---
layout: post
title: Your MVP is a mess
categories:
 – blog
published: true
meta:
  description: Fuck off making shit MVPs
  index: true
---

Quite often I'm approached by small companies who have a similar story. They hired a developer to build their MVP, and the other developer suddenly disappeared weeks before they wanted to launch.

Seriously. More often then not, the codebase is an unreadable tangled mess, which looks like the whoever worked on it before hand simply rolled their face across the keyboard until one of the lines of code worked.

I totally get why people want to cut corners, but when it leads to a shitshow...it's not MVP. It's maxium terrible product. It's not validating the idea, it's only validating that they can't hire decent developers.

## How to actually build a rails MVP

You do it fucking organised. Like don't waste time making decisions and figuring out how your tiny idea will work.

### yarn for bootstrap

Don't do your design yourself. You'll waste a lot of your time. Instead just use Bootstrap and follow its conventions.

### ActiveAdmin for admining

FFS, don't write your own admin panel. Just use ActiveAdmin or something, then just define your fields in their DSL.

### Simple forms - only list out the forms.

Again, don't do weird extra work. Just list your fields and let the gem do the extra let work. You'd be a dumbshit to do any extra.

### Devise for users - don't fuck it up.

Seriously, don't fuck this shit up. It pretty much does everything you need for a user to sign up and get using your product.

### Hosting - Heroku that mess

Seriously, no one can setup a server. Let alone you're 3-bit developer.
