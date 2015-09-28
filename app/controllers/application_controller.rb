class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_permitted_paramters, if: :devise_controller?
  add_flash_types :info, :success, :warning, :danger

  def current_user
    if warden.authenticate
      user = super
      user.decorate
    else
      GuestUser.new
    end
  end

  def verify_completed_registration!
    unless current_user.completed_registration?
      flash[:warning] = "Make sure to complete your registration!"
      redirect_to current_user.next_registration_step
    end
  end

  def stylist_has_been_verified!
    unless current_user.verified_by_management?
      flash[:danger] = "You need to be verified by management first."
      redirect_to :back
    end
  end

  protected

  def devise_permitted_paramters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :agree_to_terms, :role]
  end
end
