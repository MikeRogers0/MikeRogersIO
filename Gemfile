source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Hello! This is where you manage which Bridgetown version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Bridgetown with `bundle exec`, like so:
#
#   bundle exec bridgetown serve
#
# This will help ensure the proper Bridgetown version is running.
#
# To install a plugin, simply run bundle add and specify the group
# "bridgetown_plugins". For example:
#
#   bundle add some-new-plugin -g bridgetown_plugins
#
# Happy Bridgetowning!

gem "bridgetown"#, github: "bridgetownrb/bridgetown", branch: "main"

gem "htmlcompressor"

gem "rubocop"

group :bridgetown_plugins do
  # gem "bridgetown-inline-svg" # Breaks a bunch right now.
  gem "bridgetown-feed"
  gem "bridgetown-seo-tag"
end
