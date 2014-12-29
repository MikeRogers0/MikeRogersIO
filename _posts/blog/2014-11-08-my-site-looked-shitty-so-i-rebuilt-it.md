---
layout: post
title: My site looked shitty so I rebuilt it 
categories:
 – blog
published: true
meta:
  description: 
  index: false
---

I built the old design of my site with two goals in mind "Make it load fast" & "Make it 100% your work". The first goal for speed was great, but I massively overestimated my ability to make a website that looked decent. With this in mind & while fueled by Wisky and Kanye West, I chucked out my old build and started again.

## Websites I liked
I had a few websites I really liked the look of that I used for inspiration, here they are with my notes:

* [Clara Labs](https://claralabs.com) - I really like the inital "Hi there! I'm Clara" then the fading in of the rest of the homepage copy. 
* [Dan Edwards](http://danedwards.me) - If there is someone who knows how to design a site, it's Dan Edwards. I really like the way Dan has layed out his portfollio on the homepage. 
* [Edward Poole](http://edpoole.me/articles/pubhack2/) The way Ed has layed out his blog post is super content focused & looks awesome.
* [Tom Kentell](http://tomkentell.me/) - I love the overall homepage layout & Toms use of responsive is awesome.
* [X | The Theme (themeforest)](http://themeforest.net/item/x-the-theme/full_screen_preview/5871901) - I like the way they've layed out the classic portfollio.
* [Bridge (themeforest)](http://themeforest.net/item/bridge-creative-multipurpose-wordpress-theme/full_screen_preview/7315054) - The services page will
* [Meeet](http://meeet.co/) 
* [Final](https://getfinal.com/)
* [Jonathan Atkinson](http://themeforest.net/user/jonathan01/portfolio) - I always like Jonathan's work.

## I might get assets from / use the following

* [GameDev Market](https://www.gamedevmarket.net/) - If I have time it will be super cool to have a mini game hidden on the site.
* [Dashboard starter kit](http://keen-starter-dashboard.brace.io/)
* [capistrano-s3](https://github.com/hooktstudios/capistrano-s3) - I think I'll host on S3 and a CDN. Screw dealing with servers.


## What I have in mind
I'm going to break up my site into 3 main sections: Homepage, Blog & Contact me. 

### Homepage
I'm going to assume anyone who hits my homepage meet me somewhere I wanted to see my portfollio. With them in mind, I'm going to take a similar appaoch as Clara Labs and start with a message like "Howdy! I'm Mike & I'm a Ruby On Rails developer". Then underneath have links to my portfollio and links to contact me.  

#### About me
I think having a few logos with the technologies I'm fimilar with would be pretty nice.

#### Portfollio
The old portfollio was never updated because I don't put out many fully finished products. I suspect my future portfollio will be the same, so I'm going to put a few of my current projects on the homepage linking off to them with a quick description.

### Blog
I'm going to keep my blog posts simple and centred without to much funky styling. 

### Contact me
I'm going to just have some links off to my email and twitter. I can't be bothered with making a contact form that'll just spam me.

## Technology
I used Jekyll on my last build and it was awesome, so I'll use it again.

### Servers and CDNs
I don't get much traffic, so I'm going to chef up a low end CloudVPS server that'll just server content up for CloudFlare or CloudFront to send to end users.

### Depoyment
On my last site I used git's hooks to complile my site. I've started using Capistano at work & I think it's awesome, so I think I'll use that on the new build.
