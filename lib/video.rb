require "yaml"

class Video
  def initialize(title:, video_id:, description:, published_at:)
    @title = title
    @video_id = video_id
    @description = description
    @published_at = published_at
  end

  def save
    File.open(file_path, (File::CREAT | File::TRUNC | File::WRONLY)) do |file|
      file.write(YAML.dump({
        "layout" => "video",
        "title" => @title,
        "video_id" => @video_id,
        "published_at" => @published_at.iso8601
      }))
      file.write("---\n")
      file.write(@description)
    end
  end

  private

  def slug
    @title.parameterize
  end

  def date
    @published_at.to_date
  end

  def file_path
    @file_path ||= File.join(File.dirname(__FILE__), "../src/_videos/", "#{date}-#{slug}.md")
  end
end
