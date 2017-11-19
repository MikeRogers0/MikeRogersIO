---
layout: post
title: How to setup a global .gitignore
published: true
categories:
 – blog
meta:
  description: How to setup a global gitignore which will help ignore annoying system files accorss all your git projects.
  index: true
---

The .gitignore file is really handy for stopping silly system files (like that pesky .DS_Store fella) from entering your git repository.  However, did you know you can setup a global .gitignore that'll apply across your system? 

## What to run in Terminal
It's pretty easy to set up a global .gitignore, simply just create a file containing your common .gitignore items and put it somewhere easily accessible on your system, then run in terminal:

{% gist 6406937 global-git-config.sh %}

Amending the 'PATH/TO/YOUR/' with the path to your .gitignore.

## Example global .gitignore
This is an example of the global .gitignore I use of my current system:

{% gist 6406937 .gitignore %}
