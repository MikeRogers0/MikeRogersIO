ruby File.read('.ruby-version').chomp

source 'https://rubygems.org' do
  gem 'dotenv'

  gem 'puma'
  gem 'rake'
  gem 'rack-contrib'

  gem 'middleman'
  gem 'middleman-autoprefixer'
  gem 'middleman-blog'
  gem 'middleman-minify-html'
  gem 'middleman-sprockets'
  gem 'middleman-cdn'
  gem 'middleman-sitemap-ping'
  gem 'middleman-favicon-maker'

  gem 'liquid', require: false

  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5', require: false

  gem 'font-awesome-sass', '~> 4.7.0'
  
  # Cross platform compatibility.
  gem 'tzinfo-data', platforms: %i[mswin mingw jruby]
  gem 'wdm', '~> 0.1', platforms: %i[mswin mingw]

  group :development do
    gem 'capistrano', '~> 3.11'
    gem 'capistrano-rbenv', '~> 2.1'
    gem 'capistrano-bundler', '~> 1.3'
    gem 'capistrano3-puma'
    gem 'capistrano-yarn'
    gem 'capistrano-logrotate'
  end
end
