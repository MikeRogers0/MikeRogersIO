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
      @attributes['src'] = @attributes['src'] if @attributes['src'].start_with?('/')

      super
    end

    def render(_context)
      html = '<figure class="figure d-block">'
      html << '<a href="' + (@attributes['href'] || @attributes['src']) + '" target="_blank">'
      html << '<img src="' + @attributes['src'] + '" class="figure-img img-fluid rounded mx-auto d-block" alt="' + @attributes['alt'] + '" width="' + @attributes['width'] + '"/>'
      html << '</a>'
      html << '<figcaption class="figure-caption text-center">' + @attributes['title'] + '</figcaption>' unless @attributes['title'].nil?
      html << '</figure>'
      html
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::ImgTag)
