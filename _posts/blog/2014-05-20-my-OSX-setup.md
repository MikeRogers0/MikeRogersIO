---
layout: post
title: My OSX setup
categories:
 – blog
published: true
meta:
  description: The brews I normally have to run to get setup
  index: true
---

I have a really simple setup for my Mac, the idea being I can quickly get setup and start working on a new machine without to much kerfuffle. Here is a quick overview of the code I normally use to get going quickly.

## Feel at home script

OSX has a few default settings that aren't great if you're a developer (Such as hiding file extensions). Ben Nunney wrote a [super useful shell script to quickly configure OSXs settings](https://gist.github.com/BenNunney/7219538), which I normally use.

After running Bens script, I run a few extra configuration settings to make OSX feel a little snappier:

{% gist 11140140 feels-like-home.sh %}

## Homebrew and Homebrew Cask

It's a super pain to go and install all the apps and scripts I need, so I install [Homebrew](http://brew.sh/) and [Homebrew Cask](http://caskroom.io/) to quickly install the stuff I want. Here are the essential libaries and apps I normally install:

{% gist 11140140 essential-brew.sh %}

## RVM

I use Vagrants for most my of development stuff, but it's pretty handy to have all the [RVM](http://rvm.io/) goodness all setup for when I want to do a small bit of code.

## Dotfiles

I try to keep [my dotfiles](https://github.com/MikeRogers0/dotfiles) as slim as I can so I can remember everything. For the most part I've just got a few aliases setup that I've nabbed from [Dan Harper](https://github.com/danharper/dotfiles) and [Phil Balchin](https://github.com/phil/dotfiles)
