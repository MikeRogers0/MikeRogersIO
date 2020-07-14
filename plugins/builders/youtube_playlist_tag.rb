# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb

class YoutubePlaylistTag < SiteBuilder
  def build
    liquid_tag "youtube_playlist", :render
  end

  def render(_markup, _tag)
    super

    html = '<div class="embed-responsive embed-responsive-16by9 mb-3">'
    html << '<iframe width="100%" height="100%" src="//www.youtube-nocookie.com/embed/videoseries?list=' + attributes[0] + '#vq=hd720" frameborder="0" allowfullscreen></iframe>'
    html << '</div>'
    html
  end
end
