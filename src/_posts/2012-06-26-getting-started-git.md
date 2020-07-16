---
layout: post
title: Getting started with Git
description: A video of the talk I gave in April on getting started with Git
---
Git is a really powerful piece of version control software. Here is a short crash course on how to get started  on it, I presented at the University of Portsmouth in April 2012.

{% vimeo 42888074 %}

## What is version control?

Version control allows you to keep changes to files organised.

## What makes Git so great?

* Git is really fast, mostly because it keeps a database on your local machine.
* Git is great for collaborative changes to files, so it's great for teams.
* Distributed. Git uses remotes, so I can push to a main repo or I can push to my mates a repo.
* Adds a .git folder in the root of the git folder as a database, so unlike SVN it will not add a .git folder to each folder in your tree.
* You can commit parts of a file to staging you have worked on for better peer review.
* Git doesn't delete anything, so it's almost impossible to lose stuff you've worked on.

## Setting up Git (& SSH Keys)

GitHub have written a really good tutorial on [setting up Git on your OS](http://help.github.com/set-up-git-redirect/). For the most part, just you need to run through the installer using the default options.

## Cloning a Repo

Cloning a repo will copy it's files & history to your machine. Most git repos will provide you with a URL like `git@github.com:MikeRogers0/SiteEngines-Site.git`. The `foldername` is the directory you wish to clone to.

```bash
git clone URL foldername
```

## Reviewing & Staging Changes

Once you have some some edits, you can stage them (Add them into version control with a brief message about what you have done).

```bash
# Add all the new files in the repo into the next commit.
git add .

git commit -m 'Message Here'
```

or

```
git commit -a -m 'Message here'
```

## Branches

Branches are really powerful, they allow you to work on features independent from other peoples work. So for example, you could have someone adding a new feature to a site while the CSS is being edited in another branch &amp; you will not overwrite each others work. When your happy that the feature is done you can than merge is back into your master brach &amp; deploy it.

Review the branches available

```bash
git branch
```

Change branch

```bash
git checkout branchname
```

Make a new branch

```
git checkout -b branchname
```

## Merging

Git is really good at looking at changes in different versions of a file &amp; merging them together as to not cause errors.

```
git checkout master; git merge branchname;
```

## Pushing Changes

Pushing a branch updates a remote repo.

```
git push
```

## Pulling changes

Pulling changes will fetch what others have pushed to a repo &amp; merge them into your local git repo.

```
git pull
```

or

```
git fetch; git merge origin/branchname
```

## Useful videos

* [Introduction to Git with Scott Chacon of GitHub](http://www.youtube.com/watch?v=ZDR433b0HJY)
* [Quick start videos from Git-scm](http://git-scm.com/videos)
* [Deploying Your Git Repo To Arvixe Web Hosting](http://www.arlocarreon.com/blog/git/deploying-your-git-repo-to-arvixe-web-hosting/)
