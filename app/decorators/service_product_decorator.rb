class ServiceProductDecorator < ApplicationDecorator
  delegate_all

  def avatar(size)
    object.stylist.avatar_url(size)
  end

  def stylist_link
    h.link_to object.stylist.username, h.stylist_path(object.stylist)
  end

  def stylist_rating
    "5" # will be updated once we get stylist rating functionality
  end

end
