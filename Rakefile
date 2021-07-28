task :environment do
  require 'bundler'
  Bundler.setup

  require "active_support"
  require "active_support/core_ext"

  require './lib/source'
  require './lib/video'
end

namespace :update_data do
  desc 'Update the GitHub pull requests data file'
  task github_pull_requests: :environment do
    Source::GithubPullRequests.new.call
  end
end

namespace :update_data do
  desc 'Update the YouTube videos posts'
  task youtube_videos: :environment do
    Source::YoutubeVideos.new.add_new_videos!
  end
end
