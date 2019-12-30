# frozen_string_literal: true

ruby File.read('.ruby-version').chomp

source 'https://rubygems.org' do
  gem 'dotenv'

  gem 'puma'
  gem 'rack-contrib'
  gem 'rake'

  gem 'middleman', '~> 4.3.5'
  gem 'middleman-blog'
  gem 'middleman-cdn'
  gem 'middleman-favicon-maker'
  gem 'middleman-imageoptim'
  gem 'middleman-minify-html'
  gem 'middleman-sitemap-ping'
  gem 'middleman-sprockets'
  gem 'middleman-syntax'

  gem 'liquid', require: false
  gem 'redcarpet'

  gem 'sprockets', '~> 3.7.2'
  gem 'sass'
  gem 'sassc-rails'

  # Cross platform compatibility.
  gem 'tzinfo-data', platforms: %i[mswin mingw jruby]
  gem 'wdm', '~> 0.1', platforms: %i[mswin mingw]

  group :development do
    gem 'capistrano', '~> 3.11'
    gem 'capistrano-bundler'
    gem 'capistrano-logrotate'
    gem 'capistrano-rbenv'
    gem 'capistrano-yarn'
    gem 'capistrano3-puma'
  end

  group :development, :test do
    gem 'capybara'
    gem 'rspec', '~> 3.9'
  end
end
