---
layout: post
title: I finally rebuilt my site :D
categories:
 – blog
published: true
meta:
  description: A overview of some of the techniques I used to quickly rebuild my site
  index: true
---

I built the old design of my site with two goals in mind, "Make it load fast" and "Make it 100% your work". I ended up nailing both goals by making a fairly plain and simple website, as a result it was dull as a white wall.

It has started to look super naff recently, so while fueled by Whisky and Kanye West, I chucked out most of the old build and started again.

## Finding inspiration

I had a few websites I really liked the look of that I used for inspiration, here they are with my notes:

* [Clara Labs](https://claralabs.com) - I really like the initial "Hi there! I'm Clara" then the fading in of the rest of the homepage copy. 
* [No Divide](http://nodivide.us/) - If there is someone who knows how to design a site, it's Dan Edwards. I really like how simple and clear the site is to use. 
* [Ed Poole](http://edpoole.me/articles/pubhack2/) - The way Ed has layed out his blog post is super content focused with little to distract the user, it works really well. 
* [Tom Kentell](http://tomkentell.me/) - I love the overall homepage layout & Toms use of responsive is awesome.
* [Meeet](http://meeet.co/) - A lovely clean design that looks good and has little clutter that'll distract the user.
* [Jonathan Atkinson](http://themeforest.net/user/jonathan01/portfolio) - I always like Jonathan's work.
* [Plasso](https://plasso.co/) - Similar to meeet.co in terms of a super clear layout.

## The rebuild

I started doing initial sketches of what I had in mind for a layout and started coding. Here are some of the key changes: 

### A colour palette

I've found from experience having a set of colours that were documented in the project, helped keep me from building massively inconsistent webpages. With this in mind, I jumped over to [Material Palette](http://www.materialpalette.com/) to get a set of colours that should work nicely together. 

Material palette was super handy and even generated a nice [Sass file](https://github.com/MikeRogers0/MikeRogersIO/blob/2015-epic/css/layout/_palette.scss) with the colours defined. I think it's helped keep the sites overall design not to messy.

### Inline SVGs

I wanted to show off the tools and frameworks I'm familiar with on the homepage, but I didn't want to dick around with making CSS sprites. Instead I converted the logos on the homepage into vectors then stacked them into a single SVG file. The result was 12 logos being served in a single http request without to much loss in quality. 

{% img src: /uploads/2015/01/08/stacked_svgs_in_safari.jpg width: 820 alt: "Stacked SVGs rendering incorrectly in Safari" %}

This worked great until I opened the site in Safari (The above screenshot) and noticed they looked a bit off, so I opted just to put the SVG inline into the HTML instead.

### Bower, Bootstrap and other things I decided against

I really wanted to mess around with a few of the new tools and frameworks that are out there to make front end a bit easier.

First off I tried [bower](http://bower.io/), a fontend package manager tool. It seemed pretty nice, though I ended up feeling it was more faff then it was worth considering my site only uses a little JS on the homepage. 

I also considered a CSS framework such as Bootstrap or Foundation to help get the layout kick started, but then I read [A Complete Guide to Flexbox](http://css-tricks.com/snippets/css/a-guide-to-flexbox/) and decided I'd be better off just using flex where I needed it instead of bogging myself down with CSS I'll never use.

I also removed a lot of the Microdata markup that I had on the old build, as I feel in the last year the support has fizzled out a lot.

## Hosting

My old server was costing me about €18 a month, which for a site that only gets around ~2k hits a month it was overkill. Instead I moved everything over to S3 & CloudFront. 

It was a bit of a pain to get SSL setup for CloudFront but I followed [this guide](https://bryce.fisher-fleig.org/blog/setting-up-ssl-on-aws-cloudfront-and-s3/) to find my feet. One of the main "Oh FFS" moments was when I had to setup CloudFront to only access S3 over port 80, instead of both port 80 and 443, otherwise it would error out.

## Deploying

I used to use Git to deploy my site, which was annoying to get the hooks setup on new machines. Instead I opted to use [s3_website](https://github.com/laurilehmijoki/s3_website), a gem that pushes your _site folder to S3. It seems pretty solid.
