class AppointmentDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def start_time
    object.start_time.strftime('%B %d, %Y, at %I:%M %P')
  end

  def end_time
    object.end_time.strftime('%B %d, %Y, at %I:%M %P')
  end

  def stylist_link
    h.link_to object.stylist.username, stylist_path(object.stylist)
  end
end
