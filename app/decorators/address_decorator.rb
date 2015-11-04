class AddressDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def type
    if object.primary
      h.content_tag(:span, 'Primary', class: 'label label-success')
    else
      h.content_tag(:span, 'Secondary', class: 'label label-info')
    end
  end

  def location
    if object.appt_num
      object.address + ' ' + object.appt_num
    else
      object.address
    end
  end

  def action_button
    if object.primary
      "Already Primary"
    else
      h.link_to 'Make Primary',
        user_address_path(h.current_user, object, address: { primary: true }),
        class: 'btn btn-success',
        method: :put
    end
  end
end
