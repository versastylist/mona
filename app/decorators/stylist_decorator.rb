class StylistDecorator < Draper::Decorator
  delegate_all

  def facebook_link
    if object.registration.facebook.present?
      h.link_to object.registration.facebook, class: 'btn btn-primary' do
        h.content_tag(:i, '', class: 'fa fa-facebook fa-2x')
      end
    end
  end

  def linked_in_link
    if object.registration.linked_in.present?
      h.link_to object.registration.linked_in, class: 'btn btn-info' do
        h.content_tag(:i, '', class: 'fa fa-linkedin fa-2x')
      end
    end
  end
end
