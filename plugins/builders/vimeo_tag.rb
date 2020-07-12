class VimeoTag < SiteBuilder
  def build
    liquid_tag "vimeo", :vimeo
  end

  def vimeo(attributes, tag)
    html = '<div class="embed-responsive embed-responsive-16by9 mb-3">'
    html << '<iframe src="https://player.vimeo.com/video/' + attributes[0] + '" width="100%" height="100%" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
    html << '</div>'
    html
  end
end
