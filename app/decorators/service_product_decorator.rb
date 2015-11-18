class ServiceProductDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all

  def avatar(size)
    object.stylist.avatar_url(size)
  end

  def stylist_availability
    if object.stylist.has_current_schedule?
      content_tag(:span, 'Active', class: 'label label-success')
    else
      content_tag(:span, 'Inactive', class: 'label label-danger')
    end
  end

  def stylist_link
    link_to object.stylist.username, stylist_path(object.stylist)
  end

  def stylist_rating
    StylistDecorator.new(object.stylist).total_rating
  end

  def duration
    "#{object.minute_duration} mins"
  end

  def display_price
    number_to_currency object.price
  end
end
