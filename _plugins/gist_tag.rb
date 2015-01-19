require 'open-uri'
require 'uri'

module Jekyll
  class GistTag < Liquid::Tag
    def initialize(tag_name, text, token)
      super
      @github_username = 'MikeRogers0'
      @text           = text
      @cache_disabled = false
      @cache_folder   = File.expand_path "../_gist_cache", File.dirname(__FILE__)
      FileUtils.mkdir_p @cache_folder
    end

    def render(context)
      if parts = @text.match(/([\d]*) (.*)/)
        gist, file = parts[1].strip, parts[2].strip
        script_url = script_url_for gist, file
        gist_url = link_url_for gist, file
        code       = get_cached_gist(gist, file) || get_gist_from_web(gist, file)
        html_output_for script_url, code, gist_url
      else
        ""
      end
    end

    def html_output_for(script_url, code, gist_url)
      code = CGI.escapeHTML code
      # Gists can be kinda slow to serve. 
      if code == ""
        "<script src='#{script_url}'></script>"
      else
        "<script src='#{script_url}'></script><noscript><div class=\"gistRaw\"><pre><code>#{code}</code></pre><a href=\"#{gist_url}\" class=\"url\" target=\"_blank\">View on Github</a></div></noscript>"
      end
    end

    def script_url_for(gist_id, filename)
      "https://gist.github.com/#{@github_username}/#{gist_id}.js?file=#{filename}"
    end

    def link_url_for(gist_id, filename)
      # Make the filename into an ancour.
      filename = filename.gsub('.', '-').gsub('--', '-').downcase
      "https://gist.github.com/#{gist_id}#file-#{filename}"
    end

    def get_gist_url_for(gist, file)
      "https://gist.github.com/#{@github_username}/#{gist}/raw/#{file}"
    end

    def cache(gist, file, data)
      cache_file = get_cache_file_for gist, file
      File.open(cache_file, "w") do |io|
        io.write data
      end
    end

    def get_cached_gist(gist, file)
      return nil if @cache_disabled
      cache_file = get_cache_file_for gist, file
      File.read cache_file if File.exist? cache_file
    end

    def get_cache_file_for(gist, file)
      bad_chars = /[^a-zA-Z0-9\-_.]/
      gist      = gist.gsub bad_chars, ''
      file      = file.gsub bad_chars, ''
      md5       = Digest::MD5.hexdigest "#{gist}-#{file}"
      File.join @cache_folder, "#{gist}-#{file}-#{md5}.cache"
    end

    def get_gist_from_web(gist, file)
      gist_url          = get_gist_url_for gist, file

      data = open(gist_url)
      data = data.read.force_encoding(Encoding::UTF_8)
      
      cache gist, file, data unless @cache_disabled
      data

    end
  end

  class GistTagNoCache < GistTag
    def initialize(tag_name, text, token)
      super
      @cache_disabled = true
    end
  end
end

Liquid::Template.register_tag('gist', Jekyll::GistTag)
Liquid::Template.register_tag('gistnocache', Jekyll::GistTagNoCache)
