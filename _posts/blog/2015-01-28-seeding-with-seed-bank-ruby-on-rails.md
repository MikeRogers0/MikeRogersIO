---
layout: post
title: Seeding with Seedbank
categories:
 – blog
published: true
meta:
  description: A video explaining how to use Seedbank in a rails project.
  index: true
tags: 
 - Rails
 - Seedbank
video_length: 13
---

{% youtube_playlist PLsqSLeo9DZwQaX4N64YIYtYzF_4sPkuRw %}

In this tutorial I explain [Seedbank](https://github.com/james2m/seedbank), a gem that I use regularly that helps keep the seeds in your project organised.

## Seeding class

To help keep the seed files as clean as possible, I've made a class that stops seeds being added twice and also outputs to the user what has been added to the database:

{% gist 640980264e980b52bab0 seeds.rb %}

Here is how to implement the class in your seeds:

{% gist 640980264e980b52bab0 users.seeds.rb %}


You can find all the code behind this tutorial in the [GitHub Repo](https://github.com/MikeRogers0/GenericApp/tree/refactoring-seeds).
