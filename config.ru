require 'yaml'
require 'rack/jekyll'

run Rack::Jekyll.new()

watcher = fork do
  exec('bundle exec jekyll build --watch')
end
Process.detach(watcher)
