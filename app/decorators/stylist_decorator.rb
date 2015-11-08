class StylistDecorator < ApplicationDecorator
  include Rails.application.routes.url_helpers
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

  def current_schedule_button
    if object.current_schedule.present?
      h.link_to 'Edit Current Schedule', edit_current_schedule_path, class: 'btn btn-warning'
    else
      h.link_to 'Add Current Schedule', new_current_schedule_path, class: 'btn btn-success'
    end
  end

  def future_schedule_button
    if object.future_schedule.present?
      h.link_to 'Edit Future Schedule', edit_future_schedule_path, class: 'btn btn-warning'
    else
      h.link_to 'Add Future Schedule', new_future_schedule_path, class: 'btn btn-success'
    end
  end

  def date_registered
    object.created_at.strftime('%B %d, %Y')
  end

  def verify_by_management_button
    if object.verified_by_management?
      h.content_tag(:span, 'verified', class: 'label label-success')
    elsif object.banned?
      h.content_tag(:span, 'banned', class: 'label label-danger')
    else
      h.link_to 'Verify!',
        verify_admin_stylist_path(object),
        class: 'btn btn-info',
        method: :post,
        data: { confirm: "Are you sure you're ready to confirm this stylist?" }
    end
  end

  # Can use these for the Sharing links.  Just need to get the sharing URI
  # and replace for the registration links

  # def facebook_link
    # if object.registration.facebook.present?
      # h.link_to object.registration.facebook, class: 'btn btn-primary' do
        # h.content_tag(:i, '', class: 'fa fa-facebook fa-2x')
      # end
    # end
  # end
end
