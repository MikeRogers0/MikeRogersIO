---
layout: post
title: Tailwind To CSS
description: I converted a project from Tailwind to more vanilla CSS, I had some thoughts.
---

I've been playing around with Tailwind CSS a lot since it's release, and so far it's been really impressive to see its growth over the last few years.

Overall I've been pretty happy with it, I even purchased [Tailwind UI](https://tailwindui.com/) to help me develop prettier websites. However, I've also been quite frustrated with it at times, so I decided it would be fun to rebuild the frontend on my [Ruby Calendar project](https://ruby-meetup-calendar.mikerogers.io/) to see if I can pinpoint my annoyances.

## What I love about Tailwind CSS

- The documentation! Seriously Adam Wathan done a fantastic job with it. Often when I just want to check how to do something in plain CSS, I use their documentation as a reference point.
- Responsive utility variants are very cool. Being able to apply a CSS class to just big screens by using `lg:` before my regular class names is bliss!
- Being able to combine `@apply`. Being able to define my CSS in such a concise way, is super bliss.
- Less context switching between CSS & HTML. I didn't realise how much time I was burning by jumping between a HTML & CSS file mentally, so being able to just look at one file is nice.
- Copy & paste examples are amazing. It feels like I can very quickly cobble together an MVP for a frontend without to much effort required.

## What annoys me

- Preflight - I always find it's super aggressive, this is probably because I come from a background where I've used [normalize.css](https://necolas.github.io/normalize.css/) a lot. But having to setup base styling for semantic HTML feels tedious.
- JavaScript Dependencies - I had a project on Tailwind V1 which used React, when I went to upgrade to V2. I had a out of date library which made upgrading harder then I expected. I almost want Ta
- Other developers do it differently
- Long class definitions
- https://en.bem.info/methodology/key-concepts/
- Harder to follow breadcrumbs. I'd often adjust the configuration of Tailwind to remove some classes & add some custom components. Having to jump into a JavaScript file to change these later wasn't always the most obvious.
- PurgingCSS - I FUCKED IT UP A BUNCH.
- Staying consistent - I'm the worst for using all the sizing & colour variables, I need a limitation to avoid making a inconsistent monster.

## Replacing it with vanilla-er CSS

My plan was to remove Tailwind over a weekend, using a mix of `normalize.css`, CSS Variables & mixins using PostCSS to combine it into a single CSS file.

I had already started converting my CSS to follow BEM using `@apply`, so I was able to take my Purged CSS & break it into smaller files. I then went through and moved all the things like spacing, fonts & colours I was using into CSS Variables.

I next wanted to then reduce the amount of duplicated CSS for things like inline-lists & shadows, so I used Mixins to make it super easy to apply common snippets of CSS to multiple classes.

## Final Thoughts

Replacing Tailwind made me realise how much development time it was saving. I became super aware that while my HTML became much more easier to read, the amount of CSS I had written had increased but the final generated CSS was about the same size.

I liked that I had removed Tailwind as a dependency, but to give myself a enjoyable CSS experience I did end up using a few PostCSS plugins which also needed configuration. As users shouldn't need to touch the new configuration I'm not to worried about this, but ideally I'd like to get down to zero dependencies.

I'm still going to keep using Tailwind, but I think once a project becomes big enough I think the approach of "Here are the core CSS Variables you should use & here are some mixins to save time" is quite approachable.
