module TourYoutubeComponent
  extend ComponentHelper
  property :link, required: true

  # source: https://github.com/reu/youtube_id/blob/master/lib/youtube_id.rb
  def youtube_id
    formats = [
      %r((?:https?://)?youtu\.be/(.+)),
      %r((?:https?://)?(?:www\.)?youtube\.com/watch\?v=(.*?)(&|#|$)),
      %r((?:https?://)?(?:www\.)?youtube\.com/embed/(.*?)(\?|$)),
      %r((?:https?://)?(?:www\.)?youtube\.com/v/(.*?)(#|\?|$)),
      %r((?:https?://)?(?:www\.)?youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b)
    ]

    @link.strip!
    formats.find { |format| @link =~ format } and $1
  end
end
