---
layout: post
title: Moving From Tailwind To CSS Variables
description: I converted a project from Tailwind CSS to more vanilla-er CSS (i.e using CSS Variables, normalize.css, Mixins & PostCSS). This demonstrates the new code & my thoughts on using Tailwind going forward.
---

I've been playing around with Tailwind CSS a lot since it's release, and so far it's been really impressive to see its growth over the last few years, along with some of the neat things people are making with it.

Overall I've been pretty happy with it, I even purchased a licence for [Tailwind UI](https://tailwindui.com/) to help me develop with it more quickly. However, sometimes I find myself a little frustrated at it, so I decided it would be fun to rebuild the frontend on my [Ruby Calendar project](https://ruby-meetup-calendar.mikerogers.io/) to see if I can pinpoint my annoyances.

## What I love about Tailwind CSS

- The documentation! Seriously Adam Wathan done a fantastic job with it. Often when I just want to check how to do something in plain CSS, I use their documentation as a reference point.
- Responsive utility variants are very cool. Being able to apply a CSS class to just big screens by using `lg:` before my class names is super lovely!
- Using `@apply` within my regular CSS. It feels like such a concise way to write CSS, I'm a big fan of it.
- Less context switching between CSS & HTML files. I didn't realise how much cognitive load I had from jumping between different file types all day. Being able to just look at a single file for everything I was working on helped me get into that awesome "hyper focus" zone a lot more easily.
- The examples I can copy & paste (which look the same in my project), is a massive time saver. It feels like I can very quickly cobble together a frontend MVP for a project without too much effort.

## What I don't love

