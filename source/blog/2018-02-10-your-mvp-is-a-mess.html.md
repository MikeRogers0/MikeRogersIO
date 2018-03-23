---
layout: post
title: Your MVP is a mess
categories:
 – blog
published: true
meta:
  description: 4 ways to build your MVP more lean
  index: true
---

Quite often I'm approached by small companies who have a similar story. They hired a developer to build their MVP, and the other developer suddenly disappeared weeks before they wanted to launch.

Seriously. More often then not, the codebase is an unreadable tangled mess, which looks like the whoever worked on it before hand simply rolled their face across the keyboard until one of the lines of code worked.

I totally get why people want to cut corners, but when it leads to a shitshow...it's not MVP. It's maxium terrible product. It's not validating the idea, it's only validating that they can't hire decent developers.

## Make the most of Bootstrap Themes & Variables

It's very tempting to create a bespoke designs, but don't! Finding a top notch designer who can create something a developer can actually work with is next to impossible.

Bootstrap gives a lot of flexibility in terms of editing the underlying (via it's _variables.scss) file, plus there are some pretty decent base themes to get you started.

// Examples

## Create a styleguide or component guide

Document your styles and things you build! It's a total waste of time to design something and hide it in hundreds of lines of code. Setup something simple where common components can be reused, instead of rebuild.

//Examples

## Build it in something you can hire for

Hiring the right person is bloody difficult. Finding someone who'll be able to build the first iteration at a reasonable price will be an uphill struggle, truth be told the best developers are in comfortable jobs & wouldn't take the risk.

Your best bet is a freelancer with a similar track record, preferable local.

// Sites I use for my locality.

## Hosting - Starting on the right now.

MVPs are meant to be the simplest form of your app to validate it can be made (and people want it), but they will end up being the foundation of your future builds. Like a house, adjusting the manciple plumbing which keeps the house working is a mammoth task.

Your app is the same. A good initial database design and architecture starts your off on a safe footing.

// Explain 12factor apps and why I love Heroku.

## Setting KPIs and keeping on track

// I love pivotal. Like keep things bitesized. People are inherently scared of big tasks, if they're broken up into smaller bits it's easier.

-- Shit after this point --

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
