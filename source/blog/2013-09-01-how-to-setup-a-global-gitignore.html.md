---
layout: post
title: How to setup a global .gitignore
published: true
categories:
 – blog
meta:
  description: How to setup a global gitignore which will help ignore annoying system files across all your git projects.
  index: true
---

The .gitignore file is really handy for stopping silly system files (like that pesky .DS_Store fella) from entering your git repository.  However, did you know you can setup a global .gitignore that'll apply across your system? 

## What to run in Terminal
It's pretty easy to set up a global .gitignore, simply just create a file containing your common .gitignore items and put it somewhere easily accessible on your system, then run in terminal:

```bash
git config --global core.excludesfile 'PATH/TO/YOUR/.gitignore'
```

Amending the 'PATH/TO/YOUR/' with the path to your .gitignore.

## Example global .gitignore
This is an example of the global .gitignore I use of my current system:

```
# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
############
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Icon?
ehthumbs.db
Thumbs.db
```
