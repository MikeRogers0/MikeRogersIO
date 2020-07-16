---
layout: post
title: List current active connections on Mac OSX
description: A shell script that shows active connections on Mac OSX
---
This is a handy little terminal script I've used a lot recently which lists the current active connections on OSX. It's really handy for seeing if Apache / Node.js / Ruby stuff is running on ports correctly.

```bash
lsof -i | grep -E "(LISTEN|ESTABLISHED)" 
```
