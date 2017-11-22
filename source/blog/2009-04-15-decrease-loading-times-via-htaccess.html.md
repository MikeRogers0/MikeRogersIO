---
layout: post
title: Decrease loading times via .htaccess
tags:
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'A trick to reduce load times with .htaccess (gzipping)'
  index: true
---
Here is a really nifty trick I've been using for a while to decrease the time a page takes to load. Add the following lines of code to your .htaccess file:

{% gist 2907558 .htaccess %}

This quick and easy method tells the user to cache files which are unlikely to change for 10 years (feel free to change the amount of time) and HTML for 1 second. It also turns off eTags.

_Update:_ I also added a another piece of code I use which turns on Gzip, which reduces the amount of bandwidth required to transfer a file.
