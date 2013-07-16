# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb
# Usage
# {% img /uploads/2009/06/apple_cant_do_math.jpg 700x478 "In the background ..." %}

module Jekyll
  class VimeoTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      if /(?<src>[^\s]+)/i =~ markup
        @src = src
      end
      super
    end

    def render(context)

      html = '<div class="resVid" style="max-width: 640px;">'
      html << '<iframe src="http://player.vimeo.com/video/'+@src+'" width="100%" height="100%" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
      html << '</div>'
      return html;

    end
  end
end

Liquid::Template.register_tag('vimeo', Jekyll::VimeoTag)