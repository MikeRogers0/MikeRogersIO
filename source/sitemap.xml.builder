xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  ['/', '/posts.html', '/portfolio.html'].each do |resource|
    xml.url do
      xml.loc URI.join(root_url, resource)
      xml.lastmod Time.now.iso8601
    end
  end

  sitemap.resources.sort_by { |resource| File.mtime(resource.source_file).to_i * -1 }.each do |resource|
    xml.url do
      xml.loc URI.join(root_url, resource.url)
      last_mod = if resource.path.start_with?('20')
                   File.mtime(resource.source_file).to_time
                 else
                   Time.now
                 end
      xml.lastmod last_mod.iso8601
    end if resource.url.start_with?('/20') && resource.url !~ /\.(yml|json|xml|txt|ico|css|js|eot|svg|woff|ttf|png|jpg|jpeg|gif|keep)$/
  end
end
