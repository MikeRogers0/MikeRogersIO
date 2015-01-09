---
layout: post
title: I finally rebuilt my site :D
categories:
 – blog
published: true
meta:
  description: 
  index: false
---

I built the old design of my site with two goals in mind "Make it load fast" and "Make it 100% your work". I ended up nailing both goals by making a fairly plain and simple website, as a result it was dull as a white wall.

It started to look super naff recently, so while fueled by Wisky and Kanye West, I chucked out most of the old build and started again.

## Finding inspiration

I had a few websites I really liked the look of that I used for inspiration, here they are with my notes:

* [Clara Labs](https://claralabs.com) - I really like the inital "Hi there! I'm Clara" then the fading in of the rest of the homepage copy. 
* [No Divide](http://nodivide.us/) - If there is someone who knows how to design a site, it's Dan Edwards. I really like simple and clear the site is to use. 
* [Edward Poole](http://edpoole.me/articles/pubhack2/) The way Ed has layed out his blog post is super content focused with little to distract the user. 
* [Tom Kentell](http://tomkentell.me/) - I love the overall homepage layout & Toms use of responsive is awesome.
* [X | The Theme (themeforest)](http://themeforest.net/item/x-the-theme/full_screen_preview/5871901) - I like the way they've layed out the classic portfollio.
* [Meeet](http://meeet.co/) - Really lovely clean design that looks has little clutter to distract the user.
* [Jonathan Atkinson](http://themeforest.net/user/jonathan01/portfolio) - I always like Jonathan's work.
* [Plasso](https://plasso.co/) - Similar to meeet.co in terms of a super clear layout.

## The rebuild

I started doing inital sketches of what I had in mind for a layout and started coding. Here are some of the key changes 

### A colour palette

I've found from experience having a set of colours that were documented in the project, helped keep me from building massively inconsistent webpages. With this in mind, I jumped over to [Material Palette](http://www.materialpalette.com/) to get a set of colours that should work nicely together. 

Material palette was super handy and even generated a nice [Sass file](https://github.com/MikeRogers0/MikeRogersIO/blob/2015-epic/css/layout/_palette.scss) with the colours defined. I think it's helped keep the sites overall design not to messy.

### Stacked SVGs

I wanted to show off the tools and frameworks I'm fimilar with on the homepage, but I didn't want to dick around with making CSS sprites. Instead I converted the logos on the homepage into vectors then stacked them into a single SVG file. The result is 12 logos being servered in a single http request without to much loss in quality.

## Hosting

My old server was costing me about €18 a month, which for a site that only gets around ~2k hits a month it was overkill. Instead I moved everything over to S3

## Deploying

https://github.com/laurilehmijoki/s3_website - I use this gem to deploy the site.
https://bryce.fisher-fleig.org/blog/setting-up-ssl-on-aws-cloudfront-and-s3/ - I used this also
