---
layout: post
title: How to limit the size of Rails Logs
categories:
 – blog
published: true
meta:
  description: Rails log files growing to massive sizes? Limit them!
  index: true
---

This week one of my colleagues opened a Ruby on Rails project they'd been working on for a while & noticed the `/log` folder had grown to over 60GB, which was causing some pretty funky performance problems.

Luckily, there is a one line fix to help keep log files in check!

## How to limit logs to 50MB

Open the environment configuration files `config/environments/development.rb` & `config/environments/test.rb`, in both those files add the line:

    # Stop the development & test logs from taking up to much space
    # https://stackoverflow.com/questions/7784057/ruby-on-rails-log-file-size-too-large/37499682#37499682
    config.logger = ActiveSupport::Logger.new(config.paths['log'].first, 1, 50.megabytes)

This will tell Rails you'd like to limit your development & test log files to be at most 50 megabytes, so they should never get to out of control again! Awesome!

## Clearing other logs

Lots of other apps create random log files which eat up disk space, which are often hidden deep within your system. Here is a handy terminal command I sometimes run to reduce those log files to nothing:

    find ~/ -iname '*.log' -exec dd if=/dev/null of={} \;
