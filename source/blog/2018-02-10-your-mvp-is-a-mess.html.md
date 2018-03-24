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

Does this scenario sound familiar? You've hired a someone to build your MVP, things were going pretty well then a few weeks before you want to launch, they kind of start flaking out.

I've heard variations of this story a few times. More often then not, the codebase is an unreadable tangled mess, which looks like the whoever worked on it before hand simply rolled their face across the keyboard until one of the lines of code worked.

Instead of building an minimal viable product, you've ended up with a maximum terrible product. The only thing validated is that hiring people is hard.

Here is some lessons I've learnt while building out products for clients over the past 4 years of freelancing.

## Find someone local who has a track record

Finding a decent freelancer won't be easy. I recommend attending a local networking event (Search online for your "[Your City Name] + Freelance Meetup"), find some real people who can say "I've worked with this person I can recommend, they're great".

Once you've found someone, look at their portfolio of work, it should have a decent amount of elements of what you'd like to build. Then sit down with them, explain the most basic version of your idea, and then let them build it in what they think they can deliver in.

## Make the most of Bootstrap Themes & Variables

It's very tempting to create a bespoke designs, but don't! Finding a top notch designer who can create something a developer can actually work with is next to impossible.

Instead make sure you're using a fairly popular front-end library, which both your designer and developer are familiar with. 

Personally I like Bootstrap, it gives a lot of flexibility in terms of editing the underlying (via it's [_variables.scss](https://github.com/twbs/bootstrap/blob/v4-dev/scss/_variables.scss)) file, plus there are some pretty decent [base themes](https://themes.getbootstrap.com/) to get you started.

## Create a styleguide or component guide

Document your styles and things you build! It's a total waste of time to design something and hide it in a mess of hundreds of lines of code.

Setup something simple where common components can easily reviewed in isolation and can be easily used as a reference point when deciding UX.

Here are some good examples of what to aim for:

- [Lonely Planet Styleguide](http://rizzo.lonelyplanet.com/styleguide/ui-components/buttons) - The Lonely Planet has documented what each component on their website should look like, each with a HTML code to get to that point.
- [Nick Berens Atomic Core](http://www.nickberens.me/atomic-docs/atomic-core/atoms.php#buttons) - This Atomic Core has a bunch of code samples next to their output.
- [Website Style Guide Resources](http://styleguides.io/) - Other styleguide examples can be found on this site if you need more inspiration.

## Agree milestones with the people you work with

Having milestones with a fixed scope will help you stay focused on the first iteration of your product. 

Break your product into deliverables (Then those deliverables into tasks that should take at most 3 hours each), which can be reviewed atomically every 2-3 days on a 20 minute video call. 

Personally I'm a big fan of using [Pivotal Tracker](https://www.pivotaltracker.com/) to manage this process. It's an agile project management tool which I've found to have a fairly minimal learning curve.

## Building a solid foundation

It's very easy to say "We'll rebuild when we're making money", but this is a toxic mindset. Like building a house, starting on a weak foundation will cause many more unnecessary problems down the line.

A MVP should be a simple version of your idea which validates people want it, but it's also it's going to be the what your use to attract the best talent to grow your product. If it's a total clusterfuck, you'll only attract the kind of talent who enjoys working in a clusterfuck.

When assembling your team, lookout for people who can demonstrate they've work with services such as:

- [CodeClimate](https://codeclimate.com/) - A code quality monitoring tool. Code is difficult to perfect, but getting everyone to write to the same standard keeps things tidy.
- [Travis CI](https://travis-ci.org/) - An automated testing tool. I'm a big believer in tests, even in an MVP I'd expect a few simple integration tests covering the most critical user stories.
- [Heroku](https://www.heroku.com/) - A platform-as-a-service hosting environment. Heroku inherently encourages a [twelve-factor app](https://12factor.net/) approach to building, which will help as you scale your app.

## Separate marketing and your application

Don't waste your developers time on tweaking marketing copy and building landing pages. Use something where you can work asynchronously to your team.

// app.example.com / www.example.com
