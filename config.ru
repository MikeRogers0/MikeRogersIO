require 'rubygems'
require 'bundler'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'middleman-core/load_paths'
::Middleman.setup_load_paths

require 'middleman-core'
require 'middleman-core/rack'
require 'rack/contrib'

require 'fileutils'
FileUtils.mkdir('log') unless File.exist?('log')
::Middleman::Logger.singleton("log/#{ENV['RACK_ENV']}.log")

# Otherwise run middleman server as a rack app.
app = ::Middleman::Application.new
run ::Middleman::Rack.new(app).to_app
