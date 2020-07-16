# From: https://github.com/bridgetownrb/bridgetown/blob/main/bridgetown-website/plugins/builders/tags.rb
# Usage
# {% svg /images/image.svg %}

class SvgTag < SiteBuilder
  def build
    liquid_tag "svg", :render
  end

  def render(_markup, _tag)
    super

    svg_path = File.join site.source, attributes[0].gsub("../", "")
    svg_lines = File.readlines(svg_path).map(&:strip).select do |line|
      line unless line.start_with?("<!", "<?xml")
    end
    svg_lines.join
  end
end