- Preflight. I always find it's super aggressive, this is probably because I come from a background where I've used [normalize.css](https://necolas.github.io/normalize.css/) a lot. Having to setup base styling for semantic HTML feels tedious.
- JavaScript Dependencies. I had a project on Tailwind V1 which used React, which I upgraded to V2. Unfortunately I had an out of date library which made upgrading harder then I expected. In the end, I was deep in JavaScript code trying to figure out why my CSS wasn't working. It made me feel super unproductive.
- Other developers use it inconsistently. I've picked up a few projects using Tailwind, and it takes a lot time to feel "at home" in the codebase. In one project, I felt like the other developer just used every class everywhere, which made it very hard to achieve that "Happy Developer" moment.
- CSS Purging. I've been caught out in the past by setting up the purging, then moving a few files around to only discover I quietly broken a few pages in production. I think better CI tooling could solve this, but I'm also feeling I'd rather avoid the risk to start with.
- Staying visually consistent. I'm the worst for using all the sizing & colour variants available to me, I need a limitations to avoid making an inconsistent monster.

## Replacing it with vanilla-er CSS

My plan was to remove Tailwind over a weekend, using a mix of `normalize.css`, CSS Variables & mixins, all combined into a single CSS file using PostCSS.

I had already started converting my CSS to follow the [BEM approach](https://en.bem.info/) using `@apply`, so I was able to take my purged CSS & break it into smaller files. I then went through and moved all the things like spacing, fonts & colours I was using into CSS Variables.

### Why vanilla-er CSS?

I wanted to be as close to simple vanilla CSS as possible, the reason is I worked on a project which hadn't had the styling touched in about 5 years, and then when I edited the `styles.css` file...it just changed what I expected it  to. It was a really interesting "Oh? Would you look at that!" type experience.

Obviously, I do like a few low touch tools to help reduce duplication. But I do want to aim for a codebase where in 5 years time, it'll be easy to pickup. I think the best way to do that is by keeping things as simple as possible.

### Naming CSS Variables

Naming was pretty hard! For my fonts & spacing, I ended up copying the approach of using numbered a scale which is often used in Tailwind.

```css
/* variables/fonts.css */

:root {
  --fonts-serif: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont,
    'Segoe UI', Roboto, 'Helvetica Neue', Arial, 'Noto Sans', sans-serif,
    'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';

  --font-size-1: 0.75rem;
  --font-size-2: 0.875rem;
  --font-size-3: 1rem;
  --font-size-4: 1.125rem;
  --font-size-5: 1.25rem;
  --font-size-6: 1.5rem;
  --font-size-7: 1.875rem;
}
```

```css
/* variables/spacing.css */

:root {
  --spacing-1: 0.25rem;
  --spacing-2: 0.5rem;
  --spacing-3: 0.75rem;
  --spacing-4: 1rem;
  --spacing-5: 1.25rem;
  --spacing-6: 1.5rem;
}
```

#### Naming Colours

Naming the colours was a tad harder. I've never been a fan of calling a variable "blue", then making it the colour blue. The reason is often in the future that "blue" may end up not being blue, which makes things messy.

Instead I copied the approach of [Bootstrap](https://getbootstrap.com/docs/5.0/customize/color/) of having "Primary", "Secondary" & "Tertiary" colours, however I explicitly named the variables to hint that the colour is intended to be used as a background or text.

```css
/* variables/colours.css */

:root {
  --background-primary: #3c2aaa;
  --background-secondary: #1d2938;
  --background-secondary-lightest: #3f4a5b;
  --background-secondary-light: #232c39;
  --background-secondary-dark: #0f192c;
  --background-tertiary: #d0d5dc;
  --background-tertiary-light: #ffffff;

  --text-primary: #f9fafb;
  --text-primary-darker: #a1a1ab;

  --link-primary: #c5d1ff;

  --border-primary: #273241;
}
```

I did also add `*-light` & `*-dark` variations of these colours (For use within hovers & whatnot), though I do want to come back and improve the suffixes I chose.

Ideally I want to achieve variable names which make other developers say out loud "This is so obvious, I know exactly what this is for". If anyone has any ideas please let me know :)

### Media Queries

I wanted a way to pre-define the common screen sizes I'd use when building out my responsive designs.

To solve this I used [postcss-preset-env](https://github.com/csstools/postcss-preset-env#postcss-preset-env-), which allowed me to define a "custom-media" with the name `--viewport-lg` and the value `(min-width: 1024px)`. As `postcss-preset-env` also supported nested CSS this allowed for some pretty readable CSS.

```scss
/* components/footer.css */

.footer {
  padding: var(--spacing-4);
  padding-bottom: var(--spacing-6);
  text-align: center;

  @media (--viewport-lg) {
    text-align: left;
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}
```

### Mixins

Pretty soon I did feel like I was duplicating CSS & mixing utility classes with my semantically named classes within my HTML.

However, I found the solution was to use mixins via [postcss-mixins](https://github.com/postcss/postcss-mixins).

```scss
/* mixins/list-inline.css */

@define-mixin list-inline {
  list-style: none;
  margin-left: calc(var(--spacing-2) * -1);
  margin-right: calc(var(--spacing-2) * -1);
  padding: 0;

  > li {
    display: inline-block;
    padding: 0 var(--spacing-2);
  }
}
```

```scss
/* components/navbar.css */

/**
 * @markup
 *  <ul class="navbar__links">
 *    <li><a href="/groups">All Groups</a></li>
 *    <li><a href="/add-event">Add Event</a></li>
 *  </ul>
 */
.navbar__links {
  @mixin list-inline;
  margin-top: 0;
  margin-bottom: 0;
  display: none;

  @media (--viewport-md) {
    display: block;
    margin-left: auto;
  }
}
```

This allowed me to have semantic looking class names which included common CSS snippets, while being able to override things as required. It also gave me the potential to [programmatically generate a styleguide](https://css-tricks.com/options-programmatically-documenting-css/) from the comments within my CSS file, which I'm wildly excited about.

### Easier Importing

As my project grew, I found I could glob import files via [postcss-import-ext-glob](https://github.com/dimitrinicolas/postcss-import-ext-glob), which made my `index.css` file much more maintainable:

```css
/* index.css */

@import-glob "variables/*.css";

/* External Libraries imported from node_modules */
@import-glob 'normalize.css';

@import-glob "base/*.css";
@import-glob "components/*.css";
@import-glob "utilities/*.css";
```

## Final Thoughts

Overall, I'm very happy with this CSS & HTML approach. I can look at a snippet of HTML, see the CSS classes being used & know exactly which files I need to edit to change them. I feel very in control of the CSS I'm writing as a result of that.

While reviewing my new HTML & CSS, I really like that I'm not staring at a wall of CSS class names any more. Plus if I wanted to make any changes to the colours, spacing or fonts, I feel confident that I won't need to change lots of files to see the desired visual change. Instead I can open the `variables/` folder, then the appropriately named file & edit just a few lines of CSS.

I also found the final size of the generated CSS was about the same as before, so I'm very happy with that.

I did come to appreciate how much time Tailwind had saved me while I was prototyping my design (and how it made me think more in a component mindset), but I think it's also a very sharp tool which requires a lot of discipline to use effectively on projects.

Finally, I think I'd still be happy to work on a Tailwind based project. However, I totally feel a bit more confident in saying "We could just use CSS Variables & Mixins instead if we wanted".
