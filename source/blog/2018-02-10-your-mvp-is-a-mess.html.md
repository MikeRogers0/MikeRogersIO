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

## Build it in something you can hire for

Hiring the right person is bloody difficult, limiting yourself to a specific language or framework won't make finding someone easier.

Your best bet is a freelancer who has delivered something similar, preferable local to you. Sit down, explain the most basic version of you idea, and then let them build it in what they think they can deliver in. 

Finding a decent freelancer won't be easy either. I recommend attending a local networking event & find some real people who can say "I've worked with this person, they're great".

// Sites I use for my locality.

## Make the most of Bootstrap Themes & Variables

It's very tempting to create a bespoke designs, but don't! Finding a top notch designer who can create something a developer can actually work with is next to impossible.

Instead use a fairly popular front-end library, which both your designer and developer will be familiar with. 

Personally I like Bootstrap, it gives a lot of flexibility in terms of editing the underlying (via it's _variables.scss) file, plus there are some pretty decent base themes to get you started.

// Examples

## Create a styleguide or component guide

Document your styles and things you build! It's a total waste of time to design something and hide it in a mess of hundreds of lines of code.

Setup something simple where common components can easily reviewed in isolation and can be easily used as a reference point when deciding UX.

// Examples

## Building a solid foundation

It's very easy to say "We'll rebuild when we're making money", but this is a toxic mindset. Like building a house, starting on a weak foundation will cause many more unnecessary problems down the line.

A MVP should be a simple version of your idea which validates people want it, but it's also it's going to be the what your use to attract the best talent to grow your product. If it's a total clusterfuck, you'll only attract the kind of talent who enjoys working in a clusterfuck.

A solid approach to look out for is a 12factor application approach.

Your app is the same. A good initial database design and architecture starts your off on a safe footing.

// Explain 12factor apps and why I love Heroku.

## Agree milestones with the people you work with

Having milestones with a fixed scope will help you stay focused on the first iteration of your product. 

Break your product into deliverables (Then those deliverables into tasks that should take at most 3 hours each), which can be reviewed atomically every 2-3 days on a 20 minute video call. 

Personally I'm a big fan of using Pivotal Tracker to manage this process. It's an agile project management tool which I've found to have a fairly minimal learning curve.

// I love pivotal. Like keep things bitesized. People are inherently scared of big tasks, if they're broken up into smaller bits it's easier.

## Separate marketing and your application

Don't waste your developers time on tweaking marketing copy and building landing pages. Use something where you can work asynchronously to your team.

// app.example.com / www.example.com

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
