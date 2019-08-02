---
layout: post
title: List current active connections on Mac OSX
tags:
- Coding
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'A shell script that shows active connections on Mac OSX'
  index: true
---
This is a handy little terminal script I've used a lot recently which lists the current active connections on OSX. It's really handy for seeing if Apache / Node.js / Ruby stuff is running on ports correctly.

```bash
lsof -i | grep -E "(LISTEN|ESTABLISHED)" 
```
