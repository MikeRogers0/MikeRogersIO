---
layout: post
title: Geeklet for monitoring server ping
published: true
categories:
 – blog
meta:
  description: A geektool geeklet code sample that shows server status and ping.
  index: true
---

I've been using [Geektool](http://projects.tynsoe.org/en/geektool/) for a while now, it's a super handy way to display useful information on my desktop. One geeklet I've found to be useful displays the status and ping of my VPS.

{% img /uploads/2014/01/18/uptime-monitor-geeklet.png 168x50 "Server name and its ping" %}

## Geeklet code
Here is the code you need to stick in the command box.

{% gist 8492860 uptime-monitor.sh %}

To modify the websites being pinged, just edit the $servers array on line 4.
