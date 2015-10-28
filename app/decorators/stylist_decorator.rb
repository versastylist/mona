class StylistDecorator < Draper::Decorator
  delegate_all

  def total_rating
    if object.stylist_reviews.count > 0
      "#{object.stylist_reviews.average(:rating).round(2)} / 5"
    else
      'Not yet rated'
    end
  end

  def num_reviews
    object.stylist_reviews.count
  end

  # def registration_reminder
    # unless object.completed_registration?
      # h.content_tag(:li, {}) do
        # "You still havn't finished your registration"
      # end
    # end
  # end

  # Can use these for the Sharing links.  Just need to get the sharing URI
  # and replace for the registration links
  # def facebook_link
    # if object.registration.facebook.present?
      # h.link_to object.registration.facebook, class: 'btn btn-primary' do
        # h.content_tag(:i, '', class: 'fa fa-facebook fa-2x')
      # end
    # end
  # end

  # def linked_in_link
    # if object.registration.linked_in.present?
      # h.link_to object.registration.linked_in, class: 'btn btn-info' do
        # h.content_tag(:i, '', class: 'fa fa-linkedin fa-2x')
      # end
    # end
  # end
end
