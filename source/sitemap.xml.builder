xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.each do |resource|
    xml.url do
      xml.loc URI.join(root_url, resource.url)
      last_mod = if resource.path.start_with?('20')
                   File.mtime(resource.source_file).to_time
                 else
                   Time.now
                 end
      xml.lastmod last_mod.iso8601
    end if resource.url !~ /\.(css|js|eot|svg|woff|ttf|png|jpg|jpeg|gif|keep)$/
  end
end
