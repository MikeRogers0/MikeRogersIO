---
layout: post
title: PHP's Ctype Functions
tags:
- PHP
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'PHPs Ctype functions which validate strings quickly without regex.'
  index: true
---
A few days ago I was researching methods of validating alphanumeric strings and I was shown PHPs [Ctype Functions](http://www.php.net/manual/en/ref.ctype.php) by [Sebastian Roming](http://www.sebastianroming.de/).

In a nutshell they are a group of PHP functions why can be used to check strings to see if they are alphanumeric, numeric etc without using regex (So they are fast!). The key thing to remember is that they return TRUE or FALSE, unlike filter_var which returns FALSE or the string.

Here is the code example:

{% gist 2941974 ctypes-alpha-alnum.php %}

It also contains functions to check for just numeric strings, uppercase strings and lowercase strings.

{% gist 2941974 digit-upper-lower.php %}

Handy right?
