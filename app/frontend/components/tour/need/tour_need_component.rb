module TourNeedComponent
  extend ComponentHelper
  property :value, required: true
  property :type, required: true

  def text
    type_content[:text_value]
  end

  def icon
    type_content[:icon_value]
  end

  private

  def type_content
    case @type
    when "need_tech_help"
      text_value = t ".true_need_tech_help" if @value.eql?(true)
      text_value = t ".false_need_tech_help" if @value.eql?(false)

      {
        icon_value: (c "fontawesome_icon", icon: "fas fa-cogs fa-lg"),
        text_value: text_value
      }
    when "catering"
      text_value = t ".true_catering" if @value.eql?(true)
      text_value = t ".false_catering" if @value.eql?(false)

      {
        icon_value: (c "fontawesome_icon", icon: "fas fa-utensils fa-lg"),
        text_value: text_value
      }
    when "housing"
      text_value = t ".true_housing" if @value.eql?(true)
      text_value = t ".false_housing" if @value.eql?(false)

      {
        icon_value: (c "fontawesome_icon", icon: "fas fa-bed fa-lg"),
        text_value: text_value
      }
    when "transport"
      text_value = t ".true_transport" if @value.eql?(true)
      text_value = t ".false_transport" if @value.eql?(false)

      {
        icon_value: (c "fontawesome_icon", icon: "fas fa-plane fa-lg"),
        text_value: text_value
      }
    when "tech_file"
      text_value = t ".open_tech_file"

      {
        icon_value: (c "fontawesome_icon", icon: "fas fa-file fa-lg"),
        text_value: link_to(text_value, @value, target: '_blank').html_safe
      }
    end
  end
end
