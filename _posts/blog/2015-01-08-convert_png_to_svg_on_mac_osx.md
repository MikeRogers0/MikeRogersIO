---
layout: post
title: Convert .png to .svg on OSX
categories:
 – blog
published: false
meta:
  description: 
  index: false
---

brew install imagemagick
brew install potrace

convert somefile.png somefile.pnm 
potrace somefile.pnm -s -o somefile.svg
