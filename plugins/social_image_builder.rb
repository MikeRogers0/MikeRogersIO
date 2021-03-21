require "rmagick"

class SocialImageBuilder < SiteBuilder
  def build
    return if config[:watch] # don't run in "watch mode"

    # Add the image to the 
    hook :site, :pre_render do
      site.posts.docs.each do |post|
        post.data[:image] ||= "/images/socials/#{post.data[:slug]}.png"
      end
    end

    hook :site, :post_write do
      create_social_directory!

      site.posts.docs.each do |post|
        result_svg_string = Liquid::Template.parse(sample_svg).render("post" => { "title" => post.data[:title] })
        dest_svg = File.join(image_dest_path, "#{post.data[:slug]}.svg")
        File.write(dest_svg, result_svg_string)
        #img = Magick::Image.from_blob(result_svg_string) {
          #self.format = 'SVG'
          #self.background_color = 'transparent'
        #}
        #img.first.write(dest_svg)
      end
    end
  end

  private

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
end
