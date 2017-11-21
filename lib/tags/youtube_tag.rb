# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb

module Jekyll
  class YoutubeTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      if /(?<src>[^\s]+)/i =~ markup
        @src = src
      end
      super
    end

    def render(context)

      html = '<div class="embed-responsive embed-responsive-16by9">'
      html << '<iframe class="embed-responsive-item" src="//www.youtube-nocookie.com/embed/'+@src+'?vq=hd720" frameborder="0" allowfullscreen></iframe>'
      html << '</div>'
      return html;

    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::YoutubeTag)
