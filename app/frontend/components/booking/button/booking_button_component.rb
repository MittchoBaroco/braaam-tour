module BookingButtonComponent
  extend ComponentHelper
  property :href, default: "#"

  def class_color
    case @color
    when "red"
      "red"
    when "green"
      "green"
    else
      "blue"
    end
  end
end
