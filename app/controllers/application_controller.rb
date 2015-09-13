class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_permitted_paramters, if: :devise_controller?
  add_flash_types :info, :success, :warning, :danger

  protected

  def devise_permitted_paramters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :agree_to_terms, :role]
  end
end
