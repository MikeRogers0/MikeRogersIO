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

# When in production, use the build folder.
if ENV['SERVE_STATIC'] && ENV['SERVE_STATIC'] == 'true'
  # Serve static files under a `build` directory:
  # - `/` will try to serve your `build/index.html` file
  # - `/foo` will try to serve `build/foo` or `build/foo.html` in that order
  # - missing files will try to serve build/404.html or a tiny default 404 page

  module Rack
    class Redirect
      def initialize(app)
        @app = app
      end

      def redirect(location)
        [301, { 'Location' => location, 'Content-Type' => 'text/html' }, ['Moved Permanently']]
      end

      def call(env)
        github_pull_requests = {
          'q' => [
            'is:closed',
            'is:pr',
            'author:MikeRogers0',
            'archived:false',
            'repo:thepracticaldev/dev.to',
            'repo:rubygems/rubygems.org',
            'repo:activeadmin/activeadmin',
            'repo:MindscapeHQ/raygun4ruby',
            'repo:thoughtbot/griddler-sendgrid',
            'repo:icoretech/omniauth-spotify',
            'repo:leighmcculloch/middleman-cdn',
            'repo:MiniProfiler/rack-mini-profiler',
            'repo:plataformatec/devise',
            'repo:rebelidealist/stripe-ruby-mock',
            'repo:devnacho/mountain_view',
            'repo:alphagov/frontend',
            'repo:alphagov/whitehall',
            'repo:alphagov/govuk_template',
            'repo:phatworx/devise_security_extension',
            'repo:mileszs/wicked_pdf',
            'author:MikeRogers0',
            'state:closed'
          ].join(' '),
          's' => 'created',
          'type' => 'Issues',
          'ref' => 'advsearch'
        }

        redirects = {
          '/wp-login.php' => '/',
          '/wp-admin' => '/',
          '/sitemap.html' => '/posts.html',
          '/my-pull-requests' => "https://github.com/search?#{github_pull_requests.to_param}"
        }
        req = Rack::Request.new(env)
        return redirect(redirects[req.path]) if redirects.include?(req.path)

        @app.call(env)
      end
    end
  end

  use Rack::TryStatic,
      root: 'build',
      urls: %w[/], try: ['.html', 'index.html', '/index.html'],
      header_rules: [
        [:all, {
          # 'X-Frame-Options' => 'SAMEORIGIN',
          'X-XSS-Protection' => '1; mode=block',
          'X-Content-Type-Options' => 'nosniff',
          'Content-Security-Policy' => ENV.fetch('CONTENT_SECURITY_POLICY') { "default-src 'self' https: blob:; font-src 'self' https: data:; img-src 'self' https: data:; object-src 'none'; worker-src 'self' blob: ; script-src 'self' https: 'unsafe-inline'; style-src 'self' https: 'unsafe-inline'; upgrade-insecure-requests" },
          'Strict-Transport-Security' => 'max-age=15552000; includeSubDomains',
          'Referrer-Policy' => 'no-referrer-when-downgrade',
          'Access-Control-Allow-Origin' => '*',
          'Cache-Control' => 'public, max-age=604800'
        }],
        [%w[png jpg js css svg woff ttf eot ico], { 'Cache-Control' => 'public, max-age=31536000' }],
        [['ico'], { 'Content-Type' => 'image/x-icon' }],
        [['svg'], { 'Content-Type' => 'image/svg+xml' }],
        [['woff'], { 'Content-Type' => 'application/font-woff' }],
        [['ttf'], { 'Content-Type' => 'application/x-font-ttf' }],
        [['eot'], { 'Content-Type' => 'application/vnd.ms-fontobject' }]
      ]

  use Rack::Redirect

  # Run your own Rack app here or use this one to serve 404 messages:
  run lambda { |_env|
    not_found_page = File.expand_path('build/404/index.html', __dir__)
    if File.exist?(not_found_page)
      [404, { 'Content-Type'  => 'text/html' }, [File.read(not_found_page)]]
    else
      [404, { 'Content-Type'  => 'text/html' }, ['404 - page not found']]
    end
  }

else
  # Otherwise run middleman server as a rack app.
  app = ::Middleman::Application.new
  run ::Middleman::Rack.new(app).to_app
end
