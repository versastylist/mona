class UserDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def next_registration_step
    case
    when not_registered?
      new_registration_path
    when not_answered_questions?
      # To be added once josh submits PR
      '/'
    when not_filled_out_payment?
      new_payment_info_path
    else
      root_path
    end
  end

  def profile_path
    object.stylist? ? stylist_path(object) : user_path(object)
  end

  private

  def not_registered?
    object.registration.nil?
  end

  def not_answered_questions?
    # object.questionnaire.blank?
    false
  end

  def not_filled_out_payment?
    object.payment_info.nil?
  end
end
