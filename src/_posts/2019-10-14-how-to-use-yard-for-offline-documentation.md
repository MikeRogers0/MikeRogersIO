---
layout: post
title: How to use Yard for offline documentation
description: I like to work offline, this documents my current setup & how I'm using puma-dev to make it effortless.
---

I like being able to work offline, there is something quite reassuring about being able to sit on a train and still get on with my daily tasks without being dependent on a solid internet connection.

When working, a good part of my day is reading ruby gem documentation, so having that available offline is super helpful.

A tool I've recently started using to make this easier is [Yard](https://yardoc.org/). Yard is pretty magical, but pretty much it looks at the code & comments of your local gems, then serves them in a nice bowser based UI. If you've ever used [rubydoc.info](https://rubydoc.info/) it's what powers it behind the scenes.

Yard is really fun to get setup locally!

## Getting setup

To get started, you need to install the [yard](https://github.com/lsegal/yard) gem.

```bash
gem install yard
```

You may also need to generate the Rdoc files, you can do this by running:

```bash
gem rdoc --all
```

Next you can turn on the yard server by running:

```bash
yard server --gems
```

This will output a URL where you can read all the documentation for the gems you have installed locally, awesome!

## Using it with puma-dev

Having to turn on the yard server every time you want to lookup some information is a little tedious, so I setup a [project on GitHub](https://github.com/MikeRogers0/Yard-Docs) you can setup locally.

It uses puma-dev so it'll turn on the yard server & serve you the documentation when you visit `http://yard-docs.test/` on your local machine.
