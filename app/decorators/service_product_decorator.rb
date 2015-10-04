class ServiceProductDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all

  def avatar(size)
    object.stylist.avatar_url(size)
  end

  def stylist_link
    link_to object.stylist.username, stylist_path(object.stylist)
  end

  def stylist_rating
    "5" # will be updated once we get stylist rating functionality
  end

  def duration
    "#{object.minute_duration} mins"
  end

  def display_price
    number_to_currency object.price
  end

  # def add_to_cart
    # h.link_to root_path, class: 'btn btn-success' do
      # h.content_tag(:i, ' Add', class: 'fa fa-plus')
    # end
  # end
end
