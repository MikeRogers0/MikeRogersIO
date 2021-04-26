require "rmagick"
require "shellwords"

class SocialImageBuilder < SiteBuilder
  def build
    return if config[:watch] # don't run in "watch mode"

    # Add the image to the post meta
    hook :site, :pre_render do
      site.posts.docs.each do |post|
        post.data[:image] ||= "/images/socials/#{post.data[:slug]}.png"
      end
    end

    hook :site, :post_write do
      create_social_directory!

      site.posts.docs.each do |post|
        render_social_image_from_post(post)
      end
    end
  end

  private

  def render_social_image_from_post(post)
    result_svg_string = Liquid::Template.parse(sample_svg).render("post" => {"title" => CGI.escapeHTML(post.data[:title])})
    dest_svg = File.join(image_dest_path, "#{post.data[:slug]}.svg")
    dest_png = File.join(image_dest_path, "#{post.data[:slug]}.png")
    File.write(dest_svg, result_svg_string)

    rendered_png = cache.getset(result_svg_string) do
      create_png_from_svg(dest_svg, dest_png)
      File.open(dest_png).read
    end

    File.write(dest_png, rendered_png)
  end

  def create_png_from_svg(input_svg, dest_png)
    #  export CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    system("#{::Shellwords.escape ENV["CHROME_PATH"]} --headless --screenshot --window-size=1280,640 --screenshot=#{dest_png} file://#{input_svg}")
  end

  def create_social_directory!
    FileUtils.mkdir_p(image_dest_path)
  end

  def sample_svg
    @svg_image = File.read(social_image_path)
  end

  def social_image_path
    File.join(site.source, "_data", "social-sample.svg")
  end

  def image_dest_path
    File.join(site.dest, "images", "socials")
  end

  def cache
    @cache ||= Bridgetown::Cache.new("SocialImages")
  end
end
