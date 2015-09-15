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
      new_client_registration_path
    when not_answered_questions?
      # To be added once josh submits PR
      '/'
    when not_filled_out_payment?
      # to be added once payments are done
      '/'
    else
      root_path
    end
  end

  private

  def not_registered?
    object.registration_process.include?('registration')
  end

  def not_answered_questions?
    object.registration_process.include?('questions')
  end

  def not_filled_out_payment?
    object.registration_process.include?('payment')
  end
end
