# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb

module Jekyll
  class YoutubePlaylistTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      if /(?<src>[^\s]+)/i =~ markup
        @src = src
      end
      super
    end

    def render(context)

      html = '<div class="res-vid" style="max-width: 640px;">'
      html << '<iframe width="100%" height="100%" src="//www.youtube.com/embed/videoseries?list='+@src+'#vq=hd720" frameborder="0" allowfullscreen></iframe>'
      html << '</div>'
      return html;

    end
  end
end

Liquid::Template.register_tag('youtube_playlist', Jekyll::YoutubePlaylistTag)
