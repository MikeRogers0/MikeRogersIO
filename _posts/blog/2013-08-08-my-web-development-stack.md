---
layout: post
title: My Web Development Stack
published: true
categories:
 – blog
meta:
  description: 'A few details about my local development environment and software I use.'
  index: true
---
I've been building websites for a while now, I'm by no means a seasoned web developer but I think my current stack is a fairly effective setup. Here is some details about the setup.

## Local Development
### Mac OSX
I've been using OSX for development for a while now. While I'm still a bit of a Ubuntu fan at heart, I don't like running Photoshop under WINE so OSX tends to be my preferred OS. 

Right now I have a late 2011 13" MacBook Pro, it's not great for gaming, but it can survive a 6 hour coding session on a single charge.

#### Terminal
Since learning how to SSH into my VPS, I've become really fond of using terminal for as much as possible. It's really helpful that  Linux and OSX are from the POSIX family.

#### Homebrew / Homebrew Cask
I have a small SSD (120GB). Out of habit I like to reinstall my OS every 6 months or so to clear out my unused applications and files. I find [Homebrew](http://brew.sh/) and [Homebrew Cask](https://github.com/phinze/homebrew-cask) are really handy for reinstalling my favourite applications quickly. 

#### Sublime Text 2
I used to use Coda for developing, but I found the FTP features extra bloat which I never used. I love that I can configure sublime for my needs.

### Vagrant
I used to use XAMP / MAMP and then OSX's built in Apache server,  however I found it a pain to keep the configurations consistent between machines and similar to my server. I started using Vagrant a few months ago for my PHP projects and I've not looked back.

#### Puppet
I provision my Vagrant VM's with Puppet. I've been meaning to look into [Ansible](http://www.ansibleworks.com/), but for now Puppet suits my needs.

### SCSS
Keeping CSS organised can be a big task. I started using SCSS over LESS a few months ago and really liked it, plus I can configure my server to compile the SCSS using a post-recieve hook.

## Staging / Live Server
### Nginx (with mod_pagespeed)
I used to use Apache and I'm fairly confident with it. However, about 2 years ago I decided I should branch out and explore lighthttp and Nginx, mostly just to see what all the fuss was about. It took me a little while to start understanding what was going on, but once it started to click I thought it was something I should stick with.

The [mod_pagespeed module](https://developers.google.com/speed/pagespeed/module/) is made by Google and looks through the HTML, CSS, JS and images making a best judgement as to if the file needs minification, concatenation or optimisation. It allows me to focus on writing maintainable code while providing the end user with the pretty quick experience. 

### Varnish Cache
My server is small & mostly just for me, Varnish Cache helps handle any spikes in traffic and keeps webpage load times down.

### MariaDB
MySQL is fine, but I would rather put my eggs in a more open source basket. I found moving to MariaDB easy as it's merely a matter of uninstalling MySQL and installing MariaDB.

## Misc
### Git
I use Git for version control and deployment. I've been meaning to learn Capastrino, but as I've really only deployed to a single server it's still on my todo.
