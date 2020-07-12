# Based upon https://github.com/mrdanadams/jekyll-thumbnailer/blob/master/thumbnail.rb

class YoutubeTag < SiteBuilder
  def build
    liquid_tag "youtube", :youtube
  end

  def youtube(attributes, tag)
    html = '<div class="embed-responsive embed-responsive-16by9 mb-3">'
    html << '<iframe class="embed-responsive-item" src="//www.youtube-nocookie.com/embed/' + attributes[0] + '?vq=hd720" frameborder="0" allowfullscreen></iframe>'
    html << '</div>'
    html
  end
end
