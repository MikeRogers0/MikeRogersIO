# frozen_string_literal: true

ruby File.read('.ruby-version').chomp

source 'https://rubygems.org' do
  gem 'dotenv'

  gem 'puma'
  gem 'rack-contrib'
  gem 'rake'

  gem 'middleman'
  gem 'middleman-blog'
  gem 'middleman-cdn'
  gem 'middleman-favicon-maker'
  gem 'middleman-imageoptim'
  gem 'middleman-minify-html'
  gem 'middleman-sitemap-ping'
  gem 'middleman-sprockets'
  gem 'middleman-syntax'

  gem 'redcarpet'
  gem 'liquid', require: false

  gem 'sass'
  gem 'sassc-rails'

  # Cross platform compatibility.
  gem 'tzinfo-data', platforms: %i[mswin mingw jruby]
  gem 'wdm', '~> 0.1', platforms: %i[mswin mingw]

  group :development do
    gem 'capistrano', '~> 3.11'
    gem 'capistrano-bundler', '~> 1.6'
    gem 'capistrano-logrotate'
    gem 'capistrano-rbenv', '~> 2.1'
    gem 'capistrano-yarn'
    gem 'capistrano3-puma'
  end
end
