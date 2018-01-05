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
    ENV.fetch('URL') { 'https://mikerogers.dev' }
  end

  def current_url
    if current_page.url == '/'
      root_url + '/'
    else
      root_url + current_page.url[0..-1]
    end
  end
end

Dir[File.dirname(__FILE__) + '/lib/tags/*.rb'].each {|file| require file }
require 'lib/tilt/kramer_liquid_template'
set :markdown_engine, :kramer_liquid

activate :blog do |blog|
  blog.layout = 'post'
  blog.sources = 'blog/{year}-{month}-{day}-{title}.html'
  blog.permalink = '/{year}/{month}/{day}/{title}.html'
end

activate :favicon_maker, icons: {
  '_favicon_template.jpg' => [
    { icon: 'favicon.png', size: '16x16' },
    { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
  ]
}

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :autoprefixer do |prefix|
    prefix.browsers = 'last 2 versions'
  end

  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: %r{^(images|uploads)/.*}

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

  # Only invalidate HTML files.
  cdn.filter = /\.html/i

  # We only run this during the release task.
  cdn.after_build = false
end
