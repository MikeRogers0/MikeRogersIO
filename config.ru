require 'yaml'
require 'rack/jekyll'

run Rack::Jekyll.new()

#if ENV['POW_TIMEOUT']
  #watcher = fork do
    #exec('bundle exec jekyll build --watch')
  #end
  #Process.detach(watcher)
#end
