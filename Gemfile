ruby File.read('.ruby-version').chomp

source 'https://rubygems.org' do
  gem 'dotenv'

  gem 'middleman', '~> 4.3.5'
  gem 'middleman-blog'
  gem 'middleman-minify-html'
  gem 'middleman-sprockets'
  gem 'middleman-syntax'

  gem 'liquid', require: false
  gem 'redcarpet'

  gem 'sass'
  gem 'sassc-rails'
  gem 'sprockets', '~> 3.7.2'

  # Cross platform compatibility.
  gem 'tzinfo-data', platforms: %i[mswin mingw jruby]
  gem 'wdm', '~> 0.1', platforms: %i[mswin mingw]

  group :development, :test do
    gem 'capybara'
    gem 'rspec', '~> 3.9'
  end
end
