class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builder
  attr_reader :attributes

  def render(markup, tag)
    set_attributes!(markup)
  end

  def set_attributes!(markup)
    @attributes = {}
    markup.scan(Liquid::TagAttributes) do |key, value|
      @attributes[key] = value.gsub(/^'|"/, '').gsub(/'|"$/, '')
    end

    markup.split(' ').each.with_index do |value, index|
      @attributes[index] = value
    end
  end
end
