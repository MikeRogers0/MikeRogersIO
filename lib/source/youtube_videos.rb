require 'net/http'

class Source::YoutubeVideos
  def add_new_videos!
    source_data.each do |video|
      Video.new(
        title: video["title"],
        video_id: video["videoId"],
        description: video["group"]["description"],
        published_at: Time.parse(video["published"])
      ).save
    end
  end

  private

  # Use a public feed to avoid API keys.
  def feed_url
    "https://www.youtube.com/feeds/videos.xml?channel_id=UCeYdh6WLzE88DSvk0yZ_k1w"
  end

   def source_data
    @source_data ||= begin
      xml = Net::HTTP.get(URI.parse(feed_url))
      Hash.from_xml(xml)["feed"]["entry"]
    end
   end
end
