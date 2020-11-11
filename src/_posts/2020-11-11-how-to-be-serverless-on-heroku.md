---
layout: post
title: How To Be Serverless on Heroku
description: Did you know you can do serverless on Heroku? Here is how I managed it.
---

_TL;DR: I moved one of my sporadically run ActiveJob's in to a rake task that's run in a one-off Dyno via the Platform API._

On my [Typo CI](https://typoci.com/) project I analyse commits & PRs looking for spelling mistakes. The amount of commits in a given hour is quite irregular, on Monday mornings it can be quite a lot, while on a weekend it can end up just being a handful.

When I first started, I was processing all my Sidekiq jobs on a single worker instance. As the product grew, I experimented with moving the ActiveJob which processed the commits onto it's own dedicated worker instance. The end result was I had a web instance, a worker instance for processing small jobs & two instances for analysing commits.

My Heroku `Procfile` looked like:

```text
web: bundle exec rails s -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml
worker_file_processor: bundle exec sidekiq -C config/sidekiq_file_processor.yml
```

This was an _ok_ setup, but I'd occasionally get a rush of commits that lead to the queue getting backed up. Furthermore I calculated that in an average week, I was only processing commits for a total of 4 hours a day. So it felt kind of wasteful.

## What options did I have?

I've been messing around with AWS Lambda lately, which has a "Pay only when your code is running" approach. It's pretty decent for when you want to run tasks sporadically. That said, I didn't want to have to recode a big chunk of my app to work on AWS Lambda.

After a bit of research I started thinking about using [Heroku's One-Off Dynos](https://devcenter.heroku.com/articles/one-off-dynos). They're prorated to the second (like AWS Lambda), but I could utilise my existing Rails codebase without to much work to start using it. It could also run up to 50 tasks concurrently, which gave me a lot of room to scale.

## How did I use it?

I used Heroku's [platform-api](https://github.com/heroku/platform-api) gem to create a one-off dyno, which would run a rake task where I'd pass `ENV`'s with the information to process the correct commit.

Here is roughly what the code looked like:

```ruby
# app/jobs/heroku/run_one_off_commit_analysis_job.rb
require 'platform-api'
require 'rendezvous'

# This lets us run Commit::AnalysisJob in a one off Heroku dyno.
class Heroku::RunOneOffCommitAnalysisJob < ApplicationJob
  queue_as :heroku

  def perform(commit)
    @commit = commit

    if ENV['HEROKU_APP_ID'].present?
      run_in_one_off_dyno!
    else
      Commit::AnalysisJob.perform_later(@commit)
    end
  end

  private

  def run_in_one_off_dyno!
    dyno = platform_api.dyno.create(ENV['HEROKU_APP_ID'], {
                                      attach: true,
                                      env: {
                                        GITHUB_COMMIT_ID: @commit.id,
                                      },
                                      time_to_live: 10.minutes.to_i,
                                      command: run_command
                                    })

    rendezvous = Rendezvous.new(url: dyno['attach_url'])
    rendezvous.start
  end

  def run_command
    "bundle exec rake heroku:run_one_off_commit_analysis_job"
  end

  def platform_api
    @platform_api ||= PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH'])
  end
end
```

```ruby
# lib/tasks/heroku.rake
namespace :heroku do
  desc "Run Commit::AnalysisJob using ENV['GITHUB_COMMIT_ID'] as for the commit ID."
  task run_one_off_commit_analysis_job: [:environment] do
    commit = Commit.find(ENV['GITHUB_COMMIT_ID'])
    Commit::AnalysisJob.perform_now(@commit)
  end
end
```

## Did it pay off?

I managed to get the cost of processing commits down to about $2 a month, and it also allows me to process more commits simultaneously. I didn't have to do any big rewrites, nor change my deploy process (I just push to GitHub & Heroku does the rest). So it's a massive win!

It does kind of suck that this approach requires a Sidekiq worker to kick off & monitor the one-off dyno. It would be really interesting if I could move all my background jobs off to one-off dynos & avoid having to run sidekiq workers altogether (I think it could be possible).
