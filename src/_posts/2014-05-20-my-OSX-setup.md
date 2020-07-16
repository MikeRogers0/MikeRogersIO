---
layout: post
title: My OSX setup
description: The brews I normally have to run to get setup
---

I have a really simple setup for my Mac, the idea being I can quickly get setup and start working on a new machine without to much kerfuffle. Here is a quick overview of the code I normally use to get going quickly.

## Feel at home script

OSX has a few default settings that aren't great if you're a developer (Such as hiding file extensions). Ben Nunney wrote a [super useful shell script to quickly configure OSXs settings](https://gist.github.com/BenNunney/7219538), which I normally use.

After running Bens script, I run a few extra configuration settings to make OSX feel a little snappier:

```bash
#!/usr/bin/env sh
#
# Make OSX feel a little snappier, I normally run this after running https://gist.github.com/BenNunney/7219538

# Speed up window transitions
defaults write NSGlobalDomain NSWindowResizeTime 0.01;

# Speed up mission control transition (F3)
defaults write com.apple.dock expose-animation-duration -float 0.1; 

# Speed up Launchpad (F4)
defaults write com.apple.dock springboard-show-duration -float 0.1;
defaults write com.apple.dock springboard-hide-duration -float 0.1;

# Stop dock item jumping when they want my attention
defaults write com.apple.dock no-bouncing -bool TRUE;

# Set preview to default screenshots to jpg.
defaults write com.apple.screencapture type jpg
killall SystemUIServer

# Restart dock so effects can kick in.
killall Dock;

# Turn off volume change overlays 
sudo defaults write /System/Library/LaunchAgents/com.apple.BezelUI Disabled --bool YES
```

## Homebrew and Homebrew Cask

It's a super pain to go and install all the apps and scripts I need, so I install [Homebrew](https://brew.sh/) and [Homebrew Cask](https://formulae.brew.sh/cask/) to quickly install the stuff I want. Here are the essential libraries and apps I normally install:

```bash
#!/usr/bin/env sh
#
# Things I normally install when I first install Homebrew / Homebrew cask
# Make sure you've install XCode commandline tools & accepted the terms and conditions before running this.

# Homebrew stuff

## A nice text editor (Will show how to configure in another post)
brew install vim
brew install macvim

## Git 
brew install git
### Set the global configs for git
git config --global core.editor "vim"
git config --global push.default current

## Make searching in Vim easier.
brew install ack
brew install the_silver_searcher

## Node.JS
brew install node

## S3CMD - Makes it easy to talk to AWS S3
brew install s3cmd

## Makes adding SSH keys to servers easier.
brew install ssh-copy-id

# Homebrew Cask bits

## Development tools
brew cask install integrity
brew cask install virtualbox
brew cask install vagrant

## Firewall
brew cask install little-snitch
### I love little snitch, mostly because I setup the rules to stop Spotify connecting in P2P mode (My ISP sucks and throttles me when I p2p).

## Apps I use often
brew cask install google-chrome
brew cask install alfred
brew cask install flux
brew cask install steam
brew cask install transmission
brew cask install vlc
brew cask install spotify
brew cask install geektool
```

## RVM

I use Vagrants for most my of development stuff, but it's pretty handy to have all the [RVM](http://rvm.io/) goodness all setup for when I want to do a small bit of code.

## Dotfiles

I try to keep [my dotfiles](https://github.com/MikeRogers0/dotfiles) as slim as I can so I can remember everything. For the most part I've just got a few aliases setup that I've nabbed from [Dan Harper](https://github.com/danharper/dotfiles) and [Phil Balchin](https://github.com/phil/dotfiles)
