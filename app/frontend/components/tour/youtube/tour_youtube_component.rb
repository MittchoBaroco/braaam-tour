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
    id = $1

    return "#{id.split("?").first}?start=#{calculate_start}" unless calculate_start.nil?
    return id
  end

  def calculate_start
    unless start_info = @link.split("t=").last
      return nil
    else
      start_info = @link.split("t=").last.scan(/\d+|\D+/)

      if start_info.include?("h")
        start_hour = start_info[0].to_i
        start_minute = start_info[2].to_i
        start_second = start_info[4].to_i

        return (start_hour * 3600) + (start_minute * 60) + start_second
      end

      if start_info.include?("m")
        start_minute = start_info[0].to_i
        start_second = start_info[2].to_i

        return (start_minute * 60) + start_second
      end

      if start_info.include?("s")
        start_minute = start_info[0].to_i

        return start_second
      end
    end
  end
end
