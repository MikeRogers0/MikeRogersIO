---
layout: post
title: Cron Jobs and cPanel
tags:
- Coding
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'How to set up and cron job in cPanel'
  index: true
---
A cron is a program which allows users to execute scripts at a specified time and date. In the web development world they are normally used to update caches or run complex pieces of code (this in theory should improve the user experience).

In this short video I will explain the basics of crons & how to run a PHP at a regular interval.

{% youtube L5_5NxP83LE %}

## PHP Cron Commands

```bash
Usage: php [-q] [-h] [-s] [-v] [-i] [-f <file>]
php <file> [args...]
-a               Run interactively
-C               Do not chdir to the script's directory
-c <path>|<file> Look for php.ini file in this directory
-n               No php.ini file will be used
-d foo[=bar]     Define INI entry foo with value 'bar'
-e               Generate extended information for debugger/profiler
-f <file>        Parse <file>.  Implies `-q'
-h               This help
-i               PHP information
-l               Syntax check only (lint)
-m               Show compiled in modules
-q               Quiet-mode.  Suppress HTTP Header output.
-s               Display colour syntax highlighted source.
-v               Version number
-w               Display source with stripped comments and whitespace.
-z <file>        Load Zend extension <file>.
```

## Related Links

If you are interested in learning more about crons, please check out the following sources:

* [Newbie: Intro to cron](http://www.unixgeeks.org/security/newbie/unix/cron-1.html)
* [cron - Wikipedia](https://en.wikipedia.org/wiki/Cron)
* [cPanel Tutorial: Cron Jobs](http://www.siteground.com/tutorials/cpanel/cron_jobs.htm)
* [Cron Jobs - Cron Jobs In Cpanel](http://www.trap17.com/index.php/cron-jobs-cron-jobs-cpanel_t6321.html)
