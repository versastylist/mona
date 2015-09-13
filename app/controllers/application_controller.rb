class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_permitted_paramters, if: :devise_controller?

  protected

  def devise_permitted_paramters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :agree_to_terms]
  end
end
