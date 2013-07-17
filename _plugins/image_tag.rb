# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb
# Usage
# {% img /uploads/2009/06/apple_cant_do_math.jpg 700x478 "In the background ..." %}

module Jekyll
  class ImgTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      if /(?<src>[^\s]+)\s+(?<dimensions>[^\s]+)\s+[?\"](?<alt>[^\"]+)/i =~ markup
        @src = src
        @alt = alt

        /(?<width>\d+)?x(?<height>\d+)?/ =~ dimensions

        @width = width
        @height = height

        # Update the source to link correctly to CDN.
        if src.start_with?('/')
          @src = Jekyll.configuration({})['cdn_uri'] + src
        end
      end
      super
    end

    def render(context)
      html = '<a href="'+@src+'" class="resImg" style="max-width: '+@width+'px; max-height: '+@height+'px;">'
      html << '<img src="'+@src+'" alt="'+@alt+'"/>'
      html << '</a>'
      return html;

    end
  end
end

Liquid::Template.register_tag('img', Jekyll::ImgTag)