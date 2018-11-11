---
layout: post
title: Stop Rails log files growing
categories:
 – blog
published: true
meta:
  description: Ever looked at your log files & been like "Oh these are taking up lots of space"
  index: true
---

This week one of my colleagues opened a rails project they'd been working on for a while & noticed the `/log` folder had grown to over 60GB. 

Luckily, there are a bunch of approaches to help keep log files in check.

## Clearing logs each startup

Open the files `config/environments/development.rb` & `config/environments/test.rb`, in both those files add the line:

    # Stop the development logs from taking up to much space
    # https://stackoverflow.com/questions/7784057/ruby-on-rails-log-file-size-too-large/37499682#37499682
    config.logger = ActiveSupport::Logger.new(config.paths['log'].first, 1, 50.megabytes)

Now each time you startup your rails server it'll clear the log files. awesome!

## Clearing other logs

Lots of other apps create random log files also, if you'd like to clear those log files you can run:

    find ~/ -iname '*.log' -exec dd if=/dev/null of={} \;
