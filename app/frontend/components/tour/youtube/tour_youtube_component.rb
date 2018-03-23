module TourYoutubeComponent
  extend ComponentHelper
  property :link, required: true

  def youtube_id
    @link.split("=").last
  end
end
