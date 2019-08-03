xml.instruct!
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  xml.title 'Mike Rogers'
  xml.subtitle 'The occasional ramblings on programming and technology'
  xml.id URI.join(root_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(root_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(root_url, current_page.path), 'rel' => 'self'
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name 'Mike Rogers' }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link 'rel' => 'alternate', 'href' => URI.join(root_url, article.url)
      xml.id URI.join(root_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name 'Mike Rogers' }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, 'type' => 'html'
    end
  end
end
