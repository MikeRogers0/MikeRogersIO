# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'MikeRogersIO'
set :repo_url, 'git@github.com:MikeRogers0/MikeRogersIO.git'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

# rbenv options
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, -> { "/home/ubuntu/var/www/#{fetch(:application)}" }

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/puma.rb', '.env'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, '.bundle', 'node_modules', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'build'

# Yarn - Make sure it works with our version of node
set :yarn_flags, '--production --silent --no-progress --ignore-engines'

# Puma
set :puma_conf, "#{shared_path}/config/puma.rb"

# Nginx, where the CDN (CloudFront) will look for our site.
set :nginx_server_name, 'mikerogersio.adhoc.mikerogers.io'
