# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :sprockets
sprockets.append_path 'node_modules'

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def root_url
    ENV.fetch('URL') { 'https://mikerogersio.test' }
  end

  def current_url
    if current_page.url == '/'
      root_url + '/'
    else
      root_url + current_page.url[0..-1]
    end
  end
end

Dir[File.dirname(__FILE__) + '/lib/tags/*.rb'].each { |file| require file }
require 'lib/tilt/redcarpet_liquid_template'
require 'lib/markdown_helper/bootstrap_renderer'

activate :syntax
set :markdown_engine, :redcarpet_liquid
set :markdown, fenced_code_blocks: true, smartypants: true, tables: true, footnotes: true, renderer: MarkdownHelper::BootstrapRenderer

activate :blog do |blog|
  blog.layout = 'post'
  blog.sources = 'blog/{year}-{month}-{day}-{title}.html'
  blog.permalink = '/{year}/{month}/{day}/{title}.html'
end

# From https://github.com/follmann/middleman-favicon-maker
activate :favicon_maker, icons: {
  '_favicon_template.jpg' => [
    { icon: 'apple-touch-icon-180x180-precomposed.png' },             # Same as apple-touch-icon-57x57.png, for iPhone 6 Plus with @3× display
    { icon: 'apple-touch-icon-152x152-precomposed.png' },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
    { icon: 'apple-touch-icon-144x144-precomposed.png' },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
    { icon: 'apple-touch-icon-120x120-precomposed.png' },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
    { icon: 'apple-touch-icon-114x114-precomposed.png' },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
    { icon: 'apple-touch-icon-76x76-precomposed.png' },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
    { icon: 'apple-touch-icon-72x72-precomposed.png' },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
    { icon: 'apple-touch-icon-60x60-precomposed.png' },               # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
    { icon: 'apple-touch-icon-57x57-precomposed.png' },               # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
    { icon: 'apple-touch-icon-precomposed.png', size: '57x57' },      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
    { icon: 'apple-touch-icon.png', size: '57x57' },                  # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
    { icon: 'favicon-196x196.png' },                                  # For Android Chrome M31+.
    { icon: 'favicon-160x160.png' },                                  # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
    { icon: 'favicon-96x96.png' },                                    # For Google TV.
    { icon: 'favicon-32x32.png' },                                    # For Safari on Mac OS.
    { icon: 'favicon-16x16.png' },                                    # The classic favicon, displayed in the tabs.
    { icon: 'favicon.png', size: '16x16' },                           # The classic favicon, displayed in the tabs.
    { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },         # Used by IE, and also by some other browsers if we are not careful.
    { icon: 'mstile-70x70.png', size: '70x70' },                      # For Windows 8 / IE11.
    { icon: 'mstile-144x144.png', size: '144x144' },
    { icon: 'mstile-150x150.png', size: '150x150' },
    { icon: 'mstile-310x310.png', size: '310x310' },
    { icon: 'mstile-310x150.png', size: '310x150' }
  ]
}

set :fonts_dir, 'fonts'

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: %r{^(images|uploads)/.*}
  activate :imageoptim

  activate :minify_html do |html|
    html.remove_multi_spaces        = true   # Remove multiple spaces
    html.remove_comments            = true   # Remove comments
    html.remove_intertag_spaces     = false  # Remove inter-tag spaces
    html.remove_quotes              = false  # Remove quotes
    html.simple_doctype             = false  # Use simple doctype
    html.remove_script_attributes   = false  # Remove script attributes
    html.remove_style_attributes    = true   # Remove style attributes
    html.remove_link_attributes     = true   # Remove link attributes
    html.remove_form_attributes     = false  # Remove form attributes
    html.remove_input_attributes    = false  # Remove input attributes
    html.remove_javascript_protocol = true   # Remove JS protocol
    html.remove_http_protocol       = false  # Remove HTTP protocol
    html.remove_https_protocol      = false  # Remove HTTPS protocol
    html.preserve_line_breaks       = false  # Preserve line breaks
    html.simple_boolean_attributes  = true   # Use simple boolean attributes
    html.preserve_patterns          = nil    # Patterns to preserve
  end
  activate :gzip
end

activate :cdn do |cdn|
  cdn.cloudfront = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    distribution_id: ENV['AWS_CLOUDFRONT_DISTRIBUTION_ID']
  }

  # Only invalidate HTML, txt & RSS files.
  cdn.filter = /\.(html|rss|txt|xml)/i

  # We only run this during the release task.
  cdn.after_build = false
end

activate :sitemap_ping do |config|
  config.host         = ENV['URL']
  config.sitemap_file = 'sitemap.txt'
  config.after_build  = false
end
