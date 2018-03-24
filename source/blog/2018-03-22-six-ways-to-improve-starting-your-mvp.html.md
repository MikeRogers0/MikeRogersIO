---
layout: post
title: Six ways to get your MVP off to a strong start
categories:
 – blog
published: true
meta:
  description: I've learnt a lot helping small companies launch new products, here are some thoughts.
  index: true
---

Does this scenario sound familiar? You've hired a someone to build your MVP, things were going pretty well, then a few weeks before you want to launch, they start flaking out & simply don't deliver.

I've heard variations of this story a few times. More often then not, the codebase is an unreadable tangled mess, which looks like whoever worked on it before hand simply rolled their face across the keyboard until one of the lines of code worked.

Instead of building an minimal viable product, you've ended up with a maximum terrible product. The only thing validated is that hiring people is hard.

Here are some lessons I've learnt while building out products for clients over the past few years of freelancing.

## Find someone local who has a track record

Finding a decent freelancer won't be easy. I recommend attending a local networking event (Search online for "[Your City Name] + Freelance Meetup"), find some real people who can say "I've worked with this person I can recommend, they're great".

Once you've found someone, look at their portfolio of work, it should have a decent amount of elements of what you'd like to build. Then sit down with them, explain the most basic version of your idea, and then let them build it in what they think they can deliver in. Don't set arbitrary technology restraints, just let them work.

## Make the most of Bootstrap Variables & Themes

It's very tempting to create a bespoke designs, but don't! Finding a top notch designer who can create something a developer can actually work with is next to impossible.

Instead use a fairly popular front-end library, which both your designer and developer are familiar with. 

Personally I like [Bootstrap](https://getbootstrap.com/), it gives a lot of flexibility in terms of editing the underlying (via it's [_variables.scss](https://github.com/twbs/bootstrap/blob/v4-dev/scss/_variables.scss)) file, plus there are some pretty decent [base themes](https://themes.getbootstrap.com/) to get you started.

## Create a styleguide or component library

Document your styles and things you build! It's a total waste of time to design something and hide it in a mess of hundreds of lines of code.

Instead setup something simple where common components can be reviewed in isolation, and used as a reference point when deciding UX.

Here are some good examples of what to aim for:

- [Lonely Planet Styleguide](http://rizzo.lonelyplanet.com/styleguide/ui-components/buttons) - The Lonely Planet has documented what each component on their website should look like, each with a snippet of code to get to that point.
- [Nick Berens Atomic Core](http://www.nickberens.me/atomic-docs/atomic-core/atoms.php#buttons) - Atomic Core has a similar approach of code sample with their expected output.
- [Website Style Guide Resources](http://styleguides.io/) - Other styleguide examples can be found on this site if you need more inspiration.

## Agree milestones with the people you work with

Having milestones with a fixed scope will help you stay focused on the first iteration of your product. It's very easy to lose focus & spend way to much time on nice, but irrelevant ideas.

Break your product into deliverables (Then those deliverables into tasks that should take at most 3 hours each), which can be reviewed atomically every day on a 20 minute video call. 

Personally I'm a big fan of using [Pivotal Tracker](https://www.pivotaltracker.com/) to manage this process. It's an agile project management tool which I've found to have a fairly minimal learning curve.

## Building a solid foundation

It's very easy to say "We'll rebuild when we're making money", but your MVP will also be used to attract the best talent to grow your product.

If it's a total mess, you'll only attract the kind of people who either don't realise it's a mess, or people who think a mess is the norm.

When assembling your team, lookout for people who can demonstrate they want other people reviewing their work, and are mindful enough to think about what happens to the next set of hands they'll potentially be working with.

## Separate marketing and your application

Nothing is worse then stretching the workload of developers into the realm of marketing. Odds are the person who specialise in application development will be able to do some marketing, but will suck at it.

A more effective technique I've used on a few products, is to separate the marketing side of your product from the application by a subdomain. 

This means having marketing material living on `www.example.com` which is hosted on something like [Squarespace](https://www.squarespace.com/) (which is fairly easy for marketing teams to manage content), then `app.example.com` where the main product lives.
