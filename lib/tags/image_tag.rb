# Based upon @paulrobertlloyd's work https://github.com/Shopify/liquid/issues/507
# 
# Usage
# {% img src: /uploads/2009/06/apple_cant_do_math.jpg width: 700 alt: "In the background ..." %}
# or (title is optional)
# {% img src: /uploads/2009/06/apple_cant_do_math.jpg width: 700 alt: "In the background ..." title: "only 70%" %}

module Jekyll
  class ImgTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      @attributes = {}

      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value.gsub(/^'|"/, '').gsub(/'|"$/, '')
      end

      # Update the source to link correctly to CDN.
      if @attributes["src"].start_with?('/')
        @attributes["src"] = @attributes["src"]
      end

      super
    end

    def render(context)
      html = '<div class="res-img">'
        html << '<a href="' + ( @attributes["href"] || @attributes["src"] ) + '" target="_blank">'
          html << '<img src="' + @attributes["src"] + '" style="max-width: ' + @attributes["width"] + 'px;" alt="' + @attributes["alt"] + '"/>'
        html << '</a>'
        html << '<em>' + @attributes["title"] + '</em>' unless @attributes["title"].nil?
      html << '</div>'
      return html
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::ImgTag)
