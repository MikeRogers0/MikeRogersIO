task :environment do
  require 'bundler'
  Bundler.setup

  require './lib/source'
end

namespace :update_data do
  desc 'Update the GitHub pull requests data file'
  task github_pull_requests: :environment do
    Source::GithubPullRequests.new.call
  end
end
