module Filters
  module Youtube
    def youtube_description(input)
      input.split('<h1 id="chapters">Chapters</h1>').first
        .force_encoding("utf-8")
        .gsub("<h3", "<h4")
        .gsub("</h3>", "</h4>")
        .gsub("<h2", "<h3")
        .gsub("</h2>", "</h3>")
        .gsub("<h1", "<h2")
        .gsub("</h1>", "</h2>")
        .gsub(/(https:\/\/\S+)/, '<a href="\1" target="_blank" rel="noopener">\1</a>')
        .gsub(/<p>➡(.*)<\/p>/m, '<ul>➡\1</ul>')
        .gsub(/➡(.*?)\n/, '<li>\1</li>')
    end
  end
end

Liquid::Template.register_filter(
  Filters::Youtube
)
